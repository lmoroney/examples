##################################
### START_CHALLENGE.MCFUNCTION ###
##################################

# Watcher.js in the session service runs this commmand. It is the pattern custom:start_challenge that it looks for


# Add the necessary objectives
scoreboard objectives add pigs_farmed minecraft.killed:minecraft.pig

# Add the game_score objective
scoreboard objectives add game_score dummy

#initialize game_score for all players
execute as @a run scoreboard players set @s game_score 0

# Set the game timer to 1200 ticks (1 mn)
scoreboard players set game_timer game_score 1200

# Ensure game_over is set to 0
scoreboard players set game_state game_score 0

# Reset pigs_farmed scores for all players
scoreboard players reset @a pigs_farmed

# Announce the game start
say The Pig Farming Challenge has begun! First to farm 2 pigs is the winner!

# Spawn initial pigs for all players
execute as @p at @s run summon minecraft:pig ~2 ~ ~
execute as @p at @s run summon minecraft:pig ~-2 ~ ~
execute as @p at @s run summon minecraft:pig ~ ~ ~2
execute as @p at @s run summon minecraft:pig ~ ~ ~-2
execute as @p at @s run summon minecraft:pig ~2 ~ ~2
execute as @p at @s run summon minecraft:pig ~-2 ~ ~-2
