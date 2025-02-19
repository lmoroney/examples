execute as @a store success score @s has_gold run clear @s minecraft:gold_ingot 0
execute as @a[scores={has_gold=1}] run function custom:end_challenge