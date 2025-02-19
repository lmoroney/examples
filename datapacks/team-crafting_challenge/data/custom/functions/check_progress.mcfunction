#################################
### CHECK_PROGRESS.MCFUNCTION ###
#################################

# The calling function for check_for_players is custom:tick if the game_active is 1

execute as @a store success score @s success run clear @s minecraft:stone_pickaxe 0
execute if entity @a[scores={success=1}] run function custom:end_challenge