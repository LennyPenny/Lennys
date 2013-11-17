--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Keypad tracker scrapped from MPGH and improved by Ott (STEAM_0:0:36527860)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]


CreateClientConVar("lenny_keypad", "0")
CreateClientConVar("lenny_keypad_radius", 200)
local keypadradius = GetConVarNumber("lenny_keypad_radius")
local X = -50
local Y = -100

local KeyPos =	{	
	{X+5, Y+100, 25, 25, -2.2, 3.45, 1.3, -0},
	{X+37.5, Y+100, 25, 25, -0.6, 1.85, 1.3, -0},
	{X+70, Y+100, 25, 25, 1.0, 0.25, 1.3, -0},

	{X+5, Y+132.5, 25, 25, -2.2, 3.45, 2.9, -1.6},
	{X+37.5, Y+132.5, 25, 25, -0.6, 1.85, 2.9, -1.6},
	{X+70, Y+132.5, 25, 25, 1.0, 0.25, 2.9, -1.6},

	{X+5, Y+165, 25, 25, -2.2, 3.45, 4.55, -3.3},
	{X+37.5, Y+165, 25, 25, -0.6, 1.85, 4.55, -3.3},
	{X+70, Y+165, 25, 25, 1.0, 0.25, 4.55, -3.3},

	{X+5, Y+67.5, 50, 25, -2.2, 4.7, -0.3, 1.6},
	{X+60, Y+67.5, 35, 25, 0.3, 1.65, -0.3, 1.6}
}

local function calctextopacity(dis)
	if keypadradius != 0 then
		return (dis / keypadradius) * 255
	else
		return 0
	end
end

local function survey()
	for k,v in pairs(player.GetAll()) do
		local kp = v:GetEyeTrace().Entity
		if IsValid(kp) and string.find(kp:GetClass(), "keypad") and not string.find(kp:GetClass(), "check") and not string.find(kp:GetClass(), "crack") and v:EyePos():Distance(kp:GetPos()) <= 71 then
			kp.tempCode = kp.tempCode or ""
			kp.tempText = kp.tempText or ""
			kp.tempStatus = kp.tempStatus or 0
			
			if kp:GetDisplayText() != kp.tempText or kp:GetStatus() != kp.tempStatus then
				kp.tempText = kp:GetDisplayText()
				kp.tempStatus = kp:GetStatus()
				
				local tr = util.TraceLine({
					start = v:EyePos(),
					endpos = v:GetAimVector() * 32 + v:EyePos(),
					filter = v
				})
				
				local pos = kp:WorldToLocal(tr.HitPos)
				
				for i,p in pairs(KeyPos) do
					local x = (pos.y - p[5]) / (p[5] + p[6])
					local y = 1 - (pos.z + p[7]) / (p[7] + p[8])
					
					if (x >= 0 and y >= 0 and x <= 1 and y <= 1) then
						if i == 11 then
							timer.Simple(0, function() //GetStatus doesnt work for another frame 
								if kp:GetStatus() == 1 then
									kp.code = kp.tempCode
								end
								kp.tempCode = ""
							end)		
						elseif i == 10 then
							kp.tempCode = ""
						else
							kp.tempCode = kp.tempCode..i
						end
					end
				end
			end
		end
	end
end

local function realboxkeypad(min, max, diff, clr)
	cam.Start3D()
	
		--vertical lines

		render.DrawLine( min, min+Vector(0,0,diff.z), clr)
		render.DrawLine( min+Vector(diff.x,0,0), min+Vector(diff.x,0,diff.z), clr)
		render.DrawLine( min+Vector(0,diff.y,0), min+Vector(0,diff.y,diff.z), clr)
		render.DrawLine( min+Vector(diff.x,diff.y,0), min+Vector(diff.x,diff.y,diff.z), clr)

		--horizontal lines top
		render.DrawLine( max, max-Vector(diff.x,0,0) , clr )
		render.DrawLine( max, max-Vector(0,diff.y,0) , clr)
		render.DrawLine( max-Vector(diff.x, diff.y,0), max-Vector(diff.x,0,0) , clr)
		render.DrawLine( max-Vector(diff.x, diff.y,0), max-Vector(0,diff.y,0) , clr)

		--horizontal lines bottom
		render.DrawLine( min, min+Vector(diff.x,0,0) , clr )
		render.DrawLine( min, min+Vector(0,diff.y,0) ,clr)
		render.DrawLine( min+Vector(diff.x, diff.y,0), min+Vector(diff.x,0,0) , clr )
		render.DrawLine( min+Vector(diff.x, diff.y,0), min+Vector(0,diff.y,0) , clr)

		-- extra
		--if ply:IsNPC() then return end
		--render.DrawLine(ply:GetShootPos(), ply:GetEyeTrace().HitPos, Color(255,0,0))
		
		
	cam.End3D()
end

local function drawstuff()
	for k,v in pairs(ents.GetAll()) do
		if IsValid(v) then
			if string.find(v:GetClass(), "keypad") and not string.find(v:GetClass(), "check") and not string.find(v:GetClass(), "crack") then
				if v != e then
					local pos = v:GetPos():ToScreen()
					local min, max = v:WorldSpaceAABB()
					local diff = max - min
					local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z + 3)):ToScreen()
					if IsValid(v) and v.code then
						realboxkeypad(min, max, diff, Color(0, 255, 0, 255))
						draw.DrawText(v.code, "Default", pos.x, pos.y - 10, Color(0, 255, 0, 255 - calctextopacity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
					else
						realboxkeypad(min, max, diff, Color(255, 0, 0, 255))
						draw.DrawText("No Code Available", "Default", pos.x, pos.y - 10, Color(255, 0, 0, 255 - calctextopacity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
					end
				end
			end
		end
	end
end


--prep
hook.Remove("Think", "WatchingPlayers", survey)
hook.Remove( "HUDPaint", "KeypadPasswords", drawstuff)

if GetConVarNumber("lenny_keypad") == 1 then
	hook.Add("Think", "WatchingPlayers", survey)
	hook.Add( "HUDPaint", "KeypadPasswords", drawstuff)
end
--end of prep
cvars.AddChangeCallback("lenny_keypad", function()
	if GetConVarNumber("lenny_keypad") == 1 then
		hook.Add("Think", "WatchingPlayers", survey)
		hook.Add( "HUDPaint", "KeypadPasswords", drawstuff)
	else
		hook.Remove("Think", "WatchingPlayers", survey)
		hook.Remove( "HUDPaint", "KeypadPasswords", drawstuff)
	end
end)

cvars.AddChangeCallback("lenny_keypad_radius", function() 
	keypadradius = GetConVarNumber("lenny_keypad_radius")
end)

MsgC(Color(0,255,0), "\nOtt's Keypad Tracker initialized!\n")