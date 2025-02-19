################################
### END_CHALLENGE.MCFUNCTION ###
################################

# End the game
scoreboard players set game_over timer 1

# Display completion message showing who got the emerald first
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"selector":"@p[scores={emeralds=1..}]","color":"yellow"},{"text":" obtained the first emerald! Challenge complete!","color":"white"}]

# Display scores section start
tellraw @a [{"text": "[Challenge] ///SCORES_START///","color":"gold"}]

# Print scores for all non-watcher players
execute as @a[name=!watcher] run tellraw @a [{"text": "[Challenge] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text": "=","color":"white"},{"score":{"name":"@s","objective":"emeralds"},"color":"yellow"}]

# Display scores section end
tellraw @a [{"text": "[Challenge] ///SCORES_END///","color":"gold"}]

# Send secret completion message to watcher
tell watcher "MFGER234234FMSDSA"