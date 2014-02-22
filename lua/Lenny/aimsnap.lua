--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Modified and improved by Ott (STEAM_0:0:36527860)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
CreateClientConVar("lenny_aimsnap", 0)
CreateClientConVar("lenny_aimsnap_fov", 45)
CreateClientConVar("lenny_aimsnap_ignore_blocked", 1)
CreateClientConVar("lenny_aimsnap_prioritize", 0)
CreateClientConVar("lenny_aimsnap_target_friends", 0)
CreateClientConVar("lenny_aimsnap_target_npcs", 0)
CreateClientConVar("lenny_aimsnap_target_nonanons", 0)
CreateClientConVar("lenny_aimsnap_single_target", 0)
CreateClientConVar("lenny_aimsnap_preserve_angles", 0)

local FOV = GetConVarNumber("lenny_aimsnap_fov")
local preserve = GetConVarNumber("lenny_aimsnap_preserve_angles")

local midx = ScrW()*.5
local midy = ScrH()*.5
local realang = Angle(0, 0, 0)
local lastang = Angle(0, 0, 0)

-- getting all members of the nonanon groups to mark them for later
local nonanonp = {}
local nonanon = {}

local function NonAnonPSuccess(body)
	local ID64s = string.Explode("|", body)

	if #ID64s > 0 then
		table.remove(ID64s, #ID64s)
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


local function sorter(v1, v2)
	if GetConVarNumber("lenny_aimsnap_prioritize") == 1 then
		if v1[5] > v2[5] then
			return true
		elseif v1[5] == v2[5] then
			if v1[6] < v2[6] then
				return true
			end
		end
	else
		if v1[3] < v2[3] then
			return true
		end
	end
end

local disfromaim = {}

local function isinfov(dist)
	if dist <= FOV then
		return true
	else
		return false
	end
end

local function angledistance(a, b, c)
	return math.acos((a^2 + b^2 - c^2) / (2 * a * b)) * 59
end

local function rollover(n, min, max)
	while true do
		if n > max then
			n = min + n - max
		elseif n < min then
			n = max - min - n
		else
			return n
		end
	end
end

local function aimsnap()
	disfromaim = {}
	surface.SetDrawColor(Color(255,255,255))
	local targets = player.GetAll()
	if GetConVarNumber("lenny_aimsnap_target_npcs") == 1 then
		for k, v in pairs(ents.GetAll()) do
			if v:IsNPC() then
				table.insert(targets, v)
			end
		end
	end
	for k, v in pairs(targets) do
		if v:Health() > 0 or GetConVarNumber("lenny_aimsnap_single_target") == 1 then
			if v != LocalPlayer() and v:IsPlayer() then
				if v:GetFriendStatus() != "friend" or GetConVarNumber("lenny_aimsnap_target_friends") == 1 then
					if !(table.HasValue(nonanonp, v:SteamID64())) or GetConVarNumber("lenny_aimsnap_target_nonanons") == 1 then
						local hat = v:LookupBone("ValveBiped.Bip01_Head1")
						local spine = v:LookupBone("ValveBiped.Bip01_Spine2")
						if hat then
							local hatpos, hatang = v:GetBonePosition(hat)
							local scrpos = hatpos:ToScreen()
							local tracedat = {}
							tracedat.start = LocalPlayer():GetShootPos()
							tracedat.endpos = hatpos
							tracedat.mask = MASK_SHOT
							local trac = util.TraceLine(tracedat)
							local dmg = 0
							if v:GetActiveWeapon():IsValid() then
								if v:GetActiveWeapon():Clip1() > 0 and v:GetActiveWeapon().Primary != nil then
									dmg = v:GetActiveWeapon().Primary.Damage or 0
								end
							end
							local angdis = angledistance(LocalPlayer():GetShootPos():Distance(LocalPlayer():GetEyeTrace().HitPos), LocalPlayer():GetShootPos():Distance(hatpos), LocalPlayer():GetEyeTrace().HitPos:Distance(hatpos))
							local distocenter = math.abs(rollover(angdis, -180, 180))
							local distoplayer = LocalPlayer():GetPos():Distance(v:GetPos())
							if isinfov(distocenter) then
								if GetConVarNumber("lenny_aimsnap_ignore_blocked") == 1 then
									if trac.Entity == NULL or trac.Entity == v then
										table.insert(disfromaim, {v,  scrpos, distocenter, hatpos, dmg, distoplayer})
									end
								else
									table.insert(disfromaim, {v,  scrpos, distocenter, hatpos, dmg, distoplayer})
								end
							end
						end
					end
				end
			elseif v:IsNPC() then
				local hat = v:LookupBone("ValveBiped.Bip01_Head1")
				if hat then
					local hatpos, hatang = v:GetBonePosition(hat)
					local scrpos = hatpos:ToScreen()
					local tracedat = {}
					tracedat.start = LocalPlayer():GetShootPos()
					tracedat.endpos = hatpos
					tracedat.mask = MASK_SHOT
					local trac = util.TraceLine(tracedat)
					local dmg = 0
					local angdis = angledistance(LocalPlayer():GetShootPos():Distance(LocalPlayer():GetEyeTrace().HitPos), LocalPlayer():GetShootPos():Distance(hatpos), LocalPlayer():GetEyeTrace().HitPos:Distance(hatpos))
					local distocenter = math.abs(rollover(angdis, -180, 180))
					if isinfov(distocenter) then
						if GetConVarNumber("lenny_aimsnap_ignore_blocked") == 1 then
							if trac.Entity == NULL or trac.Entity == v then
								table.insert(disfromaim, {v,  scrpos, distocenter, hatpos, dmg})
							end
						else
							table.insert(disfromaim, {v,  scrpos, distocenter, hatpos, dmg})
						end
					end
				end
			end
		end
	end
	table.sort(disfromaim, sorter)
	surface.SetDrawColor(Color(0 , 255, 0))
	if disfromaim[1] then
		surface.DrawLine(midx, midy, disfromaim[1][2].x, disfromaim[1][2].y)
	end
end


concommand.Add("lenny_aimsnap_snap", function()
	if disfromaim[1] then
		LocalPlayer():SetEyeAngles((disfromaim[1][4] - LocalPlayer():GetShootPos()):Angle())
	else
		chat.AddText("No Target!")
	end
end)



concommand.Add("+lenny_aim", function()
	if GetConVarNumber("lenny_aimsnap") == 0 then
		chat.AddText("lenny_aimsnap must be 1 !!!")
	else
		realang = LocalPlayer():EyeAngles()
		lastang = LocalPlayer():EyeAngles()
		hook.Add("CreateMove", "snappyaim", function(cmd)
			realang = realang + cmd:GetViewAngles() - lastang
			cmd:SetViewAngles(realang)
			if disfromaim[1] and LocalPlayer():Alive() then
				if LocalPlayer():GetActiveWeapon():Clip1() > 0 then
					realang.y = math.NormalizeAngle(realang.y)
					cmd:SetViewAngles((disfromaim[1][4] - LocalPlayer():GetShootPos()):Angle())
					
					local move = Vector(cmd:GetForwardMove(), cmd:GetSideMove(), cmd:GetUpMove())
					move:Rotate(cmd:GetViewAngles() - realang)
					cmd:SetForwardMove(move.x)
					cmd:SetSideMove(move.y)
					cmd:SetUpMove(move.z)
					
					
					lastang = cmd:GetViewAngles()
				elseif preserve then
					cmd:SetViewAngles(realang)
				end
			elseif preserve then
				cmd:SetViewAngles(realang)
			end
			lastang = cmd:GetViewAngles()
		end)
		if preserve then
			hook.Add("CalcView", "preservativeaim", function(ply, pos, ang, fov)
				local eyeangles = LocalPlayer():EyeAngles()
				view = {}
				view.origin = pos
				view.angles = realang
				view.fov = fov
				view.vm_angles = Angle(eyeangles.p, (realang.y * 2) - eyeangles.y, eyeangles.r)
				return view
			end)
		end
	end

end)

concommand.Add("-lenny_aim", function()
	hook.Remove("CreateMove", "snappyaim")
	hook.Remove("Think", "snappyaim")
	hook.Remove("CalcView", "preservativeaim")
	LocalPlayer():SetEyeAngles(realang)
end)






hook.Remove("HUDPaint", "aimsnap")

if GetConVarNumber("lenny_aimsnap") == 1 then
	hook.Add("HUDPaint", "aimsnap", aimsnap)
end

-- end of prep


cvars.AddChangeCallback("lenny_aimsnap", function() 
	if GetConVarNumber("lenny_aimsnap") == 1 then
		hook.Add("HUDPaint", "aimsnap", aimsnap)
	else
		hook.Remove("HUDPaint", "aimsnap")
	end
end)

cvars.AddChangeCallback("lenny_aimsnap_fov", function() 
	FOV = GetConVarNumber("lenny_aimsnap_fov")
end)
cvars.AddChangeCallback("lenny_aimsnap_preserve_angles", function() 
	preserve = GetConVarNumber("lenny_aimsnap_preserve_angles")
end)


MsgC(Color(0,255,0), "\nLennys AimSnap initialized!\n")
