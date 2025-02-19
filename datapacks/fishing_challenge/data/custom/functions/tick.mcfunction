#######################
### TICK.MCFUNCTION ###
#######################

# Check if anyone caught a fish
execute if score game_over timer matches 0 as @a[scores={fish_caught=1..}] run function custom:end_challenge