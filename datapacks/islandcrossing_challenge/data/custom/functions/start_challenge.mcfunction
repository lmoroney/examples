##############################
### START_CHALLENGE.MCFUNCTION
##############################

# Remove old objectives
scoreboard objectives remove game_score
scoreboard objectives remove reached_goal
scoreboard objectives remove touched_water

# Remove GENERIC tags from previous runs
tag @a[tag=GENERIC] remove GENERIC

# Add all survival players to GENERIC role
tag @a[gamemode=survival] add GENERIC

# Create primary game_score objectives
scoreboard objectives add game_score dummy

# Create challenge-specific secondary objectives
scoreboard objectives add reached_goal dummy
scoreboard objectives add touched_water dummy

# Initialize game state
# game_state -> 0 = ongoing, 1 = over
scoreboard players set game_state game_score 0

# Remove any wooden planks within a 24-block cubic radius horizontally and 5 blocks vertically
execute positioned 82 63 24 run fill ~-24 ~-5 ~-24 ~24 ~5 ~24 air replace minecraft:oak_planks

# Initialize players with resources
execute as @a[tag=GENERIC] run function custom:init_participants

# Set scores for all GENERIC players
execute as @a[tag=GENERIC] run scoreboard players set @s reached_goal 0
execute as @a[tag=GENERIC] run scoreboard players set @s touched_water 0
execute as @a[tag=GENERIC] run scoreboard players set @s game_score 0

# Place the goal point (gold block) and marker
setblock 82 63 24 minecraft:gold_block
summon marker 82 63 24 {Tags:["goalpoint"]}

# Announce the challenge
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"text":"First player to reach the golden block without touching water wins!","color":"green"}]