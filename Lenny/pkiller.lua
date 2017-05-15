--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
CreateClientConVar("lenny_pkill_speed", 100)
CreateClientConVar("lenny_pkill_prop", "models/props_c17/furnitureStove001a.mdl")
CreateClientConVar("lenny_pkill_remover", 0.9)
CreateClientConVar("lenny_weap_lagcomp", 0.1)

local function propkill()
	local atttime = GetConVarNumber("lenny_weap_lagcomp")
	if LocalPlayer():GetActiveWeapon():GetClass() != "weapon_physgun" then
		local lastwep = LocalPlayer():GetActiveWeapon()
		RunConsoleCommand("use", "weapon_physgun")
		atttime = 0.2
		timer.Simple(atttime+.3, function()
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
	
	timer.Simple(atttime+0.1, function()
		RunConsoleCommand("-attack")
	end)
	timer.Simple(atttime+GetConVarNumber("lenny_pkill_remover"), function()
		hook.Remove("CreateMove", "PKill")
		RunConsoleCommand("undo")
	end )
end
concommand.Add("lenny_pkill", propkill)

local toggler = 0
local function tttpropkill()
	if toggler == 0 then
		toggler = 1
		--[[LocalPlayer():SetEyeAngles(Angle(0,LocalPlayer():GetAimVector():Angle().y+180,0))   --since the magneto stick loses control when we turn too fast, I can't use this :/]]
		hook.Add("CalcView", "pcam", function(ply, ori, ang, fov, nz, fz)
 			local view = {}

			view.origin = ori
			view.angles = Angle(0,ang.y+180, 0)
			view.fov = fov

 			return view		
		end)
	else
		hook.Remove("CalcView", "pcam")
		local preaim = LocalPlayer():GetAimVector():Angle()
		local newaim = LocalPlayer():GetAimVector():Angle()
		hook.Add("CreateMove", "180!", function(cmd)
			newaim = Angle(0,newaim.y+10,0)
			cmd:SetViewAngles(newaim)
			if newaim == Angle(0,preaim.y+120,0) then
				RunConsoleCommand("+attack2")
				timer.Simple(.1, function()
					RunConsoleCommand("-attack2")
				end)
			end
			if newaim == Angle(0,preaim.y+180,0) then
				hook.Remove("CreateMove", "180!")
			end
		end)
		toggler = 0
	end
end

concommand.Add("lenny_tttpkill", tttpropkill)

MsgC(Color(0,255,0), "\nLenny PKill initialized!\n")