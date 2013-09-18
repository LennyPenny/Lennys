--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_bhop", 0)






local function bhopper( cmd )
	if input.IsKeyDown(KEY_SPACE) then
		if LocalPlayer():IsOnGround() then
			cmd:SetButtons(cmd:GetButtons())
		else
			cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_JUMP)))
		end
	end
end


-- preperation
hook.Remove("CreateMove", "bunnyhop")

if GetConVarNumber("lenny_bhop") == 1 then
	hook.Add("CreateMove", "bunnyhop", bhopper)
end
-- end of prep


cvars.AddChangeCallback("lenny_bhop", function() 
	if GetConVarNumber("lenny_bhop") == 1 then
		hook.Add("CreateMove", "bunnyhop", bhopper)
	else
		hook.Remove("CreateMove", "bunnyhop")
	end
end)

MsgC(Color(0,255,0), "\nLenny Bhop initialized!\n")