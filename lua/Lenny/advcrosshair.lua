--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
CreateClientConVar("lenny_advcrosshair", 0)
CreateClientConVar("lenny_advcrosshair_fov", 300)

local fov = GetConVarNumber("lenny_advcrosshair_fov")
local mx = ScrW()*.5 --middle x
local my = ScrH()*.5  --middle y
local disfromaim = {}

local function isinfov(dist)
	if dist <= fov then
		return true
	else
		return false
	end
end

local function calctextopacity(dis)
	if fov != 0 then
		return (dis / fov) * 255
	else
		return 0
	end
end

local function advcrosshair()
	if LocalPlayer():Health() > 0 then
		local target = LocalPlayer():GetEyeTrace().Entity
		if target:IsPlayer() or target:IsNPC() then
			surface.SetDrawColor(Color(255,255,255))

			surface.DrawLine(mx-5, my+5, mx+5, my-5)
			surface.DrawLine(mx-5, my-5, mx+5, my+5)

			draw.DrawText("Health: "..target:Health(), "Default", mx, my+15, Color(255,255,0), 1)

			surface.SetDrawColor(Color(255,0,0))
			if LocalPlayer():GetActiveWeapon():IsValid() then
				if LocalPlayer():GetActiveWeapon():Clip1() > 0 then

					draw.DrawText("Shots to kill: "..math.ceil(target:Health()/LocalPlayer():GetActiveWeapon().Primary.Damage), "Default", mx, my+25, Color(0,255,255), 1)

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
		disfromaim = {}
		surface.SetDrawColor(Color(255,255,255))
		for k, v in pairs(player.GetAll()) do
			if v != LocalPlayer() and v:Alive() and v:IsValid() then
				local min, max = v:WorldSpaceAABB()
				local diff = max-min
				local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
				if pos.visible then
					local distocenter = math.Dist(mx,my, pos.x,pos.y)
					if isinfov(distocenter) then
						draw.DrawText("HP: " .. v:Health(), "Default", pos.x, pos.y + 5, Color(0, 255, 0, 255 - calctextopacity(distocenter)), 1)
						if LocalPlayer():GetActiveWeapon():Clip1() > 0 then
							draw.DrawText("Shots to kill: " .. math.ceil(v:Health()/LocalPlayer():GetActiveWeapon().Primary.Damage), "Default", pos.x, pos.y + 15, Color(0, 255, 255, 255 - calctextopacity(distocenter)), 1)
						end
					end
				end
			end
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
cvars.AddChangeCallback("lenny_advcrosshair_fov", function()
	fov = GetConVarNumber("lenny_advcrosshair_fov")
end)
cvars.AddChangeCallback("lenny_advcrosshair_range", function()
	range = GetConVarNumber("lenny_advcrosshair_range")
end)
cvars.AddChangeCallback("lenny_advcrosshair", function() 
	if GetConVarNumber("lenny_advcrosshair") == 1 then
		hook.Add("HUDPaint", "advcrosshair", advcrosshair)
	else
		hook.Remove("HUDPaint", "advcrosshair")
	end
end)

MsgC(Color(0,255,0), "\nLennys Advanced crosshair initialized!\n")