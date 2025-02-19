############################
### UPDATE_SCORES.MCFUNCTION
############################

# End the challenge when the game timer reaches 0 (players survive the entire duration)
execute if score game_timer game_score matches 0 if score game_state game_score matches 0 run function custom:end_challenge

# End the challenge if any player dies (failure state)
execute unless entity @a[tag=GENERIC,scores={deaths=0}] if score game_state game_score matches 0 run function custom:end_challenge