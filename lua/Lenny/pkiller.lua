--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
CreateClientConVar("lenny_pkill_speed", 100)
CreateClientConVar("lenny_pkill_prop", "models/props_c17/furnitureStove001a.mdl")
CreateClientConVar("lenny_pkill_remover", 0.9)
CreateClientConVar("lenny_weap_lagcomp", 0.1)

surface.CreateFont("pcam_font",{font = "Arial", size = 40, weight = 100000, antialias = 0})
function DrawOutlinedText ( title, font, x, y, color, OUTsize, OUTcolor )
	draw.SimpleTextOutlined ( title, font, x, y, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, OUTsize, OUTcolor )
end

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
		//for i=1, 180 do
		//	timer.Simple(0.01, function() LocalPlayer():SetEyeAngles(Angle(0,LocalPlayer():GetAimVector():Angle().y+i,0)) end) -- yo your right lenny, it sucks ass that we cant though :/
		//end
		hook.Add("CalcView", "pcam", function(ply, ori, ang, fov, nz, fz)
 			local view = {}

			view.origin = ori
			view.angles = Angle(ang.p,ang.y+180, 0) // < looks better lenny
			view.fov = fov

 			return view
		end)
		
		hook.Add("CreateMove", "pcam", function(cmd) -- Lets fix the controls ;)
			if input.IsKeyDown(KEY_W) then
				RunConsoleCommand("+back")
			else
				RunConsoleCommand("-back")
			end
			
			if input.IsKeyDown(KEY_S) then
				RunConsoleCommand("+forward")
			else
				RunConsoleCommand("-forward")
			end
			
			if input.IsKeyDown(KEY_A) then
				RunConsoleCommand("+moveright")
			else
				RunConsoleCommand("-moveright")
			end
			
			if input.IsKeyDown(KEY_D) then
				RunConsoleCommand("+moveleft")
			else
				RunConsoleCommand("-moveleft")
			end
		end)
		hook.Add("CalcViewModelView", "pcam", function(wep, vm, oldPos, oldAng, pos, ang)
				return pos, Angle(ang.p,ang.y+180, 0) -- Looks better
		end)
		hook.Add("HUDPaint", "pcam", function() -- Looks better
			DrawOutlinedText("TTT PROP KILL MODE", "pcam_font", ScrW()/2, ScrH()-100, Color(255, 0, 0), 2, Color(0, 0, 0))
		end)
	else
		hook.Remove("CalcView", "pcam") --Lets remove all the dem hooks
		hook.Remove("CreateMove", "pcam")
		hook.Remove("CalcViewModelView", "pcam")
		hook.Remove("HUDPaint", "pcam")
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
