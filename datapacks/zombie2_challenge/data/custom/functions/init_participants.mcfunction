################################
### INIT_PARTICIPANTS.MCFUNCTION
################################

# Clear inventory of each participant
clear @s

# Assign and equip items to Defender
execute as @a[tag=defender] run clear @s
execute as @a[tag=defender] run item replace entity @s weapon.mainhand with minecraft:diamond_sword
execute as @a[tag=defender] run item replace entity @s armor.head with minecraft:diamond_helmet
execute as @a[tag=defender] run item replace entity @s armor.chest with minecraft:diamond_chestplate
execute as @a[tag=defender] run item replace entity @s armor.legs with minecraft:diamond_leggings
execute as @a[tag=defender] run item replace entity @s armor.feet with minecraft:diamond_boots
execute as @a[tag=defender] run item replace entity @s weapon.offhand with minecraft:shield

# Assign items to Builder (no armor auto-equipping needed)
execute as @a[tag=builder] run clear @s
execute as @a[tag=builder] run give @s minecraft:oak_planks 128
execute as @a[tag=builder] run give @s minecraft:cobblestone 128
execute as @a[tag=builder] run give @s minecraft:torch 64
execute as @a[tag=builder] run item replace entity @s weapon.mainhand with minecraft:iron_pickaxe
execute as @a[tag=builder] run item replace entity @s weapon.offhand with minecraft:iron_axe
