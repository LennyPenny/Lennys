--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

/*
###########
 WALLHACK
###########
*/
CreateClientConVar("lenny_wh_radius", 750)
CreateClientConVar("lenny_wh", 0)
local radius = GetConVarNumber("lenny_wh_radius")


local plys = {}
local props = {}


--this is more efficient than looping through every player in a drawing hook
timer.Create("entrefresh", 1, 0, function()
	plys = {}
	props = {}
	for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), radius)) do
		if (v:IsPlayer() and !(LocalPlayer() == v)) or v:IsNPC() then
			table.insert(plys, v)
		elseif v:GetClass() == "prop_physics" then
			table.insert(props, v)
		end
	end
end)

local function wh()
	cam.Start3D()
		for k, v in pairs(props) do
			if v:IsValid() then
				render.SetColorModulation( 0, 255, 0, 0)
				render.SetBlend(.4)
				v:DrawModel()
			end
		end
		for k, v in pairs(plys) do
			if v:IsValid() then
				render.SetColorModulation( 255, 0, 0, 0)
				render.SetBlend(.75)
				v:DrawModel()
			end
		end
	cam.End3D()
end

-- prepping
hook.Remove("HUDPaint", "wh")

if GetConVarNumber("lenny_wh") == 1 then
	hook.Add("HUDPaint", "wh", wh)
end
-- end of prep


cvars.AddChangeCallback("lenny_wh_radius", function() 
	radius = GetConVarNumber("lenny_wh_radius")
end)

cvars.AddChangeCallback("lenny_wh", function() 
	if GetConVarNumber("lenny_wh") == 1 then
		hook.Add("HUDPaint", "wh", wh)
	else
		hook.Remove("HUDPaint", "wh")
	end
end)



/*
####
 ESP
####
*/

CreateClientConVar("lenny_esp_radius", 1500)
CreateClientConVar("lenny_esp", 0)
local espradius = GetConVarNumber("lenny_esp_radius")


local espplys = {}
local espadmins= {}
local espsa = {}
local espnpcs = {}
local espfriends = {}

--same reason as in the wh
timer.Create("espentrefresh", 1, 0, function()
	espplys = {}
	espadmins= {}
	espsa = {}
	espnpcs = {}
	espfriends = {}
	if espradius != 0 then
		for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), espradius)) do
			if (v:IsPlayer() and !(LocalPlayer() == v)) then
				if v:IsSuperAdmin() then
					table.insert(espsa, v)
				elseif v:IsAdmin() then
					table.insert(espadmins, v)
				else
					if !(v:GetFriendStatus() == "friend") then
						table.insert(espplys, v)
					else
						table.insert(espfriends, v)
					end
				end
			elseif v:IsNPC() then
				table.insert(espnpcs, v)
			end
		end
	else
		for k, v in pairs(ents.GetAll()) do
			if (v:IsPlayer() and !(LocalPlayer() == v)) then
				if v:IsSuperAdmin() then
					table.insert(espsa, v)
				elseif v:IsAdmin() then
					table.insert(espadmins, v)
				else
					if !(v:GetFriendStatus() == "friend") then
						table.insert(espplys, v)
					else
						table.insert(espfriends, v)
					end
				end
			elseif v:IsNPC() then
				table.insert(espnpcs, v)
			end
		end
	end
end)

concommand.Add("lenny_printadmins", function()
	MsgC(Color(0,255,0), "\nSuper Admins:\n")
	PrintTable(espsa)
	MsgC(Color(0,255,0), "\n------------------------------------------------\n")
	MsgC(Color(0,255,0), "\nAdmins\n")
	PrintTable(espadmins)
	MsgC(Color(0,255,0), "\n------------------------------------------------\n")
end)

