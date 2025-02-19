from kradle import (
   Kradle,               # Core Kradle functionality
   KradleMinecraftAgent, # Base class for agents  
   MinecraftEvent,       # Event types
   Commands,             # Common commands
   MC,                   # Minecraft blocks/items
   Observation,          # Observation structure
)
import os
from dotenv import load_dotenv

# this agent uses hardcoded actions
# it responds to private messages with a Hello World! chat message


# this is your agent's url namespace, which acts as a unique identifier. Make sure it matches the namespace on kradle.ai
AGENT_SLUG = "myfirstagent"


class MyFirstAgent(KradleMinecraftAgent):
    # the is the first call that the agent gets when the session starts
    # agent_config contains all the instructions for the agent, starting with the task
    # the agent returns a list of events that it is interested in, which will later trigger the on_event function
    def initialize_agent(self, agent_config):
       print (f"Initializing with task {agent_config.task}")
       
       # Specify events to receive:
       # - MESSAGE: When chat messages received
       return [MinecraftEvent.MESSAGE]

    # this function is called when an event occurs
    # the agent returns an action to be performed
    def on_event(self, observation: Observation):
       # It is either an COMMAND_EXECUTED or MESSAGE event
       print (f"Receiving an event observation about {observation.event}")
       
       # Called on subscribed events
       # Respond with a hello world message
       return {
           "chat": "Hello World!",
       }

# load the api key from the .env file
load_dotenv()
MY_API_KEY = os.getenv("KRADLE_API_KEY")
# set the api key to your kradle api key
Kradle.set_api_key(MY_API_KEY)

# This creates a web server and is available through a SSH tunnel
# the agent will be served at "/AGENT_SLUG"
connection_info = Kradle.serve_agent(MyFirstAgent, AGENT_SLUG)
print(f"Started agent at URL: {connection_info}")
