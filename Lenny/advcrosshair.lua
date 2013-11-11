--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
CreateClientConVar("lenny_advcrosshair", 0)

local mx = ScrW()*.5 --middle x
local my = ScrH()*.5  --middle y

local function advcrosshair()
	if LocalPlayer():Health() > 0 then
		local target = LocalPlayer():GetEyeTrace().Entity
		if target:IsPlayer() or target:IsNPC() then
			surface.SetDrawColor(Color(255,255,255))

			surface.DrawLine(mx-5, my+5, mx+5, my-5)
			surface.DrawLine(mx-5, my-5, mx+5, my+5)

			draw.DrawText("Health: "..target:Health(), "Default", mx, my+20, Color(255,255,0), 1)

			surface.SetDrawColor(Color(255,0,0))
			if LocalPlayer():GetActiveWeapon():IsValid() then
				if LocalPlayer():GetActiveWeapon():Clip1() > 0 then

					draw.DrawText("Shots to kill: "..math.ceil(target:Health()/LocalPlayer():GetActiveWeapon().Primary.Damage), "Default", mx, my+30, Color(0,255,255), 1)

					if LocalPlayer():KeyDown(IN_ATTACK)  then
						surface.DrawLine(mx-10, my+10, mx-5, my+5)
						surface.DrawLine(mx-10, my-10, mx-5, my-5)
							surface.DrawLine(mx+10, my+10, mx+5, my+5)
					surface.DrawLine(mx+10, my-10, mx+5, my-5)
					end
				end
			end
		else
			surface.SetDrawColor(Color(255,255,255))
		end
	end

	surface.DrawLine(mx-35, my, mx-20, my)
	surface.DrawLine(mx+35, my, mx+20, my)
	surface.DrawLine(mx, my-35, mx, my-20)
	surface.DrawLine(mx, my+35, mx, my+20)
end


-- prepping
hook.Remove("HUDPaint", "advcrosshair")

if GetConVarNumber("lenny_advcrosshair") == 1 then
	hook.Add("HUDPaint", "advcrosshair", advcrosshair)
end
--end of prep

cvars.AddChangeCallback("lenny_advcrosshair", function() 
	if GetConVarNumber("lenny_advcrosshair") == 1 then
		hook.Add("HUDPaint", "advcrosshair", advcrosshair)
	else
		hook.Remove("HUDPaint", "advcrosshair")
	end
end)

MsgC(Color(0,255,0), "\nLennys Advanced crosshair initialized!\n")