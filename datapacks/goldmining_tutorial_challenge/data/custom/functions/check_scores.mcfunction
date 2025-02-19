execute as @a[scores={mined_gold=1..}] run scoreboard players add @s total_mined 1
execute as @a[scores={mined_gold=1..}] run tellraw @a [{"text":"[Kradle] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text":" mined a gold block! ","color":"white"},{"score":{"name":"@s","objective":"total_mined"},"color":"yellow"},{"text":"/5","color":"white"}]
execute as @a[scores={mined_gold=1..}] run scoreboard players set @s mined_gold 0
execute if score game_over tutorial matches 0 as @a[scores={total_mined=5..}] run function custom:end_challenge