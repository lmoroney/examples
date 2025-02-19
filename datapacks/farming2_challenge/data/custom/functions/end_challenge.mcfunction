################################
### END_CHALLENGE.MCFUNCTION ###
################################

## rule is: pigslayers win if they kill 2 pigs, pigsavers win if nobody kills 2 pigs by the end of the game

# Store whether anyone has farmed 2 or more pigs into a temporary score
scoreboard players set temp_has_farmer game_score 0
execute if entity @a[scores={pigs_farmed=2..}] run scoreboard players set temp_has_farmer game_score 1

# If someone farmed 2+ pigs, give 1000000 points to pigslayers who farmed 2+ pigs
execute if score temp_has_farmer game_score matches 1 as @a[scores={pigs_farmed=2..},tag=pigslayer] run scoreboard players add @s game_score 1000000

# If no one farmed 2+ pigs, give 100000 points to all pigsavers
execute if score temp_has_farmer game_score matches 0 as @a[tag=pigsaver] run scoreboard players add @s game_score 1000000

# Add pigs_farmed score to everyone's game_score
execute as @a run scoreboard players operation @s game_score += @s pigs_farmed

# set game_over to 1 [ALWAYS AFTER SETTING THE FINAL SCORE FOR EACH PLAYER]
scoreboard players set game_state game_score 1

# announce the winner
say The winner is @p[scores={game_score=1000000..}]!