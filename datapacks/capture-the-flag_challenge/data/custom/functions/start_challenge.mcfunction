##############################
### START_CHALLENGE.MCFUNCTION
##############################

# Set the time to day
time set 0

# Clear all red and blue wool blocks within a 4-chunk radius (64x64 blocks) and replace them with grass
fill -559 3 2912 -431 3 3040 minecraft:grass_block replace minecraft:red_wool
fill -559 3 2912 -431 3 3040 minecraft:grass_block replace minecraft:blue_wool

# Remove all banners within a 4-chunk radius
fill -559 3 2912 -431 3 3040 minecraft:air replace minecraft:red_banner
fill -559 3 2912 -431 3 3040 minecraft:air replace minecraft:blue_banner

# Remove old objectives if they exist
scoreboard objectives remove game_score
scoreboard objectives remove game_state
scoreboard objectives remove game_timer

# Create primary game_score objective
scoreboard objectives add game_score dummy

# Initialize game state (0 = ongoing, 1 = over)
scoreboard objectives add game_state dummy
scoreboard players set game_state game_score 0

# Create game_timer for tracking time (2400 ticks = 120 seconds)
scoreboard objectives add game_timer dummy
scoreboard players set game_timer game_score 2400

# Display the game_score scoreboard
scoreboard objectives setdisplay sidebar game_score

# Prevent mob spawning globally
gamerule doMobSpawning false

# Kill all existing mobs to start with a clean state
kill @e[type=!player]

# Create the blue base at spawn (5x5 square with a blue banner)
fill -497 3 2974 -493 3 2978 minecraft:blue_wool replace
setblock -495 4 2976 minecraft:blue_banner{Patterns:[{Pattern:"cs",Color:4},{Pattern:"bts",Color:11}]} replace

# Create the red base 42 blocks away from spawn in negative Z direction (5x5 square with a red banner)
fill -497 3 2937 -493 3 2933 minecraft:red_wool replace
setblock -495 4 2935 minecraft:red_banner{Patterns:[{Pattern:"cs",Color:1},{Pattern:"bts",Color:14}]} replace

# Game start announcements
tellraw @a {"text": "Capture the Flag challenge starting!", "color": "yellow"}
tellraw @a {"text": "The enemy's red flag is placed further ahead of your spawn. Break it and bring it back to your base to win!", "color": "green"}
tellraw @a {"text": "Break the enemy's red flag with the provided pickaxe and return it to your base!", "color": "red"}