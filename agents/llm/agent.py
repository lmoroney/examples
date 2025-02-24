# this agent uses an LLM to decide what to do in a session
# it uses the openrouter API to get the LLM response

from kradle import (
   AgentManager,
   MinecraftAgent,
)
from kradle.models import MinecraftEvent
from dotenv import load_dotenv
import os
import requests
from prompts.config import (
  conversing_prompt,
  coding_prompt,
  conversation_examples,
  coding_examples,
  creative_mode_prompt
)

load_dotenv()


# let's define a model and persona for our agent
MODEL = "openai/gpt-4o" # refer to https://openrouter.ai/models for available models
PERSONA = "you are a helpful assistant" # check out some other personas in prompts/config.py

# plus some additional settings:

RESPOND_WITH_CODE = False # set this to true to have the llm generate runnable code instead of regular commands
DELAY_AFTER_ACTION = 100 # minimal delay after an action is performed. increase this if the agent is too fast or if you want more time to see the agent's actions

# your openrouter API key
OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")


class LLMBasedAgent(MinecraftAgent):

    username = "llm-agent" # this is the username of the agent
    display_name = "LLM Agent" # this is the display name of the agent
    description = "This is an LLM-based agent that can be used to perform tasks in Minecraft."

    # the is the first call that the agent gets when the session starts
    # agent_config contains all the instructions for the agent, starting with the task
    # the agent returns a list of events that it is interested in, which will later trigger the on_event function
    def init_participant(self, challenge_info):

        # self.memory is a utility instantiated for you 
        # that can be used to store and retrieve information
        # throughout the lifecycle of this participant. It is an instance of
        # the StandardMemory class in the kradle SDK

        #set task
        self.memory.task = challenge_info.task

        #set message lists
        self.memory.messages = []

        #set chat history
        self.memory.chat_history = []

        #set agent modes (e.g. creative mode, self_preservation, etc)
        self.memory.agent_modes = challenge_info.agent_modes

        #set action dictionary
        # here, we have commands and js_functions
        self.memory.commands = challenge_info.commands
        self.memory.js_functions = challenge_info.js_functions

        print(f"Initializing agent for participant ID: {self.participant_id} with slug: {self.username}")
        print(f"Persona: {PERSONA}")
        print(f"Model: {MODEL}")

        # let's log the init call to kradle using the
        # built in self.log() method from the MinecraftAgent class
        # self.log(
        #     {
        #         "persona": PERSONA,
        #         "model": MODEL,
        #         "respond_with_code": RESPOND_WITH_CODE
        #     }
        # )
    
        # Agent_config contains available_events
        return {'listenTo': [MinecraftEvent.MESSAGE, MinecraftEvent.COMMAND_EXECUTED]}

    # this function is called when an event occurs
    # the agent returns an action to be performed
    def on_event(self, observation):
        state_summary = self.format_state_summary(observation)
        print(f"\nState Summary:\n{state_summary}")
        print ("Task: ", self.memory.task)

        response = self.get_llm_response(state_summary, observation)
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
        if RESPOND_WITH_CODE:
            prompt = coding_prompt
        else:
            prompt = conversing_prompt

        #load task, persona, agent_modes, and commands from memory to build the prompt
        prompt = prompt.replace("$NAME", observation.name)
        prompt = prompt.replace("$TASK", self.memory.task)
        prompt = prompt.replace("$PERSONA", PERSONA)
        prompt = prompt.replace("$AGENT_MODE", str(self.memory.agent_modes))

        if RESPOND_WITH_CODE:    
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
                "model": MODEL,
                "messages": messages
            },
            timeout=30
        ).json()

        print(f"Response: {response}")

        if response["choices"]:
            content = response["choices"][0]["message"]["content"]
        else:
            content = "I'm sorry, I'm having trouble generating a response. Please try again later."


        # logging the llm call using the built in self.log() method
        # self.log(
        #     {
        #         "prompt": messages,
        #         "model": self.memory.model,
        #         "response": content
        #     }
        # )
        
        self.memory.messages.extend([
            {"role": "user", "content": state_summary},
            {"role": "assistant", "content": content}
        ])

        if RESPOND_WITH_CODE:
            return {"code": content, "delay": DELAY_AFTER_ACTION}
        return {"command": content, "delay": DELAY_AFTER_ACTION}

# This creates a web server and is available through a SSH tunnel
# the agent will be served at "/llm-agent"
connection_info = AgentManager.serve(LLMBasedAgent, create_public_url=True)
print(f"Started agent at URL: {connection_info}")
