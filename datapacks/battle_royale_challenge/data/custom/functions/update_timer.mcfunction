# Decrement timer if game is ongoing
execute if score game_state game_score matches 0 run scoreboard players remove game_timer game_score 1

# End game if timer runs out
execute if score game_timer game_score matches ..0 run function custom:end_challenge 