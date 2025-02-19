##############################
### START_CHALLENGE.MCFUNCTION
##############################

# Remove old game_score primary objective and deaths secondary objective
scoreboard objectives remove game_score
scoreboard objectives remove deaths

# Clear any scheduled functions from previous runs
schedule clear custom:spawn_zombies

# Kill any existing zombies before starting the challenge
kill @e[type=zombie]

# Create standard game_score objective
scoreboard objectives add game_score dummy

# Create secondary deaths objective
scoreboard objectives add deaths deathCount

# Initialize game state
# game_state -> 0 = ongoing, 1 = over
scoreboard players set game_state game_score 0

# Initialize game_timer (2400 ticks = 120 seconds)
# 1 minute to build, 1 minute to survive
scoreboard players set game_timer game_score 2400

# Set initial score and deaths for all participants
execute as @a[tag=defender] run scoreboard players set @s game_score 0
execute as @a[tag=defender] run scoreboard players set @s deaths 0
execute as @a[tag=builder] run scoreboard players set @s game_score 0
execute as @a[tag=builder] run scoreboard players set @s deaths 0

# Initialize participants with starting resources
execute as @a[tag=defender] run function custom:init_participants
execute as @a[tag=builder] run function custom:init_participants

# Announce the challenge in chat
tellraw @a {"text": "Challenge starting! You have 60 seconds to build your cover before the wave of zombies come!", "color": "yellow"}

# Schedule zombie spawning in 60 seconds
schedule function custom:spawn_zombies 60s