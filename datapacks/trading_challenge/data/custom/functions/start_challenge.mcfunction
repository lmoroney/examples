##################################
### START_CHALLENGE.MCFUNCTION ###
##################################

# Add objectives to track emeralds obtained
scoreboard objectives add emeralds dummy
scoreboard objectives add timer dummy

# Reset scores
scoreboard players reset @a emeralds
scoreboard players set game_over timer 0

# Give starting trade items to all players in survival mode
give @a[gamemode=survival] rotten_flesh 32
give @a[gamemode=survival] paper 24
give @a[gamemode=survival] stick 32

# Announce start
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"text":"First player to obtain an emerald through trading wins!","color":"green"}]