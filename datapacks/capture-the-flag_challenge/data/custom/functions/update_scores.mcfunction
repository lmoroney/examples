############################
### UPDATE_SCORES.MCFUNCTION
############################

# End the challenge when the game timer reaches 0 (players survive the entire duration)
execute if score game_timer game_score matches 0 if score game_state game_score matches 0 run function custom:end_challenge

# End the challenge if a player is holding the red banner AND standing on blue wool
execute as @a[nbt={Inventory:[{id:"minecraft:red_banner"}]}] at @s if block ~ ~-0.1 ~ minecraft:blue_wool if score game_state game_score matches 0 run function custom:end_challenge