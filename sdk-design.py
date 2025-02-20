from typing import OrderedDict
from kradle import Kradle, MinecraftEvent, Observation, RedisMemory


########################################################
#
# A new instance of MyAgentClass is created every time this agent is added into a challenge session
# Kradle manages the creation and destruction (whole lifecycle) of these instances
#
########################################################
class MyAgentClass(Kradle.MinecraftAgent):

    # The SDK automatically calls this method when the agent is created (lifecycle beginning)
    def initialize(self, data):

        # We're extneding the class Kradle.MinecraftAgent. This class makes the following variables available to you
        self.participant_id  # You can add an agent to a session multiple times, each instance gets a unique 'participant_id'
        ## James Note: I really am inclined to call this 'instance_id' (vs teaching them another concept of a participant)

        self.username  # The username of this agent (eg. kradle.ai/my-username/agents/my-agent-username)
        self.session_id  # The id of the session we're currently in

        # Lets print those for debug purposes
        print(f"Participant {self.participant_id} with username: {self.username}) joined session {self.session_id}")

        # Pranay Q: we could also just prestore all this under "self.initial_data" ?
        print(f"Task {data.task}\nCommands {data.commands}\n")  # etc...

        # Leave it to the user to instantiate memory however they'd like. They can do their own thing
        self.memory = OrderedDict()
        # Or use our utilities
        self.memory = RedisMemory(session_id=self.session_id, participant_id=self.participant_id)
        # Or just pass in the entire participant instance
        self.memory = RedisMemory(self)
        # Or we can pre-create `self.memory` for them?
        # currently we already do this and it's always just StandardMemory

        self.participant_memory = RedisMemory(prefix=f"{self.session_id}/{self.participant_id}")
        self.session_memory = RedisMemory(prefix=f"{self.session_id}")
        self.global_memory = RedisMemory(prefix="global")

        # named tuple or dataclass that gets converted to json under the hood
        # listen_to -> listenTo (under the hood)
        return InitializeResponse(listen_to=[MinecraftEvent.MESSAGE, MinecraftEvent.COMMAND_EXECUTED])

    def on_event(self, obs: Observation):

        # OPTION A - direct access from self.
        self.memory.set("foo", 123)
        self.memory.get("bar")

        self.session_memory.set("foo", 123)
        self.session_memory.get()

        self.global_memory.set("foo", 123)
        self.global_memory.get()

        # OPTION B - always go through the memory object
        self.memory.participant.set("foo", 123)
        self.memory.session_memory.set("hive_memory", [obs.event])
        self.memory.global_memory.set("my_score", 1)  # across sessions

        # Shorthands
        self.memory.participant.foo = 123
        self.memory.session.hive_memory.append(obs.event)
        self.memory.global_memory.my_score += 1

        # Future, maybe allow access to other participants/session memory?
        self.memory.participant(participant_id).foo
        self.memory.session(session_id).foo


########################################################
# PROGRAMMATICALLY CREATE AN AGENT
########################################################

new_agent_parameters = {
    "name": "Simple Agent",
    "username": "simple-agent",
    "description": "A simple agent",
    "public": True,
    "url": "https://my-agent-lives-here.com",  # optional
}

# Errors if one already exists
response = Kradle.create_agent(**new_agent_parameters)

# Use this to update/overwrite an existing agent
response = Kradle.update_agent(**new_agent_parameters)

response = Kradle.delete_agent(username="simple-agent")

# What should be in the response?


# Just pass in the whole class - we handle the lifecycle
# Starts server in the background without blocking the thread
# Updates the URL of AGENT_USERNAME to point to this with Pinggy Tunneling
Kradle.serve_agent(MyAgentClass, agent_username="simple-agent")


# prod=True will prevent tunneling and setting the agent URL
# we need this when deploying to dedicated infra like a k8s cluster
Kradle.serve_agent(MyAgentClass, agent_username="simple-agent", prod=True)


# running serve_agent later with the same agent slug triggers a hot reload
# of the provided class - for good notebook development

# Q: what happens when serving multiple agents in one process?
# Kradle.serve_agent(AnotherBot, ANOTHER_AGENT_USERNAME)

########################################################
# Future Ideas
########################################################

# Spin up a batch of sessions
for i in range(10):
    Kradle.create_session(
        "team-kradle/pig-farming",
        [
            Participant(name="James", agent=AGENT_SLUG),
            Participant(name="Kemal", agent=AGENT_SLUG),
            Participant(name="Pranay", agent=AGENT_SLUG),
        ],
    )

# Later, support for other API methods like
# Kradle.get_session_status (or _url, or _data, etc..)
# Kradle.stop_session
# Kradle.create_challenge
# etc..


class ChattyBot(Kradle.MinecraftParticipant):
    def initialize(self, data):
        # No need to explicitly subscribe to any events
        return InitializeResponse()  # future proof for things we may want to return

    # Just define the functions for various events

    def on_message(self, message: MinecraftMessage):
        return EventResponse(command="")

    def on_command_executed(self, data: CommandResult):
        # pseudo:
        print(f"Completed command {data.command} with result {data.result}")
        return

    def on_gameover(self, result: GameResult):
        # Useful for completing an RL training loop
        return

    def on_event(self, obs: Observation):
        # keep this for backwards compatibility
        return
