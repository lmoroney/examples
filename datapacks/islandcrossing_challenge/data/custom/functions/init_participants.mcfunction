###################################
### INIT_PARTICIPANT.MCFUNCTION ###
###################################

# Kill all mobs
kill @e[type=!player]

# Set to day time
time set day

# Clear the player's inventory
clear @s

# Teleport all participants with GENERIC role to the starting island
execute as @s run tp @s 59 63 6

# Give 64 wooden planks. Need to specify CanPlaceOn since adventure mode default restricts placing blocks.
give @s minecraft:oak_planks 64
