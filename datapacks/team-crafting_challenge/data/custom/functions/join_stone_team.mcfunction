team join stoneTeam @s
scoreboard players set @s assigned 1
give @s minecraft:cobblestone 3
tellraw @a [{"text":"[Debug] ","color":"gray"},{"text":"Assigning to stone team: ","color":"yellow"},{"selector":"@s","color":"green"}]