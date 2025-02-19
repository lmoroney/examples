scoreboard objectives add mined_gold minecraft.mined:minecraft.gold_block
scoreboard objectives add total_mined dummy
scoreboard objectives add tutorial dummy
scoreboard objectives add has_pickaxe dummy
scoreboard players set game_over tutorial 0
scoreboard players set @a total_mined 0
tellraw @a [{"text":"[Kradle] ","color":"gold"},{"text":"Challenge started! Mine 5 gold blocks.","color":"yellow"}]