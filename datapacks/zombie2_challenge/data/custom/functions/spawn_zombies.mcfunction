############################
### SPAWN_ZOMBIES.MCFUNCTION
############################

# Announce to players that zombies are coming
tellraw @a {"text": "Time's up! Here come the zombies!", "color": "red"}

# Set the time to night so that zombies don't catch on fire
time set night

# Spawn 4 zombies away from the clowest builder and defender
# For runs for closest participant to watcher with @p
execute at @p[tag=builder] run summon zombie ~10 ~ ~
execute at @p[tag=builder] run summon zombie ~-10 ~ ~
execute at @p[tag=builder] run summon zombie ~ ~ ~-10
execute at @p[tag=builder] run summon zombie ~ ~ ~10

execute at @p[tag=defender] run summon zombie ~10 ~ ~
execute at @p[tag=defender] run summon zombie ~-10 ~ ~
execute at @p[tag=defender] run summon zombie ~ ~ ~-10
execute at @p[tag=defender] run summon zombie ~ ~ ~10