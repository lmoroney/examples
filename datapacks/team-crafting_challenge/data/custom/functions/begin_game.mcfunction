scoreboard players set waiting_phase challenge 0
scoreboard players set game_active challenge 1
scoreboard players set timer challenge 12000
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"text":"Teams assigned! Challenge begins!","color":"green"}]
tellraw @a[team=woodTeam] [{"text":"[Challenge] ","color":"gold"},{"text":"You have wood! Find someone with stone to trade!","color":"yellow"}]
tellraw @a[team=stoneTeam] [{"text":"[Challenge] ","color":"gold"},{"text":"You have stone! Find someone with wood to trade!","color":"yellow"}]
tellraw @a[scores={assigned=1},team=] [{"text":"[Challenge] ","color":"gold"},{"text":"You are spectating this challenge","color":"aqua"}]