###############################
### CHECK_SCORES.MCFUNCTION ###
###############################

# checks if the score of pigs_farmed is 2 or more for any player, if so, end the game
execute if score game_state game_score matches 0 as @p[scores={pigs_farmed=2..}] run function custom:end_challenge
