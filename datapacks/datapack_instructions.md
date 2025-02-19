## This is an instruction set to create a datapack for a Minecraft game.

Code will have to be written in mcfunction files.

## Initial Structure

When creating a datapack, start with setting up the main structure:
```
📦 datapack_name
 ┣ 📂 data
 ┃ ┗ 📂 custom
 ┃ ┃ ┣ 📂 functions
 ┃ ┃   ┣ 📜 start_challenge.mcfunction
 ┃ ┃   ┣ 📜 init_participants.mcfunction
 ┃ ┃   ┣ 📜 end_challenge.mcfunction
 ┃ ┃   ┣ 📜 update_timer.mcfunction
 ┃ ┃   ┣ 📜 update_score.mcfunction
 ┃ ┃   ┣ 📜 update_participants.mcfunction
 ┃ ┃   ┗ 📜 update_arena.mcfunction
 ┃ ┗ 📂 minecraft
 ┃     ┗ 📂 tags
 ┃       ┗ 📂 functions
 ┃         ┗ 📜 tick.json
 ┗ 📜 pack.mcmeta
```

this needs to be in the //minecraft/minecraft_config/datapacks/datapack_name_challenge

you can look at the other datapacks for examples

## Challenges have the following rules
- Some games have a timeout, other don’t
- All participants have a main score
- Game ending conditions can be (a) a timeout, (b) a score being reached, (c) a number of participant left, or any combination of a, b, c
- Success for a participant can be:
  - if there's a timeout:
    - Maximizing a score during a given timeout
    - Being alive at the end of the timeout
  - if there's no timeout:
    - Being the first to reach a given score
    - Being part of the last n participants alive
- There can be multiple successful participants in a given session.


## Participants might have specific roles, in which case they have their own goals, scores, and initial setup
- in that case, participants will be assigned a role via a tag. this will be done outside of the datapack, before the init_role function is called.

## The datapack will have the following functions

### Init_participants.mcfunction
- can be empty if no specific setup is needed
- Equipping users with inventory, placing them in a specific spot, etc.
- if there are roles, should init role based on the player TAG
- best practice will be to create a function for each role, and then call the function for each player with the corresponding tag
    - /execute  @a[tag=ROLEA] init_role_ROLEA
    - /execute  @a[tag=ROLEB] init_role_ROLEB

### Start_challenge.mcfunction
- Required: Initialize game_score objective (stores generic game data with fake users)
- Required: Initialize game_score objective to zero for all participants, which will hold the main score for each participant
    - Game_score will be > 1000000 if the participant succeeded
- Required: Initialize fake user game_state on game_score -> 0 = ongoing, 1=over
- Optional: Initialize fake user game_timer on game_score (if there’s a time limit)
- Optional: Initialize secondary objectives that can affect primary objective
- Optional: Sets the initial conditions for the game (e.g. spawn a bunch of pigs)

### End_challenge.mcfunction
- Calculate game_score for each user. if there are roles, based on their role (by tag)
- User successful => game_score += 1000000
- Game_score for user game_state = 1 (over) - ALWAYS AFTER SETTING THE FINAL SCORE FOR EACH PLAYER

### On_tick.mcfunction
- Update_timer
- Update_score
- Update_participants
- Update_arena

### Update_timer.mcfunction
- can be empty if no timer is needed
- decrement game_timer
- If game_timer <0 => call end_challenge

### Update_score.mcfunction
- can be empty if no score is needed
- If game_score objective reached => call end_challenge
- If secondary objective reached (e.g. touched water) -> affect game_score or the participant (kick out participant)

### Update_participants.mcfunction
- can be empty if no participants check is needed
- for example, if less than n participants => call end_challenge

### Update_Arena.mcfunction 
- can be empty if no arena modifications are needed
- We want to make modifications to arena

### Tick.json
- This is the main function that will be called on each tick. It will call the other functions in the correct order. always put the json below:
 ```
  {
    "values": [
      "custom:update_timer",
      "custom:update_scores",
      "custom:update_participants",
      "custom:update_arena"
    ]
  }
``` 

### Pack.mcmeta
- This is the metadata for the datapack. It will be used to identify the datapack and its version.
```
{
  "pack": {
    "pack_format": 15,
    "description": "Datapack Name | Kradle"
  }
}
```