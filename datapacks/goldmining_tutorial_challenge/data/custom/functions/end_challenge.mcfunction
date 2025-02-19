scoreboard players set game_over tutorial 1
tellraw @a [{"text": "[Kradle] ///SCORES_START///","color":"white"}]
execute as @a run tellraw @a [{"text": "[Kradle] ","color":"white"},{"selector":"@s","color":"yellow"},{"text": "=","color":"white"},{"score":{"name":"@s","objective":"total_mined"},"color":"yellow"}]
tellraw @a [{"text": "[Kradle] ///SCORES_END///","color":"white"}]
tell watcher "MFGER234234FMSDSA"