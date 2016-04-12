
-- All base tools are here. Please put your custom tools in the admin_stick_extra_funcs.lua file.

function Stick_SendChat(ply, msg)
	local tab = table.Copy(StickConfig.NotificationPrefix)
	table.insert(tab, msg)
	THC.Chat(ply, tab)
end

AddStickTool("Freeze Player", {
	Description = "Freezes the target.",
	Icon = "icon16/control_pause_blue.png",
	CanTarget = targetply,
	OnRun = function(Player, Trace)
		local ply = Trace.Entity
		if (ply:IsFrozen()) then
			ply:Freeze(false)
			ply:EmitSound("npc/metropolice/vo/allrightyoucango.wav")
			Stick_SendChat(Player, "Unfrozen " .. tostring(ply))
			Stick_SendChat(ply, "You have been unfrozen")
		else
			ply:Freeze(true)
			ply:EmitSound("npc/metropolice/vo/holdit.wav")
			Stick_SendChat(Player, "Frozen " .. tostring(ply))
			Stick_SendChat(ply, "You have been frozen")
		end
	end
})

AddStickTool("Warn Player", {
	Description = "Warns the target player.",
	Icon = "icon16/error.png",
	CanTarget = targetply,
	OnRun = function(Player, Trace)
		local ply = Trace.Entity
		DarkRP.notify(ply, 1, 4, "An admin thinks you're doing something stupid, stop.")
		ply:EmitSound("npc/metropolice/vo/finalwarning.wav")
		Stick_SendChat(Player, "Warned " .. tostring(ply))
	end
})

AddStickTool("God Mode", {
	Description = "Enabled/Disables god mode for yourself.",
	Icon = "icon16/shield.png",
	CanTarget = anything,
	OnRun = function(Player)
		if (Player.stickGod) then
			Player:GodDisable()
			Stick_SendChat(Player, "Disabled god mode")
			Player.stickGod = false
		else
			Player:GodEnable()
			Stick_SendChat(Player, "Enabled god mode")
			Player.stickGod = true
		end
	end
})

AddStickTool("Restore Health", {
	Description = "Restores the target to full health.",
	Icon = "icon16/heart_add.png",
	CanTarget = targetply,
	OnRun = function(Player, Trace)
		local ply = Trace.Entity
		if ply:IsPlayer() then
			ply:SetHealth(ply:GetMaxHealth())
			Stick_SendChat(Player, "Restored " .. tostring(ply) .. " to full health.")
			Stick_SendChat(ply, "You have been restored to full health.")
		else
			Player:SetHealth(Player:GetMaxHealth())
			Stick_SendChat(Player, "You have been restored to full health.")
		end
	end
})

AddStickTool("Slay Player", {
	Description = "Slays the target player.",
	Icon = "icon16/weather_lightning.png",
	CanTarget = targetply,
	OnRun = function(Player, Trace)
		local ply = Trace.Entity
		ply:KillSilent()
		Stick_SendChat(Player, "Slayed " .. tostring(Trace.Entity))
	end
})

AddStickTool("Respawn Player", {
	Description = "Slays target and spawns them in the spot they died.",
	Icon = "icon16/group_go.png",
	CanTarget = targetply,
	OnRun = function(Player, Trace)
		local ply = Trace.Entity
		local pos, ang = ply:GetPos(), ply:GetAngles()
		ply:KillSilent()
		ply:Spawn()
		ply:SetPos(pos)
		ply:SetAngles(ang)
		Stick_SendChat(Player, tostring(ply) .. " has been respawned")
		Stick_SendChat(ply, "You have been respawned")
	end
})

AddStickTool("Respawn Player at Spawn", {
	Description = "Respawns the target at the map spawnpoint.",
	Icon = "icon16/group_go.png",
	CanTarget = targetply,
	OnRun = function(Player, Trace)
		local ply = Trace.Entity
		ply:KillSilent()
		ply:Spawn()
		Stick_SendChat(Player, tostring(ply) .. " has been respawned")
		Stick_SendChat(ply, "You have been respawned")
	end
})

AddStickTool("Roll", {
	Description = "Roll, 0-100",
	Icon = "icon16/sport_8ball.png",
	CanTarget = anything,
	OnRun = function(Player, Trace)
		local ply = Trace.Entity
		local roll = math.random( 0, 100 )
		if ply:IsPlayer() then
			Stick_SendChat(ply, "Roll: " .. roll)
			Stick_SendChat(Player, "Roll(" .. ply:Nick() .. "): " .. roll)
		else
			Stick_SendChat(Player, "Roll: " .. roll)
		end
	end
})

