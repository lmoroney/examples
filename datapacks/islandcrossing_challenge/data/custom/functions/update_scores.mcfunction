############################
### UPDATE_SCORES.MCFUNCTION
############################

# Check if any GENERIC participant touches water and the game isn't over
execute if score game_state game_score matches 0 as @a[tag=GENERIC,scores={touched_water=0}] at @s if block ~ ~ ~ minecraft:water run scoreboard players set @s touched_water 1

# Increment the touched_water score to 2 and kill any GENERIC participant who touches water
execute as @a[tag=GENERIC,scores={touched_water=1}] run kill @s
execute as @a[tag=GENERIC,scores={touched_water=1}] run scoreboard players set @s touched_water 2

# End the challenge only if all GENERIC players touch water
execute if score game_state game_score matches 0 unless entity @a[tag=GENERIC,scores={touched_water=0}] run function custom:end_challenge

# Check if any GENERIC participant reaches the goal and the game isn't over
execute if score game_state game_score matches 0 as @a[tag=GENERIC] at @s if entity @e[tag=goalpoint,distance=..10] run scoreboard players set @s reached_goal 1

# End the challenge if any GENERIC participant reaches the goal
execute if score game_state game_score matches 0 if entity @a[tag=GENERIC,scores={reached_goal=1}] run function custom:end_challenge