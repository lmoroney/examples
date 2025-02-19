# Initialize objectives
scoreboard objectives add game_score dummy
scoreboard players set @a game_score 0
scoreboard players set #game_state game_score 0
scoreboard players set #game_timer game_score 24000

# Clear all player inventories
clear @a

# Randomly distribute weapons to players
# Give each player a random weapon from a predefined pool
execute as @a at @s run loot give @s loot custom:random_weapons

# Spread players in a 50x50 area
spreadplayers 0 0 25 25 false @a 


scoreboard objectives setdisplay sidebar game_score