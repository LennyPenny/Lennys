--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_hud", 1)

local w, h = ScrW(), ScrH()

local function hud()
	draw.SimpleText("Speed: "..math.Round(LocalPlayer():GetVelocity():Length()), "Default", w*.5, 0, Color(0,0,0), 1)
end


--prepping
hook.Remove("HUDPaint", "lennyhud")
timer.Simple(1, function()
if GetConVarNumber("lenny_hud") == 1 then
	hook.Add("HUDPaint", "lennyhud", hud)
end
end)
-- end of prep


cvars.AddChangeCallback("lenny_hud", function() 
	if GetConVarNumber("lenny_hud") == 1 then
		hook.Add("HUDPaint", "lennyhud", hud)
	else
		hook.Remove("HUDPaint", "lennyhud")
	end
end)


MsgC(Color(0,255,0), "\nLennys HUD initialized!\n")