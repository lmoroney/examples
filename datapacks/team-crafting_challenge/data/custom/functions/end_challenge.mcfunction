################################
### END_CHALLENGE.MCFUNCTION ###
################################

# The function is being called by the check_progress function if the success scoreboard is 1 which means they crafted the stone pickaxe

# Setting the game to over since success criteria is met
scoreboard players set game_active challenge 0
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"text":"Success! The teams worked together to craft a pickaxe!","color":"green"}]

# Outputting the scores in the regex format that watcher.js understands in the session service
tellraw @a [{"text": "[Challenge] ///SCORES_START///","color":"gold"}]
execute as @a[name=!watcher] run tellraw @a [{"text": "[Challenge] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text": "=","color":"white"},{"score":{"name":"@s","objective":"success"},"color":"yellow"}]
tellraw @a [{"text": "[Challenge] ///SCORES_END///","color":"gold"}]


# Sending the secret code to the watcher that indicates the game is over
tell watcher "MFGER234234FMSDSA"