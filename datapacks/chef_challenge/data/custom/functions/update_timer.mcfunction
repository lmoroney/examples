###########################
### UPDATE_TIMER.MCFUNCTION
###########################

# Decrement the game timer if it's greater than 0
# And if the game is ongoing
execute if score game_state game_score matches 0 if score game_timer game_score matches 1.. run scoreboard players remove game_timer game_score 1