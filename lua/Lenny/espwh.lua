--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Modified and improved by Ott (STEAM_0:0:36527860)
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


-- getting all members of the nonanon groups to mark them for later
local nonanonp = {}
local nonanon = {}

local function NonAnonPSuccess(body)
	local ID64s = string.Explode("|", body)
	table.remove(ID64s, #ID64s)

	if #ID64s > 0 then
		for k, v in pairs(ID64s) do
			table.insert(nonanonp, v)
		end
	end
end

local function OnFail(error)
	print("We failed to contact gmod.itslenny.de")
	print(error)
	
end

local function GetNonAnonPMembers()
	http.Fetch("http://www.gmod.itslenny.de/lennys/nonanon/groupinfo", NonAnonPSuccess, OnFail)
end

GetNonAnonPMembers()




CreateClientConVar("lenny_esp_radius", 1500)
CreateClientConVar("lenny_esp", 0)
CreateClientConVar("lenny_esp_view", 0) -- Ability to see where the player is looking
local espradius = GetConVarNumber("lenny_esp_radius")

local nonanons = {}
local espplys = {}
local espadmins= {}
local espsa = {}
local espnpcs = {}
local espfriends = {}
local esp

local espents = {}
--same reason as in the wh

local function sortents(ent)
	if (ent:IsPlayer() and !(LocalPlayer() == ent)) then

		if table.HasValue(nonanons, ent:SteamID64()) then
			table.insert(nonanons, ent)
		end

		if ent:IsSuperAdmin() then
			table.insert(espsa, ent)
		elseif ent:IsAdmin() then
			table.insert(espadmins, ent)
		elseif !(ent:GetFriendStatus() == "friend") then
			table.insert(espplys, ent)
		else
			table.insert(espfriends, ent)
		end
	elseif ent:IsNPC() then
		table.insert(espnpcs, ent)
	elseif string.find(ent:GetClass(), "weapon") or string.find(ent:GetClass(), "shipment") or string.find(ent:GetClass(), "printer") or string.find(ent:GetClass(), "money") or string.find(ent:GetClass(), "durgz") then
		if !string.find(ent:GetClass(), "phys") and !string.find(ent:GetClass(), "grav")  then
			table.insert(espents, ent)
		end
	end
end

-- getting all releveant esp items
timer.Create("espentrefresh", 1, 0, function()
	nonanons = {}
	espplys = {}
	espadmins= {}
	espsa = {}
	espnpcs = {}
	espfriends = {}

	espents = {}

	if espradius != 0 then
		for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), espradius)) do
			sortents(v)
		end
	else
		for k, v in pairs(ents.GetAll()) do
			sortents(v)
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

	
	if GetConVarNumber("lenny_esp_view") == 1 then
		local shootpos = ply:IsPlayer() and ply:GetShootPos() or 0
		local eyetrace = ply:IsPlayer() and ply:GetEyeTrace().HitPos or 0

		if (shootpos != 0 and eyetrace != 0) then
		render.DrawBeam(shootpos, eyetrace,2,1,1, team.GetColor(ply:Team()))
		end
	end
		
		
	cam.End3D()
end


local function calctextopactity(ply)
	if espradius != 0 then
		dis = ply:GetPos():Distance(LocalPlayer():GetPos())
		return (dis / espradius) * 255
	else
		return 0
	end
end


local function drawesptext(text, posx, posy, color)
	draw.DrawText(text, "Default", posx, posy, color, 1)
end

local function esp()
	--text esp
	for k, v in pairs(nonanons) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			drawesptext("[NoN-AnonP]", pos.x, pos.y-20, Color(0, 255, 255, 255 - calctextopactity(v)))
			--draw.DrawText("[Friend]"..v:GetName(), "Default", pos.x, pos.y-10, Color(0,255,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	for k, v in pairs(espnpcs) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			realboxesp(min, max, diff, v)
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			drawesptext("[NPC]"..v:GetClass(), pos.x, pos.y-10, Color(255,0,0,255 - calctextopactity(v)))
			--draw.DrawText("[NPC]" ..v:GetClass(), "Default", pos.x, pos.y-10, Color(255,0,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	for k,v in pairs(espplys) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			drawesptext(v:GetName(), pos.x, pos.y-10, Color(255, 255,0,255 - calctextopactity(v)))
			--draw.DrawText(v:GetName(), "Default", pos.x, pos.y-10, Color(255, 255,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	for k,v in pairs(espadmins) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			drawesptext("[Admin]"..v:GetName(), pos.x, pos.y-10, Color(255, 0, 0,255 -calctextopactity(v)))
			--draw.DrawText("[Admin]"..v:GetName(), "Default", pos.x, pos.y-10, Color(255,0,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	for k,v in pairs(espsa) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			drawesptext("[SuperAdmin]"..v:GetName(), pos.x, pos.y-10, Color(255, 0, 255, 255 - calctextopactity(v)))
			--draw.DrawText("[SuperAdmin]"..v:GetName(), "Default", pos.x, pos.y-10, Color(255,0,255,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	for k,v in pairs(espfriends) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			drawesptext("[Friend]"..v:GetName(), pos.x, pos.y-10, Color(0, 255, 0, 255 - calctextopactity(v)))
			--draw.DrawText("[Friend]"..v:GetName(), "Default", pos.x, pos.y-10, Color(0,255,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	if espents then
		for k, v in pairs(espents) do
			if v:IsValid() then
				local min, max = v:WorldSpaceAABB()
				local diff = max-min
				local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
				realboxesp(min, max, diff, v)
				drawesptext(v:GetClass(), pos.x, pos.y-10, Color(0 ,255, 0,255 - calctextopactity(v)))
				--draw.DrawText(v:GetClass(), "Default", pos.x, pos.y-10, Color(0,255,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
				if v:GetClass() == "spawned_money" then
					drawesptext("$"..v:Getamount(), pos.x, pos.y, Color(0 ,255, 255,255 - calctextopactity(v)))
				end
			end
		end
	end
end

-- prepping
hook.Remove("HUDPaint", "esp")

if GetConVarNumber("lenny_esp") == 1 then
	hook.Add("HUDPaint", "esp", esp)
end
--end of prep


cvars.AddChangeCallback("lenny_esp_radius", function() 
	espradius = GetConVarNumber("lenny_esp_radius")
end)

cvars.AddChangeCallback("lenny_esp", function() 
	if GetConVarNumber("lenny_esp") == 1 then
		hook.Add("HUDPaint", "esp", esp)
	else
		hook.Remove("HUDPaint", "esp")
	end
end)


MsgC(Color(0,255,0), "\nLennys ESP and Wallhack initialized!\n")

