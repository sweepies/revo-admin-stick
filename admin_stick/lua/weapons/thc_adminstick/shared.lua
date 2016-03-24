
if (SERVER) then
	AddCSLuaFile( "shared.lua" )
else
    SWEP.PrintName = "Administrator Stick"
    SWEP.Slot = 0
    SWEP.SlotPos = 5
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true
end
 
SWEP.Author = "Top Hatted Cat/Sweepyoface"
SWEP.Instructions = "Aim at a target and left click to use the selected tool. Right click to open tools menu."
SWEP.Contact        = ""
SWEP.Purpose        = ""
 
SWEP.ViewModelFOV       = 62
SWEP.ViewModelFlip      = false
SWEP.AnimPrefix  = "stunstick"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.ViewModel = "models/weapons/v_stunstick.mdl"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Sound = Sound("weapons/stunstick/stunstick_swing1.wav")
SWEP.Sound1 = Sound("npc/metropolice/vo/moveit.wav")
SWEP.Sound2 = Sound("npc/metropolice/vo/movealong.wav")

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
 
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Deploy()
	if (SERVER) then
		self.Owner:DrawViewModel(StickConfig.ShowViewModel)
		self.Owner:DrawWorldModel(true)
		self:DrawShadow(false)
	end
end

--local emptyFunc = function() end
--SWEP.DrawWorldModel = emptyFunc
 

function SWEP:Initialize()
    if (SERVER) then
		self:SetNetVar("SelectedTool", "Freeze Player")
    end
	
	self:SetWeaponHoldType("melee")
end

function SWEP:Precache()
end

if (SERVER) then
	util.AddNetworkString("AS_DoAttack")
	local function doToolStuff(len, ply)
		local infoTab = net.ReadTable()
		local weapEnt = Entity(infoTab.Weapon)
		local target = Entity(infoTab.Target)
		if !StickConfig.PersonCanUse(ply) then
	   		ply:ChatPrint("You shouldn't have the administrator tool. It has been taken from you.")
	   		weapEnt:Remove()
	   		return false
	   	end
	    ply:SetAnimation( PLAYER_ATTACK1 )	
	    weapEnt.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	    local toolName = weapEnt:GetNetVar("SelectedTool", "Freeze Player")
		if (StickConfig.LimitedToSteamIDs[toolName]) and (!table.HasValue(StickConfig.LimitedToSteamIDs[toolName], ply:SteamID())) then
	    elseif (StickConfig.LimitedToGroups[toolName]) and (!table.HasValue(StickConfig.LimitedToGroups[toolName], ply:GetUserGroup())) then
	    	Stick_SendChat(ply, "This tool is limited.")
			return
		end
	--	if (StickConfig.LimitedToSteamIDs[toolName]) and (!table.HasValue(StickConfig.LimitedToSteamIDs[toolName], ply:SteamID())) then
	--		Stick_SendChat(ply, "This tool is limited.")
	 --   	return
	  --  end
	    local tool = StickTools[toolName]
	    if (tool) then
	    	if (tool.CanTarget) and (!tool.CanTarget(target)) then return end
	    	if (tool.CanUse) and (!tool.CanUse(ply)) then return end
	    	local trace = ply:GetEyeTraceNoCursor()
	    	trace.Entity = target
	    	tool.OnRun(ply, trace)
	    end
	end
	net.Receive("AS_DoAttack", doToolStuff)
end

function SWEP:PrimaryAttack()
	if (SERVER) then return end
	self.nextAt = self.nextAt or 0
	if (self.nextAt > CurTime()) then return end
	self.nextAt = CurTime() + 0.5
	self.Weapon:EmitSound(self.Sound)
   	local trace = LocalPlayer():GetEyeTraceNoCursor()
   	net.Start("AS_DoAttack")
   	net.WriteTable({
   		Target = trace.Entity:EntIndex(),
   		Weapon = LocalPlayer():GetActiveWeapon():EntIndex()
    })
   	net.SendToServer()
end

if (SERVER) then
	util.AddNetworkString("AdminStick_Select")

	net.Receive("AdminStick_Select", function(len, ply)
		if (!StickConfig.PersonCanUse(ply)) then return end
		local tool = net.ReadString()
		net.ReadEntity():SetNetVar("SelectedTool", tool)
	end)

	hook.Add("PlayerCanHearPlayersVoice", "AS_MakeMutedMuted", function(listener, talker)
		if (talker:GetNetVar("IsAdminMuted", false)) then
			return false, false
		end
	end)
end

if (CLIENT) then
	surface.CreateFont("AS_Details", {
		font = "Arial",
		size = 20,
		weight = 500,
		outline = false
	})

	function SWEP:DrawHUD()
		surface.SetFont("AS_Details")
		local trEnt = LocalPlayer():GetEyeTraceNoCursor().Entity
		local tolTxt = "Current Tool: " .. self:GetNetVar("SelectedTool", "Freeze Player")
		local descTxt = StickTools[self:GetNetVar("SelectedTool", "Freeze Player")].Description or "This tool has no description."
		local targTxt = "Target: " .. tostring(trEnt)
		local wid = 0
		if (select(1, surface.GetTextSize(tolTxt)) > wid) then wid = select(1, surface.GetTextSize(tolTxt)) end
		if (select(1, surface.GetTextSize(descTxt)) > wid) then wid = select(1, surface.GetTextSize(descTxt)) end
		if (select(1, surface.GetTextSize(targTxt)) > wid) then wid = select(1, surface.GetTextSize(targTxt)) end
		surface.SetDrawColor(Color(65, 131, 215, 200))
		surface.DrawRect(8, 57, wid + 2, 54)
		surface.SetTextColor(Color(255, 255, 255, 255))
		surface.SetTextPos(10, 56)
		surface.DrawText(tolTxt)
		surface.SetTextPos(10, 74)
		surface.DrawText(descTxt)
		surface.SetTextPos(10, 92)
		surface.DrawText(targTxt)
	end

	function SWEP:SecondaryAttack()
		if SERVER then return false end
			
		local menu = DermaMenu()

		local lUsrGrp = LocalPlayer():GetUserGroup()
		
		for k, v in SortedPairs(StickTools) do

			if (StickConfig.LimitedToGroups[k]) and (!table.HasValue(StickConfig.LimitedToGroups[k], lUsrGrp)) then
				continue
			end

			local function onRun()
				net.Start("AdminStick_Select")
				net.WriteString(k)
				net.WriteEntity(self)
				net.SendToServer()
			end
			
			local opt = menu:AddOption(k, onRun)
			if (v.Icon) then
				opt:SetIcon(v.Icon)
			end
		end
	
		menu:Open(100, 140)

		timer.Simple(0, function()
			gui.SetMousePos(100, 140)
		end)
	end
end