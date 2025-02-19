############################
### END_CHALLENGE.MCFUNCTION
############################

# Kill all zombies
kill @e[type=zombie]

# Set the time to day
time set 0

# Award 1,000,000 points to successful players (those who survived)
# Plus an extra 1 point
execute as @a[tag=GENERIC,scores={deaths=0}] run scoreboard players add @s game_score 1000001

# Display the winners
execute if entity @a[tag=GENERIC,scores={game_score=1000000..}] run say The winners are @a[tag=GENERIC,scores={game_score=1000000..}]!
execute unless entity @a[tag=GENERIC,scores={game_score=1000000..}] run say There are no winners this time since all participants died.

# Clear any scheduled functions since the game has ended
schedule clear custom:spawn_zombies

# Mark the game as over
scoreboard players set game_state game_score 1