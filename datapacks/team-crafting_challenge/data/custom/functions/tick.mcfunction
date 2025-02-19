#######################
### TICK.MCFUNCTION ###
#######################

# The caller for tick.mcfunction is the tick.json tag

execute if score waiting_phase challenge matches 1 run function custom:check_for_players
execute if score game_active challenge matches 1 run function custom:check_progress
execute if score game_active challenge matches 1 if score timer challenge matches 0.. run scoreboard players remove timer challenge 1
execute if score timer challenge matches 0 run function custom:fail_challenge