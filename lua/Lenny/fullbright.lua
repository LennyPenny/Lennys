--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Fullbright module by Ott (STEAM_0:0:36527860)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_fullbright", 0)
CreateClientConVar("lenny_fullbright_models", 1)
CreateClientConVar("lenny_fullbright_extend", 1)
local lightmodels = GetConVarNumber("lenny_fullbright_models")
local extend = GetConVarNumber("lenny_fullbright_extend")

local light = DynamicLight(LocalPlayer():EntIndex())
local light2 = DynamicLight(LocalPlayer():EntIndex() + 1)



local function fullbright()
	if light then
		local r, g, b = 255, 255, 255
		light.Pos = LocalPlayer():GetShootPos()
		light.Brightness = 0.5
		light.MinLight = 0.5    
		light.Size = 2048
		light.Decay = 1
		light.DieTime = CurTime() + 1
		light.Style = 0
		light.r = r
		light.g = g
		light.b = b
		light.NoModel = lightmodels == 0 and true or false
		light.NoWorld = false
	else
		light = DynamicLight(LocalPlayer():EntIndex())
	end
	if light2 then
		if extend == 1 then
			local r, g, b = 255, 255, 255
			light2.Pos = LocalPlayer():GetEyeTrace().HitPos
			light2.Brightness = 0.5
			light2.MinLight = 0.5
			light2.Size = 2048
			light2.Decay = 1
			light2.DieTime = CurTime() + 1
			light2.Style = 0
			light2.r = r
			light2.g = g
			light2.b = b
			light2.NoModel = lightmodels == 0 and true or false
			light2.NoWorld = false
		else
			light2.NoModel = true
			light2.NoWorld = true
		end
	else
		light2 = DynamicLight(LocalPlayer():EntIndex() + 1)
	end
end
local function callback()
	local enabled = GetConVarNumber("lenny_fullbright")
	if enabled == 1 then
		hook.Add("Think", "fullbright", fullbright)
	else
		light2.NoModel = true
		light2.NoWorld = true
		light.NoModel = true
		light.NoWorld = true
		hook.Remove("Think", "fullbright")
	end
end
callback()
cvars.AddChangeCallback("lenny_fullbright", callback)
cvars.AddChangeCallback("lenny_fullbright_models", function()
	lightmodels = GetConVarNumber("lenny_fullbright_models")
end)
cvars.AddChangeCallback("lenny_fullbright_extend", function()
	extend = GetConVarNumber("lenny_fullbright_extend")
end)