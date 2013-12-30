--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
NoSpread script recycled by Ott (STEAM_0:0:36527860)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_nospread", 1)


local function nospread()
	if LocalPlayer():GetActiveWeapon():Clip1() > 0 then
		if LocalPlayer():GetActiveWeapon().Cone then
			LocalPlayer():GetActiveWeapon().Cone = 0
		end
		if LocalPlayer():GetActiveWeapon().Primary.Cone then
			LocalPlayer():GetActiveWeapon().Primary.Cone = 0
		end
	end
end



-- prepping
hook.Remove("PlayerSwitchWeapon", "nospread")

if GetConVarNumber("lenny_norecoil") == 1 then
	hook.Add("PlayerSwitchWeapon", "nospread", nospread)
end
--end of prep

cvars.AddChangeCallback("lenny_nospread", function() 
	if GetConVarNumber("lenny_nospread") == 1 then
		hook.Add("PlayerSwitchWeapon", "nospread", nospread)
	else
		hook.Remove("PlayerSwitchWeapon", "nospread")
	end
end)


MsgC(Color(0,255,0), "\nOtt's NoSpread initialized!\n")