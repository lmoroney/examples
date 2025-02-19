#################################
### FAIL_CHALLENGE.MCFUNCTION ###
#################################

# The calling function for fail_challenge is custom:tick if the players run out of time

scoreboard players set game_active challenge 0
tellraw @a [{"text":"[Challenge] ","color":"gold"},{"text":"Time's up! The teams failed to work together.","color":"red"}]