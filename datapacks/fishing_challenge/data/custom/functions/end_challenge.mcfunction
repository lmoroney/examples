################################
### END_CHALLENGE.MCFUNCTION ###
################################

# End the game
scoreboard players set game_over timer 1

# Display completion message showing who caught the first fish
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"selector":"@p[scores={fish_caught=1..}]","color":"yellow"},{"text":" caught the first fish! Challenge complete!","color":"white"}]

# Display scores section start
tellraw @a [{"text": "[Challenge] ///SCORES_START///","color":"gold"}]

# Print scores for all non-watcher players
execute as @a[name=!watcher] run tellraw @a [{"text": "[Challenge] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text": "=","color":"white"},{"score":{"name":"@s","objective":"fish_caught"},"color":"yellow"}]

# Display scores section end
tellraw @a [{"text": "[Challenge] ///SCORES_END///","color":"gold"}]

# Send secret completion message to watcher
# This tells the backend server the challenge is complete
tell watcher "MFGER234234FMSDSA"