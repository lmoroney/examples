################################
### END_CHALLENGE.MCFUNCTION ###
################################

# update game_data for each player, set it to 1000001 for participants with cooked food
execute as @p[nbt={Inventory:[{id:"minecraft:cooked_chicken"}]}] run scoreboard players add @s game_score 1000001
execute as @p[nbt={Inventory:[{id:"minecraft:baked_potato"}]}] run scoreboard players add @s game_score 1000001

# set game_over to 1
scoreboard players set game_state game_score 1

# announce winner only if someone has the winning score, otherwise announce no winner
execute if entity @p[scores={game_score=1000001..}] run tellraw @a {"text":"The winner is ","extra":[{"selector":"@p[scores={game_score=1000001..}]"},"!"]}
execute unless entity @p[scores={game_score=1000001..}] run tellraw @a {"text":"There is no winner because no participant was able to cook any food in time","color":"red"}