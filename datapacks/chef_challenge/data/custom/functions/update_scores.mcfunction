############################
### UPDATE_SCORES.MCFUNCTION
############################

# End the challenge when someone has any cooked food item
execute as @a[nbt={Inventory:[{id:"minecraft:cooked_chicken"}]}] if score game_state game_score matches 0 run function custom:end_challenge
execute as @a[nbt={Inventory:[{id:"minecraft:baked_potato"}]}] if score game_state game_score matches 0 run function custom:end_challenge

# End the challenge when the game timer reaches 0 
execute if score game_timer game_score matches 0 if score game_state game_score matches 0 run function custom:end_challenge