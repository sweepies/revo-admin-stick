// Top Hatted Cat's utility library.
// Under the CC BY 4.0 license
// http://creativecommons.org/licenses/by/4.0/

if (THC) then return end

THC = {}

if (SERVER) then
	util.AddNetworkString("THC_SendChat")
	function THC.Chat(ply, tab)
		net.Start("THC_SendChat")
		net.WriteTable(tab)
		if (ply) then
			net.Send(ply)
		else
			net.Broadcast()
		end
	end
elseif (CLIENT) then
	net.Receive("THC_SendChat", function()
		local tab = net.ReadTable()
		chat.AddText(unpack(tab))
	end)
end