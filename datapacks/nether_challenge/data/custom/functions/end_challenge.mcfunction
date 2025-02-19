################################
### END_CHALLENGE.MCFUNCTION ###
################################

# update game_data for each player, set it to 1000001 for players who reached the nether
execute as @p[nbt={Dimension:"minecraft:the_nether"}] run scoreboard players add @s game_score 1000001

# set game_over to 1
scoreboard players set game_state game_score 1

# announce winner only if someone has the winning score, otherwise announce no winner
execute if entity @p[scores={game_score=1000001..}] run tellraw @a {"text":"The winner is ","extra":[{"selector":"@p[scores={game_score=1000001..}]"},"!"]}
execute unless entity @p[scores={game_score=1000001..}] run tellraw @a {"text":"There is no winner because no participant was able to reach the Nether in time","color":"red"}