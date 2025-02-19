####################################
### CHECK_FOR_PLAYERS.MCFUNCTION ###
####################################

# The calling function for check_for_players is custom:tick


# Initialize assigned score for new players
scoreboard players add @a assigned 0

# Mark excluded players which is "watcher" and anyone not in survival mode
scoreboard players set @a[name=watcher] assigned 1
scoreboard players set @a[gamemode=!survival] assigned 1

# Try to fill wood team first
execute unless entity @a[team=woodTeam] as @r[scores={assigned=0}] at @s run function custom:join_wood_team

# Then try to fill stone team
execute unless entity @a[team=stoneTeam] as @r[scores={assigned=0}] at @s run function custom:join_stone_team

# Start game if both teams are filled
execute if entity @a[team=woodTeam] if entity @a[team=stoneTeam] run function custom:begin_game