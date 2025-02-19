summon armor_stand ~ ~ ~ {Tags:["random_pos"],Invisible:1b}
spreadplayers ~ ~ 0 10 false @e[type=armor_stand,tag=random_pos,limit=1]
execute at @e[type=armor_stand,tag=random_pos,limit=1] run setblock ~ ~ ~ chest{Items:[{Slot:13b,id:"minecraft:gold_ingot",Count:1b}]}
kill @e[type=armor_stand,tag=random_pos]
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"text":"A chest has been hidden within 10 blocks of spawn!","color":"yellow"}]