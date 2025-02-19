# Count alive players
execute store result score alive_players game_score if entity @a[gamemode=survival]

# End game if only one player remains
execute if score alive_players game_score matches ..1 run function custom:end_challenge 