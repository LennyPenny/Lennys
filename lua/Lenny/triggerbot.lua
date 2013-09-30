--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_triggerbot", 0)


local function triggerbot(cmd)
	target = LocalPlayer():GetEyeTrace().Entity
	if target and !(LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun") and !(LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physcannon") then
		if target:IsPlayer() or target:IsNPC() then
			cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_ATTACK))
		end
	else
		cmd:SetButtons(cmd:GetButtons())
	end
end


-- prepping
hook.Remove("CreateMove", "triggerbot")

if GetConVarNumber("lenny_triggerbot") == 1 then
	hook.Add("CreateMove", "triggerbot", triggerbot)
end
--end of prep

cvars.AddChangeCallback("lenny_triggerbot", function() 
	if GetConVarNumber("lenny_triggerbot") == 1 then
		hook.Add("CreateMove", "triggerbot", triggerbot)
	else
		hook.Remove("CreateMove", "triggerbot")
	end
end)


MsgC(Color(0,255,0), "\nLennys Triggerbot initialized!\n")