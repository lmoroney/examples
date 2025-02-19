scoreboard objectives remove challenge
scoreboard objectives remove has_wood
scoreboard objectives remove has_stone
scoreboard objectives remove success
scoreboard objectives remove timer
scoreboard objectives remove assigned
team remove woodTeam
team remove stoneTeam
clear @a minecraft:oak_log
clear @a minecraft:cobblestone
clear @a minecraft:stone_pickaxe
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"text":"Challenge has been reset!","color":"yellow"}]