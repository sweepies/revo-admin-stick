--[[
	Add your extra admin stick functions here.
	Example of a command is below. Uncomment it to see it work.
	]]--


--[[
AddStickTool("Remove Prop", {
	Description = "Removes the target prop.", -- This is shown to the admin when the tool is selected.
	Icon = "icon16/shield.png", -- Icon to be shown on the menu item, can be any texture file. This is optional.
	CanTarget = function(toTarget) -- A function which is called when the admin uses the tool. It is to check if the tool can be used. This is here so you don't need to repeat code in your on run function if you need to check if the admin is targeting a specific entity
		return toTarget:GetClass() == "prop_physics"
	end,
	OnRun = function(Player, Trace) -- The function which is called when the tool is used. The player is passed as the first argument, and the player's eye trace as the second.
		local entity = Trace.Entity
		entity:Remove()
		Stick_SendChat(Player, "Removed target prop.") -- The Stick_SendChat function sends a chat message to the player and is prefixed with the prefix found in the config file.
	end
})
]]--

