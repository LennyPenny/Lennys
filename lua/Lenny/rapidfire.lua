--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Rapidfire script recycled from Lenny's triggerbot by Ott (STEAM_0:0:36527860)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_rapidfire", 0)

local toggler = 0

local function rapidfire(cmd)
	if LocalPlayer():KeyDown(IN_ATTACK) then
		if LocalPlayer():Alive() then
			if IsValid(LocalPlayer():GetActiveWeapon()) then
				if toggler == 0 then
					cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_ATTACK))
					toggler = 1
				else
					cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_ATTACK)))
					toggler = 0
				end
			end
		end
	end
end


-- prepping
hook.Remove("CreateMove", "rapidfire")

if GetConVarNumber("lenny_rapidfire") == 1 then
	hook.Add("CreateMove", "rapidfire", rapidfire)
end
--end of prep

cvars.AddChangeCallback("lenny_rapidfire", function() 
	if GetConVarNumber("lenny_rapidfire") == 1 then
		hook.Add("CreateMove", "rapidfire", rapidfire)
	else
		hook.Remove("CreateMove", "rapidfire")
	end
end)


MsgC(Color(0,255,0), "\nOtt's rapidfire initialized!\n")
