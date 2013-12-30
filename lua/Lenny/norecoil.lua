--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_norecoil", 1)


local function norecoil()
	if LocalPlayer():GetActiveWeapon():Clip1() > 0  then
		if LocalPlayer():GetActiveWeapon().Recoil then
			LocalPlayer():GetActiveWeapon().Recoil = 0
		end
		if LocalPlayer():GetActiveWeapon().Primary.Recoil then
			LocalPlayer():GetActiveWeapon().Primary.Recoil = 0
		end
	end
end



-- prepping
hook.Remove("PlayerSwitchWeapon", "norecoil")

if GetConVarNumber("lenny_norecoil") == 1 then
	hook.Add("PlayerSwitchWeapon", "norecoil", norecoil)
end
--end of prep

cvars.AddChangeCallback("lenny_norecoil", function() 
	if GetConVarNumber("lenny_norecoil") == 1 then
		hook.Add("PlayerSwitchWeapon", "norecoil", norecoil)
	else
		hook.Remove("PlayerSwitchWeapon", "norecoil")
	end
end)


MsgC(Color(0,255,0), "\nLennys NoRecoil initialized!\n")