
-- Ignore this function. It is needed for the command adding to work.
local function AddCommand(cmd, name, desc, icon)
	desc = desc or "A command-based tool. This runs the command: " .. cmd
	name = name or cmd
	icon = icon or "icon16/application_xp_terminal.png"
	AddStickTool(name, {
		Description = desc,
		Icon = icon,
		CanTarget = anything,
		OnRun = function(Player, Trace)
			Player:ConCommand(cmd)
		end
	})
end


------------
-- Use this file to add command-based tools.
------------

--
-- Example: 	Use ULX kick command to kick the person you are looking at with reason 'Kicked by Admin'.
-- 				It will have a description of "Kicks the target player.", has the cancel icon and the name 'Kick Player' in the menu.
--				Remove the -- from the start of the line to enable it.


-- AddCommand("ulx kick @ 'Consider this as a warning'", "Kick Player", "Kicks the target player.", "icon16/cancel.png")
AddCommand("ulx jail @", "ULX Jail Player", "Jails the target player.", "icon16/door.png")
