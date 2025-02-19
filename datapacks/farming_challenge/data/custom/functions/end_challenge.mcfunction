################################
### END_CHALLENGE.MCFUNCTION ###
################################

# update game_data for each player, set it to 1000000 for each player that has pigs_farmed >= 2
# then add their pigs_farmed score to their game_score
execute as @p[scores={pigs_farmed=2..}] run scoreboard players add @s game_score 1000000
execute as @a run scoreboard players operation @s game_score += @s pigs_farmed

# set game_over to 1 [ALWAYS AFTER SETTING THE FINAL SCORE FOR EACH PLAYER]
scoreboard players set game_state game_score 1

# announce the winner
say The winner is @p[scores={game_score=1000000..}]!