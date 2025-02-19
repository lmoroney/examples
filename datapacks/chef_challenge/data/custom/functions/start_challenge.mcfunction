##################################
### START_CHALLENGE.MCFUNCTION ###
##################################

# Remove existing tags
tag @a remove GENERIC

# Remove existing scoreboard objectives
scoreboard objectives remove game_score

# Clear entities and set world state
kill @e[type=!player]
gamerule doMobSpawning false
time set day

# Create new scoreboard objectives
scoreboard objectives add game_score dummy

# Set scoreboard display to sidebar
scoreboard objectives setdisplay sidebar game_score

# Tag all players in survival mode as GENERIC
tag @a[gamemode=survival] add GENERIC

# Set game state to 0 (game is running)
scoreboard players set game_state game_score 0

# Set timer to 2400 (120 seconds at 20 ticks per second)
scoreboard players set game_timer game_score 2400

# Display start message
tellraw @a {"text":"Chef Challenge starting! Cook any food item within 120 seconds! The first participant to have a cooked item back in their inventory wins!","color":"green"}

# Initialize all participants
execute as @a[tag=GENERIC] run function custom:init_participants