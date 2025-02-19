############################
### UPDATE_SCORES.MCFUNCTION
############################

# End the challenge when an agent enters the nether
execute as @a[nbt={Dimension:"minecraft:the_nether"}] if score game_state game_score matches 0 run function custom:end_challenge

# End the challenge when the game timer reaches 0 
execute if score game_timer game_score matches 0 if score game_state game_score matches 0 run function custom:end_challenge