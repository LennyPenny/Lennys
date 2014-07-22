--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
-- thanks to vexx21322 for help with the bitwise arithmetics

CreateClientConVar("lenny_bhop", 0)

function bhopper(cmd)
	if not cmd:KeyDown(IN_JUMP) then return end --do we even want to bhop
	if LocalPlayer():IsOnGround() then return end --would we wanna jump
	if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP or LocalPlayer():WaterLevel() >= 2 then return end --does it make sense to jump?

	cmd:SetButtons(cmd:GetButtons() - IN_JUMP) --while in air, don't jump
end


-- preperation
hook.Remove("CreateMove", "bunnyhop")
timer.Simple(1, function()
if GetConVarNumber("lenny_bhop") == 1 then
	hook.Add("CreateMove", "bunnyhop", bhopper)
end
end)
-- end of prep


cvars.AddChangeCallback("lenny_bhop", function() 
	if GetConVarNumber("lenny_bhop") == 1 then
		hook.Add("CreateMove", "bunnyhop", bhopper)
	else
		hook.Remove("CreateMove", "bunnyhop")
	end
end)

MsgC(Color(0,255,0), "\nLenny Bhop initialized!\n")
