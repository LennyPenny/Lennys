--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_stopfalldmg_prop",  "models/props_trainstation/trainstation_post001.mdl")

local toggler = 0
local ang
local view = {}
local function falldamage()
	hook.Add("CreateMove", "anti-falldmg", function(cmd)

		ang = cmd:GetViewAngles()
		if toggler == 0 then
			oriang = ang
			toggler = 1
			hook.Add("CalcView", "FlyCam", function(ply, ori, ang, fov, nz, fz)
				view.origin = ori
				view.angles = Angle(30, ang.yaw,0)
				view.fov = fov

 				return view	
			end)
		end
		cmd:SetViewAngles(Angle(90, ang.yaw, 0))

		local trace = LocalPlayer():GetEyeTrace()
		if trace.HitWorld then
			if LocalPlayer():GetPos():Distance(trace.HitPos) < 25 then
				hook.Remove("CreateMove", "anti-falldmg")
				RunConsoleCommand("gm_spawn", GetConVarString("lenny_stopfalldmg_prop"))
				cmd:SetViewAngles(view.angles)
				hook.Remove("CalcView", "FlyCam")
				toggler = 0
				timer.Simple(.1, function()
					RunConsoleCommand("undo")
				end)
			end
		end
	end)
end

concommand.Add("lenny_stopfalldmg", falldamage)

MsgC(Color(0,255,0), "\nLennys Anti-Falldmg initialized!\n")