AddStickTool("Lock/Unlock Door", {
	Description = "Locks/Unlocks target door",
	Icon = "icon16/door.png",
	CanTarget = function(ent)
		local class = ent:GetClass()
		if (class == "func_door") or (class == "prop_door_rotating") then
			return true
		end
		return false
	end,
	OnRun = function(Player, Trace)
		if (Trace.Entity:GetSaveTable().m_bLocked) then
			Trace.Entity:Fire("Unlock", "", 0)
			Trace.Entity:Fire("Open", "", 0.5)
			Stick_SendChat(Player, "Door unlocked")
		else
			Trace.Entity:Fire("Lock", "", 0)
			Trace.Entity:Fire("Close", "", 0.1)
			Stick_SendChat(Player, "Door locked")
		end
	end
})

AddStickTool("Kick Player", {
	Description = "Kicks the target player.",
	Icon = "icon16/cancel.png",
    CanTarget = targetply,
    OnRun = function(Player, Trace)
		local ent = Trace.Entity
		if (ent:IsPlayer()) then
			Stick_SendChat(nil, ent:Nick() .. " has been kicked by " .. Player:Nick())
			ent:EmitSound("npc/metropolice/vo/amputate.wav")
			ent:Kick("Consider this as a warning..")
			return
		end
	end	
})

AddStickTool("List Weapons", {
	Description = "Lists weapons currently equipped by target",
	Icon = "icon16/zoom.png",
	CanTarget = targetply,
	OnRun = function(Player, Trace)
		local weaponString = ""
		local ply = Trace.Entity
		for k, v in pairs(ply:GetWeapons()) do
			if (table.HasValue(StickConfig.IgnoreWeapons, v:GetClass())) then continue end
			weaponString = weaponString .. " " .. v:GetClass()
		end
		Stick_SendChat(Player, tostring(ply) .. " has weapons:" .. weaponString)
	end
})



AddStickTool("Voice Mute Player", {
	Description = "Toggles voice mute on target",
	Icon = "icon16/sound.png",
	CanTarget = targetply,
	OnRun = function(Player, Trace)
		local ply = Trace.Entity
		if (ply:IsAdmin()) then
			Stick_SendChat(Player, "You can't gag an admin")
			return
		end
		if (ply:GetNetVar("IsAdminMuted", false)) then
			ply:SetNetVar("IsAdminMuted", false)
			Stick_SendChat(ply, "Your voice has been unmuted")
			Stick_SendChat(Player, tostring(ply) .. " has been unmuted")
		else
			Stick_SendChat(ply, "Your voice has been muted")
			ply:SetNetVar("IsAdminMuted", true)
			Stick_SendChat(Player, tostring(ply) .. " has been muted")
		end
	end	
})

AddStickTool("Remover", {
	Description = "Removes target entity",
	Icon = "icon16/cross.png",
	CanTarget = function(ent)
		local class = ent:GetClass()
		if (ent:IsPlayer()) and (StickConfig.KickPlayerOnRemove) then
			return true
		elseif (table.HasValue(StickConfig.RemoverBlacklist, class)) and (!StickConfig.RemoverBlacklistIsWhitelist) then
			return false
		elseif (table.HasValue(StickConfig.RemoverBlacklist, class)) and (StickConfig.RemoverBlacklistIsWhitelist) then
			return true
		else
			return true
		end
	end,
	OnRun = function(Player, Trace)
		local ent = Trace.Entity
		if (ent:IsPlayer()) then
			Stick_SendChat(Player, "Kicked " .. ent:Nick())
			ent:Kick("You have been kicked from the server by an administrator.") -- There is an actual kick function! No need to use this 
			return
		end
		Stick_SendChat(Player, "Removed " .. tostring(ent))
		ent:Remove()
	end
})

AddStickTool("Print Target Position", {
	Description = "Prints the hit pos of your eye trace",
	Icon = "icon16/bug.png",
	CanTarget = anything,
	OnRun = function(Player, Trace)
		local pos = Trace.HitPos
		local str = "Vector(" .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. ")"
		Player:ChatPrint(str)
	end
})

AddStickTool("Print Entity Position", {
	Description = "Prints the position of the target entity",
	Icon = "icon16/bug.png",
	CanTarget = anything,
	OnRun = function(Player, Trace)
		if (Trace.Entity == Entity(0)) then -- Removing the world crashes the game, no need to do that
			return
		end
		local pos = Trace.Entity:GetPos()
		local str = "Vector(" .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. ")"
		Player:ChatPrint(str)
	end
})

