##################################
### START_CHALLENGE.MCFUNCTION ###
##################################

# The function is being called by the watcher.js in the session manager. The custom:start_challenge command is what the watcher expects

scoreboard objectives add challenge dummy
scoreboard objectives add has_wood dummy
scoreboard objectives add has_stone dummy
scoreboard objectives add success dummy
scoreboard objectives add timer dummy
scoreboard objectives add assigned dummy
team add woodTeam
team add stoneTeam
scoreboard players set waiting_phase challenge 1
scoreboard players set game_active challenge 0
scoreboard players set @a assigned 0
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"text":"Challenge started, assigning teams...","color":"yellow"}]