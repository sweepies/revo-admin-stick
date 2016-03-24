StickTools = {}

function targetply(ent)
	return ent:IsPlayer()
end
function anything() return true end

function AddStickTool(name, tab)
	if (table.HasValue(StickConfig.DisabledTools, name)) then return end
	StickTools[name] = tab
end

local filesToInclude = {
	"libs/thc",
	"admin_stick_config",
	"admin_stick_base_funcs",
	"admin_stick_extra_funcs",
	"admin_stick_command_funcs"
}

for k, v in pairs(filesToInclude) do
	local File = v .. ".lua"
	if (SERVER) then
		AddCSLuaFile(File)
	end
	include(File)
end

hook.Call("OnAllAdminStickToolsLoaded", {})