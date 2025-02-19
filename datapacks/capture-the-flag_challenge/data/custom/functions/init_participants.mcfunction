################################
### INIT_PARTICIPANTS.MCFUNCTION
################################

# Clear inventory
clear @a[name=!"watcher"]

# Set gamemode to adventure
gamemode survival @a[name=!"watcher"]

# Teleport to spawn point
tp @a[name=!"watcher"] -495 4 2976

# Set initial score
scoreboard players set @a[name=!"watcher"] game_score 0

# Fill hunger and saturation
effect give @a[name=!"watcher"] saturation 1 255 true