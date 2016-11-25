Revo Admin Stick
=======
Useful, configurable, and fully featured administration stick for DarkRP

Description
-------
This is a fully configurable and featured admin stick for DarkRP and was build upon the original Top Hatted Cat's Administration Stick. It has plenty of features that will help with the administration of a server, make your job a lot easier, and more fun!

![screenshot](https://raw.githubusercontent.com/sweepyoface/revo-admin-stick/master/screenshot.png)

Installation
-------
Simply download the zip and extract it or clone this repository into your addons folder.

Make sure to edit the config!

#### Linux (Ubuntu or Debian)
1. `sudo apt-get install git`
2. `cd /path/to/your/addons/folder/`
3. `git clone https://github.com/sweepyoface/revo-admin-stick.git`

#### Linux (CentOS)
1. `sudo yum install git`
2. `cd /path/to/your/addons/folder/`
3. `git clone https://github.com/sweepyoface/revo-admin-stick.git`

[Other Methods](https://github.com/sweepyoface/revo-admin-stick/blob/master/INSTALLATION.md)

To do
-------
* [x] Make the move entity tool user specific. It currently only supports one entity on the clipboard for the entire server.
* [x] Add more things to the config (warning message, kick message, etc).
* [x] Make things like the heal tool apply to the user if they aren't looking at a player.
* [x] Add config blacklist/whitelist for Move Entity.
* [x] Add config option for DarkRP Demote. Uses default in DarkRP config.

Tool Overview
-------

| Tool Name | Function
| --- | --- |
| Freeze Player | Toggles freeze on a player, emits sounds. |
| Warn Player | Gives the player a popup in the bottom right of their screen and emits a sound sound. |
| God Mode | Toggles god mode for yourself. |
| Restore Health | Heals the target player or yourself to full health. |
| Slay Player | Slays the target player. |
| Respawn Player | Slays the player and respawns them where they were. Useful for "resetting" someone (taking weapons, health and armor, etc.). |
| Respawn Player at Spawn | Slays the player and respawns them at the map spawnpoint. |
| Roll | Rolls a random number between 1 and 100. If the user is looking at a player, it also shows them the number. |
| Lock/Unlock Door | Toggles a door between closed and locked and open and unlocked state. |
| Kick Player | Kicks the player and emits a sound. |
| List Weapons | Lists weapons currently equipped by the target player. |
| Voice Mute Player | Toggles microphone mute on the target player. |
| Remover | Removes the target entity, blacklist in the config. |
| Move Entity | Use the tool on an entity (players work too) then use it again somewhere in the world and it or they will be moved to that position. No more physgunning for admin sits! |
| Jump | Teleports the user to where they're looking. |
| Spread the Word | Plays the "spread the word" sound for everyone on the server (trolly, respect it). |
| Create Explosion | Creates an explosion where the user is looking. |
| DarkRP Tools |
| --- |
| Demote | Sets the target player to the default team in the DarkRP config. |
| Abort Hit | Cancells the current hit of the target hitman. |
| Unown Door | Resets a door so it can be bought. |
| Reset Laws | Resets the laws to the server default. |
| Toggle Lockdown | Self explanatory. |