-- fuck vectors now.
local function realboxesp(min, max, diff, ply)
	cam.Start3D()
	
		--vertical lines

		render.DrawLine( min, min+Vector(0,0,diff.z), Color(0,0,255) )
		render.DrawLine( min+Vector(diff.x,0,0), min+Vector(diff.x,0,diff.z), Color(0,0,255) )
		render.DrawLine( min+Vector(0,diff.y,0), min+Vector(0,diff.y,diff.z), Color(0,0,255) )
		render.DrawLine( min+Vector(diff.x,diff.y,0), min+Vector(diff.x,diff.y,diff.z), Color(0,0,255) )

		--horizontal lines top
		render.DrawLine( max, max-Vector(diff.x,0,0) , Color(0,0,255) )
		render.DrawLine( max, max-Vector(0,diff.y,0) , Color(0,0,255) )
		render.DrawLine( max-Vector(diff.x, diff.y,0), max-Vector(diff.x,0,0) , Color(0,0,255) )
		render.DrawLine( max-Vector(diff.x, diff.y,0), max-Vector(0,diff.y,0) , Color(0,0,255) )

		--horizontal lines bottom
		render.DrawLine( min, min+Vector(diff.x,0,0) , Color(0,255,0) )
		render.DrawLine( min, min+Vector(0,diff.y,0) , Color(0,255,0) )
		render.DrawLine( min+Vector(diff.x, diff.y,0), min+Vector(diff.x,0,0) , Color(0,255,0) )
		render.DrawLine( min+Vector(diff.x, diff.y,0), min+Vector(0,diff.y,0) , Color(0,255,0) )

		-- extra
		--if ply:IsNPC() then return end
		--render.DrawLine(ply:GetShootPos(), ply:GetEyeTrace().HitPos, Color(255,0,0))
		
		
	cam.End3D()
end


local function esp()
	--text esp
	for k, v in pairs(espnpcs) do
		local min, max = v:WorldSpaceAABB()
		local diff = max-min
		realboxesp(min, max, diff, v)
		local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
		draw.DrawText("[NPC]" ..v:GetClass(), "Default", pos.x, pos.y-10, Color(255,0,0,255), 1)
		draw.DrawText("[NPC]" ..v:GetClass(), "Default", 100, 100, Color(255,0,0,255), 1)
	end
	for k,v in pairs(espplys) do
		local min, max = v:WorldSpaceAABB()
		local diff = max-min
		local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
		realboxesp(min, max, diff, v)
		draw.DrawText(v:GetName(), "Default", pos.x, pos.y-10, Color(255,255,0,255), 1)
	end
	for k,v in pairs(espadmins) do
		if v then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			draw.DrawText("[Admin]"..v:GetName(), "Default", pos.x, pos.y-10, Color(255,0,0,255), 1)
		end
	end
	for k,v in pairs(espsa) do
		local min, max = v:WorldSpaceAABB()
		local diff = max-min
		local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
		realboxesp(min, max, diff, v)
		draw.DrawText("[SuperAdmin]"..v:GetName(), "Default", pos.x, pos.y-10, Color(255,0,255,255), 1)
	end
	for k,v in pairs(espfriends) do
		local min, max = v:WorldSpaceAABB()
		local diff = max-min
		local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
		realboxesp(min, max, diff, v)
		draw.DrawText("[Friend]"..v:GetName(), "Default", pos.x, pos.y-10, Color(0,255,0,255), 1)
	end
end

-- prepping
hook.Remove("HUDPaint", "esp")

if GetConVarNumber("lenny_esp") == 1 then
	hook.Add("HUDPaint", "esp", esp)
end
--end of prep


cvars.AddChangeCallback("lenny_esp_radius", function() 
	radius = GetConVarNumber("lenny_esp_radius")
end)

cvars.AddChangeCallback("lenny_esp", function() 
	if GetConVarNumber("lenny_esp") == 1 then
		hook.Add("HUDPaint", "esp", esp)
	else
		hook.Remove("HUDPaint", "esp")
	end
end)


MsgC(Color(0,255,0), "\nLennys ESP and Wallhack initialized!\n")

