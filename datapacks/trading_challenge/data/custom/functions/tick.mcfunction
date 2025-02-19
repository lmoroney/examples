#######################
### TICK.MCFUNCTION ###
#######################

# Check if anyone has an emerald
execute if score game_over timer matches 0 as @a store result score @s emeralds run clear @s minecraft:emerald 0
execute if score game_over timer matches 0 as @a[scores={emeralds=1..}] run function custom:end_challenge