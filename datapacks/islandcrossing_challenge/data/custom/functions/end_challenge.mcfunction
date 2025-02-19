############################
### END_CHALLENGE.MCFUNCTION
############################

# Give some points if participants reached the goal
execute as @a[tag=GENERIC,scores={reached_goal=1}] run scoreboard players add @s game_score 1000001

# Announce results for players who reached the goal
execute if entity @a[scores={reached_goal=1}] run tellraw @a [{"text":"[Challenge] ","color":"gold"},{"selector":"@a[scores={reached_goal=1}]","color":"yellow"},{"text":" reached the goal first! Challenge complete!","color":"white"}]

# Announce results for players who did not reach the goal
execute as @a[tag=GENERIC,scores={reached_goal=0}] run tellraw @a [{"text":"[Challenge] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text":" did not reach the goal. Better luck next time!","color":"red"}]

# End the game
scoreboard players set game_state game_score 1