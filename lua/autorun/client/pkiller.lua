CreateClientConVar("lenny_pkill_speed", 100)
CreateClientConVar("lenny_pkill_prop", "models/props_c17/furnitureStove001a.mdl")
CreateClientConVar("lenny_pkill_remover", 0.5)

local function propkill()
	local atttime = 0
	if LocalPlayer():GetActiveWeapon():GetClass() != "weapon_physgun" then
		local lastwep = LocalPlayer():GetActiveWeapon()
		RunConsoleCommand("use", "weapon_physgun")
		atttime = 0.2
		timer.Simple(.3, function()
		RunConsoleCommand("use", lastwep:GetClass())
		end)
	end
	hook.Add( "CreateMove", "PKill", function(cmd)
		cmd:SetMouseWheel(GetConVarNumber("lenny_pkill_speed"))
	end)
	RunConsoleCommand("gm_spawn", GetConVarString("lenny_pkill_prop"))
	timer.Simple(atttime, function()
		RunConsoleCommand("+attack")
	end)
	
	timer.Simple(atttime+.1, function()
		RunConsoleCommand("-attack")
	end)
	timer.Simple(GetConVarNumber("lenny_pkill_remover"), function()
		hook.Remove("CreateMove", "PKill")
		RunConsoleCommand("undo")
	end )
end

concommand.Add("lenny_pkill", propkill)
print("Lenny Propkill initialized !!!")