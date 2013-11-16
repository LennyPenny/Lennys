--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_propsurf_model", "models/props_c17/gravestone002a.mdl")

local prop = GetConVarString("lenny_propsurf_model")


local function startsurf()
	local ang = LocalPlayer():EyeAngles()
	local oriang = ang
	LocalPlayer():SetEyeAngles(Angle(30, ang.yaw+180,0))
	timer.Simple(.1, function()
		RunConsoleCommand("+attack")
		RunConsoleCommand("gm_spawn", prop)
		timer.Simple(.2, function()
		LocalPlayer():SetEyeAngles(oriang)
		end)
	end)
end

local function endsurf()
	hook.Remove("CreateMove", "propsurf")
	RunConsoleCommand("-attack")
	RunConsoleCommand("undo")
end

concommand.Add("+lenny_propsurf", startsurf)
concommand.Add("-lenny_propsurf", endsurf)

cvars.AddChangeCallback("lenny_propsurf_model", function() 
	prop = GetConVarString("lenny_propsurf_model")
end)


MsgC(Color(0,255,0), "\nLennys propsurf initialized!\n")