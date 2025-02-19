##################################
### START_CHALLENGE.MCFUNCTION ###
##################################

scoreboard objectives add challenge dummy
scoreboard objectives add has_gold dummy
scoreboard players set game_active challenge 1
scoreboard players set @a has_gold 0
function custom:place_chest
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"text":"Hunt begins! Find the hidden chest with gold!","color":"yellow"}]