##################################
### START_CHALLENGE.MCFUNCTION ###
##################################

# Add objectives to track the custom statistic minecraft.custom which tracks fish caught
scoreboard objectives add fish_caught minecraft.custom:minecraft.fish_caught
scoreboard objectives add timer dummy

# Reset scores
scoreboard players reset @a fish_caught
scoreboard players set game_over timer 0

# Give fishing rod to all players in survival mode
give @a[gamemode=survival] fishing_rod

# Announce start
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"text":"First player to catch a fish wins!","color":"green"}]