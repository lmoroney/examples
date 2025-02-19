# If there's exactly one player alive, they win
execute if score alive_players game_score matches 1 run scoreboard players add @a[gamemode=survival] game_score 1000000

# If time ran out and multiple players are alive, nobody wins
execute if score game_timer game_score matches ..0 if score alive_players game_score matches 2.. run tellraw @a {"text":"Time's up! No winner!","color":"red"} 

# Set game as over (this should always be last)
scoreboard players set game_state game_score 1 