local varPCopied = 0
local ply
AddStickTool("Move Entity", {
	Description = "Moves an entity.",
	Icon = "icon16/group_go.png",
	CanTarget = anything,
	OnRun = function(Player, Trace)
		 if varPCopied == 1 then
            if not IsValid(Player.ply) then varPCopied = 0 return end
			local pos = Trace.HitPos
--			Stick_SendChat(Player, "test")
			Player.ply:SetPos(pos)
			Stick_SendChat(Player, "Pasted.")
			varPCopied = 0
		else
			if not (Trace.Entity == Entity(0)) then -- Moving the world crashes the game, no need to do that
				Player.ply = Trace.Entity
				varPCopied = 1
				Stick_SendChat(Player, "Copied.")
			end
		end
	end
})

local ply = Player
AddStickTool("Jump", {
	Description = "Teleport to where you're looking",
	Icon = "icon16/arrow_in.png",
	CanTarget = anything,
	OnRun = function(Player, Trace)
		local tr = Player:GetEyeTrace()
		print(tr)
		if tr.HitPos then 
			--print("hit!")
			Player:SetPos(tr.HitPos + tr.HitNormal*20)
		else
			Stick_SendChat(Player, "No location found.")
		end
	end
})

AddStickTool("Spread the Word", {
	Description = "Broadcast the 'Spread the word' sound to everyone on the server",
	Icon = "icon16/sound.png",
	CanTarget = anything,
	OnRun = function(Player, Trace)
		for k,v in pairs(player.GetAll()) do v:ConCommand("play vo/npc/male01/gordead_ans10.wav\n") end
	end
})


-- DarkRP tools

hook.Add("Initialize", "AS_AddDarkRP", function() -- Loaded after DarkRP loads so we can check if the gamemode is actually DarkRP
	if (!DarkRP) or (StickConfig.DarkRPDisabled) then return end

	AddStickTool("[DarkRP] Demote", {
		Description = "Demotes target player to citizen",
		Icon = "icon16/group_delete.png",
		CanTarget = targetply,
		OnRun = function(Player, Trace)
			local target = Trace.Entity
			if (target:Team() == TEAM_CITIZEN) then
				Stick_SendChat(Player, "This player is already a citizen.")
				return
			end
			target:changeTeam(TEAM_CITIZEN, true)
			Stick_SendChat(target, "You have been demoted to citizen by an administrator.")
			Stick_SendChat(Player, "Demoted " .. target:Nick())
		end
	})

	AddStickTool("[DarkRP] Abort Hit", {
		Description = "Aborts the hit of the target hitman",
		Icon = "icon16/control_stop_blue.png",
		CanTarget = targetply,
		OnRun = function(Player, Trace)
			local target = Trace.Entity
			if (!target:isHitman()) then
				Stick_SendChat(Player, "Target is not a hitman")
				return
			end
			if (!target:hasHit()) then
				Stick_SendChat(Player, "Target does not have a hit")
				return
			end
			target:abortHit("Admin aborted hit.")
			Stick_SendChat(Player, target:Nick() .. "'s hit has been aborted.")
		end
	})

	AddStickTool("[DarkRP] UnOwn Door", {
		Description = "Unowns target door",
		Icon = "icon16/door_open.png",
		CanTarget = function(Ent)
			if (Ent:isDoor()) and (Ent:isKeysOwned()) then
				return true
			end
			return false
		end,
		OnRun = function(Player, Trace)
			local door = Trace.Entity
			local owner = door:getDoorOwner()
			door:removeAllKeysExtraOwners()
			door:keysUnOwn(owner)
			Stick_SendChat(Player, "Unowned door originally owned by " .. owner:Nick())
		end
	})

	AddStickTool("[DarkRP] Reset Laws", {
		Description = "Resets the laws to default",
		Icon = "icon16/calendar_delete.png",
		CanTarget = anything,
		OnRun = function(Player, Target)
			DarkRP.resetLaws()
			Stick_SendChat(nil, "Laws have been reset by an administrator")
		end
	})

	AddStickTool("[DarkRP] Toggle Lockdown", {
		Description = "Turns lockdown on and off.",
		Icon = "icon16/lock.png",
		CanTarget = anything,
		OnRun = function(Player, Target)
			if GetGlobalBool("DarkRP_LockDown") then
				SetGlobalBool("DarkRP_LockDown", false)
				DarkRP.notifyAll(0, 3, DarkRP.getPhrase("lockdown_ended"))
				DarkRP.printMessageAll(HUD_PRINTTALK, DarkRP.getPhrase("lockdown_ended"))
			else
				SetGlobalBool("DarkRP_LockDown", true)
				DarkRP.notifyAll(0, 3, DarkRP.getPhrase("lockdown_started"))
				DarkRP.printMessageAll(HUD_PRINTTALK, DarkRP.getPhrase("lockdown_started"))
				for k, v in pairs (player.GetAll()) do
					v:ConCommand("play npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav\n")
				end
			end
		end
	})
end)