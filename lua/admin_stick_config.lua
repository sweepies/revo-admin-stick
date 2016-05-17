
StickConfig = {}

-- Here are some configuration values for the admin stick. These do not normally need to be changed, but can be to suit your server.


-- List of weapons not shown when getting a list of someones weapons. This does not need to be changed for DarkRP.
StickConfig.IgnoreWeapons = {
	"keys",
	"weapon_physcannon",
	"gmod_tool",
	"weapon_physgun",
	"adminstick",
	"arrest_stick",
	"door_ram",
	"pocket",
	"unarrest_stick",
	"stunstick"
}

-- The prefix to the chat notifications given when using the admin stick.
StickConfig.NotificationPrefix = {
	Color(255, 92, 92),
	"[Admin] ",
	Color(255, 255, 255)
}

StickConfig.FreezeSound = {"npc/metropolice/vo/holdit.wav"}

-- Set this to true to use the remover blacklist as a whitelist
StickConfig.RemoverBlacklistIsWhitelist = false

-- A list of entities that cannot be removed with the remover tool on the stick
StickConfig.RemoverBlacklist = {
	"prop_dynamic",
	"prop_door_rotating",
	"func_door",
	"func_lod",
	"func_rotating",
	"worldspawn",
	"func_door_rotating",
	"player"
}

-- Set this to true to use move entity blacklist as a whitelist
StickConfig.MoverBlacklistIsWhitelist = false

-- A list of entities that cannot be moved with the move entity tool
StickConfig.MoverBlacklist = {
	"prop_dynamic",
	"prop_door_rotating",
	"func_door",
	"func_lod",
	"func_rotating",
	"func_door_rotating"
}

-- Set to true to kick players if an admin uses the remover tool on them (Not recommended, it can be done by accident very easily, and there is an actual kick function)
StickConfig.KickPlayerOnRemove = false

-- Sound it emits when freezing someone (set to "" for none)
StickConfig.FreezeSound = "npc/metropolice/vo/holdit.wav"

-- Sound it emits when unfreezing someone (set to "" for none)
StickConfig.UnFreezeSound = "npc/metropolice/vo/allrightyoucango.wav"

-- Message it shows people with the warn tool
StickConfig.WarnMessage = "An admin thinks you're doing something stupid, stop."

-- Sound it emits when warning someone
StickConfig.WarnSound = "npc/metropolice/vo/finalwarning.wav"

-- Kick message the offender gets
StickConfig.KickMessage = "Consider this as a warning.."

-- Sound it emits when someone is kicked
StickConfig.KickSound = "npc/metropolice/vo/amputate.wav"

-- A list of user groups that receive the stick when they spawn and can use the stick
StickConfig.GroupsCanUse = {
	"owner",
	"council",
	"superadmin",
	"admin",
	"moderator"
}

-- List of SteamIDs that receive the stick when they spawn and can use the stick
StickConfig.SteamIDsCanUse = {
	"STEAM_0:0:12345678",
}

-- Will regular admins spawn with the stick even if they are not on the above list?
StickConfig.GiveToAdmins = false



-- This function is called to check if a player should be given the admin stick when they spawn. Default is to give according to the settings above.
StickConfig.ShouldGiveToPerson = function(Player)
	if (table.HasValue(StickConfig.GroupsCanUse, Player:GetUserGroup())) or (table.HasValue(StickConfig.SteamIDsCanUse, Player:SteamID())) then return true end
	if (StickConfig.GiveToAdmins) and (Player:IsAdmin()) then return true end
	return false
end

-- This function is called to check if a player should be able to use the admin stick. If a person is attempting to use the stick but cannot, it will be removed from them. Default is to give according to the settings above.
StickConfig.PersonCanUse = function(Player)
	if (table.HasValue(StickConfig.GroupsCanUse, Player:GetUserGroup())) or (table.HasValue(StickConfig.SteamIDsCanUse, Player:SteamID())) then return true end
	if (StickConfig.GiveToAdmins) and (Player:IsAdmin()) then return true end
	return false
end

StickConfig.LimitedToGroups = {} -- A list of tools and the user groups that can use them

StickConfig.LimitedToGroups["Print Target Position"] = {"developer", "superadmin"} -- Example: Limits the 'Print Target Position' tool to developers and superadmins
StickConfig.LimitedToGroups["Print Entity Position"] = {"developer"} -- Example: Limits the 'Print Entity Position' tool to developers only
StickConfig.LimitedToGroups["God Mode"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Lock/Unlock Door"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Remover"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Respawn Player"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Respawn Player at Spawn"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Restore Health"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Slay Player"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["[DarkRP] Reset Laws"] = {"superadmin"}
StickConfig.LimitedToGroups["[DarkRP] Abort Hit"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["[DarkRP] Demote"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["[DarkRP] UnOwn Door"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["[DarkRP] Toggle Lockdown"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Kick Player"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Move Entity"] = {"superadmin"}
StickConfig.LimitedToGroups["Jump"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Freeze Player"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Gag Player"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["List Weapons"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Warn Player"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["ULX Jail Player"] = {"superadmin", "admin"}
StickConfig.LimitedToGroups["Spread the Word"] = {"superadmin"}
StickConfig.LimitedToGroups["Create Explosion"] = {"superadmin"}

StickConfig.LimitedToSteamIDs = {} -- A list of tools and the SteamIDs that can use them

StickConfig.LimitedToSteamIDs["Print Target Position"] = {} -- Example: Must be in a group with permission to use this tool, ignores the SteamID system
StickConfig.LimitedToSteamIDs["Print Entity Position"] = {}
StickConfig.LimitedToSteamIDs["God Mode"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Lock/Unlock Door"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Remover"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Respawn Player"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Respawn Player at Spawn"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Restore Health"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Slay Player"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["[DarkRP] Reset Laws"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["[DarkRP] Abort Hit"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["[DarkRP] Demote"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["[DarkRP] UnOwn Door"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["[DarkRP] Toggle Lockdown"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Kick Player"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Move Entity"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Freeze Player"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Voice Mute Player"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["List Weapons"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Warn Player"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["ULX Jail Player"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Spread the Word"] = {"STEAM_0:0:12345678"}
StickConfig.LimitedToSteamIDs["Create Explosion"] = {"STEAM_0:0:12345678"}

-- A list of disabled tools. Add the name of the tool here to prevent it from loading.
StickConfig.DisabledTools = {
	"Print Target Position",
	"Print Entity Position"
}

-- Set this to true to not load the default DarkRP tools when running DarkRP
StickConfig.DarkRPDisabled = false

-- Set to true to show the stunstick view model
StickConfig.ShowViewModel = true
