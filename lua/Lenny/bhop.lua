--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
CreateClientConVar("lenny_bhop", 0)

local toggler = 0
local function bhopper( ply, key )
	if GetConVarNumber("lenny_bhop") == 1 then
		if key == IN_JUMP then
			hook.Add("CreateMove", "jumper", function( cmd)
				local btns = cmd:GetButtons()
				if LocalPlayer():IsOnGround() then
					cmd:SetButtons(btns)
				else
					cmd:SetButtons(btns-2)
				end
			end)
		end
	end
end

hook.Add("KeyPress", "bhophook", bhopper)


local function bhopdisabler(ply, key)
	if GetConVarNumber("lenny_bhop") == 1 then
		if key == IN_JUMP then
			hook.Remove("CreateMove", "jumper")
		end
	end
end

hook.Add("KeyRelease", "bhopdisabler", bhopdisabler )

MsgC(Color(0,255,0), "\nLenny Bhop initialized!\n")