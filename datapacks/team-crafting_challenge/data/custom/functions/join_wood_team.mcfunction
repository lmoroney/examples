team join woodTeam @s
scoreboard players set @s assigned 1
give @s minecraft:oak_log 3
tellraw @a [{"text":"[Debug] ","color":"gray"},{"text":"Assigning to wood team: ","color":"yellow"},{"selector":"@s","color":"green"}]