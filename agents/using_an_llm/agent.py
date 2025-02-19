from kradle import Kradle, KradleMinecraftAgent, MC, Commands, RedisMemory, StandardMemory, MinecraftEvent
from prompts.config import conversing_prompt, coding_prompt, conversation_examples, coding_examples, creative_mode_prompt
import os
import requests
from dotenv import load_dotenv

load_dotenv()

# this agent uses an LLM to decide what to do in a session
# it uses the openrouter API to get the LLM response

# this is your agent's url namespace, which acts as a unique identifier. Make sure it matches the namespace on kradle.ai
AGENT_SLUG = "test2"

# first, define the persona and model
PERSONA = "you are a helpful assistant" #you can use the personas defined in the config.py file, e.g. personas['friendly']
MODEL = "openai/gpt-4o" #refer to https://openrouter.ai/models for available models
RESPOND_WITH_CODE = False #if set to true, the agent will respond with code. if set to false, the agent will respond with a command
DELAY_AFTER_ACTION = 100 #minimal delay after an action is performed. increase this if the agent is too fast or if you want more time to see the agent's actions

# your openrouter API key
OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")


class MyFirstLLMAgent(KradleMinecraftAgent):

    # the is the first call that the agent gets when the session starts
    # agent_config contains all the instructions for the agent, starting with the task
    # the agent returns a list of events that it is interested in, which will later trigger the on_event function
    def initialize_agent(self, agent_config):
        #define memory, standard memory is a good start
        self.memory = StandardMemory()

        #set task
        self.memory.task = agent_config.task

        #set message lists
        self.memory.messages = []

        #set chat history
        self.memory.chat_history = []

        #set agent modes (e.g. creative mode, self_preservation, etc)
        self.memory.agent_modes = agent_config.agent_modes

        #set action dictionary
        # here, we have commands and js_functions
        self.memory.commands = agent_config.commands
        self.memory.js_functions = agent_config.js_functions

        #set persona ad models
        self.memory.persona = PERSONA
        self.memory.model = MODEL

        #decide we will respond with code. if set to true, the agent will respond with javascript code. if set to false, the agent will respond with a command
        self.memory.RESPOND_WITH_CODE = RESPOND_WITH_CODE

        #minimal delay after an action is performed. increase this if the agent is too fast or if you want more time to see the agent's actions
        self.memory.DELAY_AFTER_ACTION = DELAY_AFTER_ACTION

        print(f"Initializing agent for participant ID: {self.participant_id} with slug: {self.slug}")
        print(f"Persona: {self.memory.persona}")
        print(f"Model: {self.memory.model}")

         # logging the init call       
        Kradle.create_log(
            session_id=agent_config.session_id,
            participant_id=agent_config.participant_id,
            level="initialize_agent",
            message= {
            "persona": self.memory.persona,
            "model": self.memory.model,
            "respond_with_code": self.memory.RESPOND_WITH_CODE
            }
        )
    
        # Agent_config contains available_events
        return [MinecraftEvent.MESSAGE, MinecraftEvent.COMMAND_EXECUTED]

    # this function is called when an event occurs
    # the agent returns an action to be performed
    def on_event(self, data):
        state_summary = self.format_state_summary(data)
        
        print(f"\nState Summary:\n{state_summary}")
        print ("Task: ", self.memory.task)
        response = self.get_llm_response(state_summary, data)
        print(f"Agent Response: {response}")
        print(f"Participant ID: {self.participant_id}")
        
        return response


    # this function converts an observation object into a string that can be used to build the prompt
    def format_state_summary(self, observation):
        self.memory.chat_history.extend(observation.messages)
        
        print(f"Messages: {self.memory.chat_history}")

        chat_summary = '\n'.join(
            f'{msg.sender}: {msg.message}' 
            for msg in self.memory.chat_history[-10:]
        ) if self.memory.chat_history else 'None'

        inventory_summary = ', '.join([
            f'{count} {name}' 
            for name, count in observation.inventory.items()
        ]) if observation.inventory else 'None'

        return (
            f"{observation.output if observation.output else 'Output: None'}\n\n"
            f"Chat: {chat_summary}\n\n"
            f"Visible Players: {', '.join(observation.players) if observation.players else 'None'}\n\n"
            f"Visible Blocks: {', '.join(observation.blocks) if observation.blocks else 'None'}\n\n"
            f"Inventory: {inventory_summary}\n\n"
            f"Health: {observation.health * 100}/100"
        )

    # this function builds the system prompt for the agent
    def format_system_prompt(self, observation):
        if self.memory.RESPOND_WITH_CODE:
            prompt = coding_prompt
        else:
            prompt = conversing_prompt

        #load task, persona, agent_modes, and commands from memory to build the prompt
        prompt = prompt.replace("$NAME", observation.name)
        prompt = prompt.replace("$TASK", self.memory.task)
        prompt = prompt.replace("$PERSONA", self.memory.persona)
        prompt = prompt.replace("$AGENT_MODE", str(self.memory.agent_modes))

        if self.memory.RESPOND_WITH_CODE:    
            prompt = prompt.replace("$CODE_DOCS", str(self.memory.js_functions))
            prompt = prompt.replace("$EXAMPLES", str(coding_examples))
        else:
            prompt = prompt.replace("$COMMAND_DOCS", str(self.memory.commands)) 
            prompt = prompt.replace("$EXAMPLES", str(conversation_examples))
            
            if self.memory.agent_modes['mcmode']=='creative':
                prompt = prompt.replace("$CREATIVE_MODE", creative_mode_prompt)
            else:
                prompt = prompt.replace("$CREATIVE_MODE", "You are in survival mode.")

        return prompt

    # this function send the prompt to the LLM and gets the response
    def get_llm_response(self, state_summary, observation):
        messages = [
            {"role": "system", "content": self.format_system_prompt(observation)},
            *self.memory.messages[-5:],
            {"role": "user", "content": state_summary}
        ]

        response = requests.post(
            "https://openrouter.ai/api/v1/chat/completions",
            headers={"Authorization": f"Bearer {OPENROUTER_API_KEY}"},
            json={
                "model": self.memory.model,
                "messages": messages
            }
        ).json()

        if response["choices"]:
            content = response["choices"][0]["message"]["content"]
        else:
            content = "I'm sorry, I'm having trouble generating a response. Please try again later."


        # logging the llm call
        Kradle.create_log(
            session_id=observation.session_id,
            participant_id=observation.participant_id,
            level="llm_response",
            message= {
                "prompt": messages,
                "model": self.memory.model,
                "response": content
            }
        )
        
        self.memory.messages.extend([
            {"role": "user", "content": state_summary},
            {"role": "assistant", "content": content}
        ])

        if self.memory.RESPOND_WITH_CODE:
            return {"code": content, "delay": self.memory.DELAY_AFTER_ACTION}
        return {"command": content, "delay": self.memory.DELAY_AFTER_ACTION}

# load the api key from the .env file
load_dotenv()
MY_API_KEY = os.getenv("KRADLE_API_KEY")
# set the api key to your kradle api key
Kradle.set_api_key(MY_API_KEY)

# This creates a web server and is available through a SSH tunnel
# the agent will be served at "/AGENT_SLUG"
connection_info = Kradle.serve_agent(MyFirstLLMAgent, AGENT_SLUG)
print(f"Started agent at URL: {connection_info}")
