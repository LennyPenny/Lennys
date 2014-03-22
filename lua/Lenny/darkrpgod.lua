--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
Thanks to oubielette
]]

CreateClientConVar("lenny_darkrpgod", 0)

local function darkrpgod()
	if LocalPlayer():Health() < 75 and LocalPlayer():Alive() then
		LocalPlayer():ConCommand("say /buyhealth")
	end
end


hook.Remove("Think", "darkrpgod")
timer.Simple(1, function()
	if GetConVarNumber("lenny_darkrpgod") == 1 then
		hook.Add("Think", "darkrpgod", darkrpgod)
	end
end)
-- end of prep


cvars.AddChangeCallback("lenny_darkrpgod", function() 
	if GetConVarNumber("lenny_darkrpgod") == 1 then
		hook.Add("Think", "darkrpgod", darkrpgod)
	else
		hook.Remove("Think", "darkrpgod")
	end
end)