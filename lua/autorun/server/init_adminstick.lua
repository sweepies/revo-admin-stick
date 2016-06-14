StickConfig.InitialSpawned = false

hook.Add("PlayerInitialSpawn", "AdminStick_GiveTheStick_Initial", function(ply)
	if not (StickConfig.InitialSpawned) then
		http.Fetch( "https://raw.githubusercontent.com/sweepyoface/revo-admin-stick/master/VERSION.txt",
			function( body )
				stickver = string.Trim( body )
				localstickver = "4.11"
				StickConfig.InitialSpawned = true
				if localstickver != stickver then
					print("Revo Admin Stick is outdated! The newest version is " .. tostring(stickver) .. " and you are still on version " .. tostring(localstickver))
				else
					print("Revo Admin Stick is up to date with version " .. tostring(localstickver))
				end
			end,
			function( error )
		end)
	end
end)

hook.Add("PlayerLoadout", "AdminStick_GiveTheStick", function(ply)
	if (StickConfig.ShouldGiveToPerson(ply)) and (!ply:HasWeapon("thc_adminstick")) then
		ply:Give("thc_adminstick")
	end
end)

hook.Add("PlayerSpawn", "AdminStick_GiveTheStick_Backup", function(ply) -- Backup in case the PlayerLoadout hook is overwritten in a custom gamemode
	if (StickConfig.ShouldGiveToPerson(ply)) and (!ply:HasWeapon("thc_adminstick")) then
		ply:Give("thc_adminstick")
	end
end)