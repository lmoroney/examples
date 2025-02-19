################################
### END_CHALLENGE.MCFUNCTION ###
################################

scoreboard players set game_active challenge 0

# Print the scores in the regex format that the watcher.js expects in Session-manager
tellraw @a [{"text": "[Challenge] ///SCORES_START///","color":"gold"}]
execute as @a[name=!watcher] run tellraw @a [{"text": "[Challenge] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text": "=","color":"white"},{"score":{"name":"@s","objective":"has_gold"},"color":"yellow"}]
tellraw @a [{"text": "[Challenge] ///SCORES_END///","color":"gold"}]


tell watcher "MFGER234234FMSDSA"