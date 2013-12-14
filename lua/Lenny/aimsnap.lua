--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Modified and improved by Ott (STEAM_0:0:36527860)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
CreateClientConVar("lenny_aimsnap", 0)
CreateClientConVar("lenny_aimsnap_fov", 500)
CreateClientConVar("lenny_aimsnap_ignore_blocked", 1)
CreateClientConVar("lenny_aimsnap_prioritize", 0)
CreateClientConVar("lenny_aimsnap_target_friends", 0)

local FOV = GetConVarNumber("lenny_aimsnap_fov")

local midx = ScrW()*.5
local midy = ScrH()*.5



local function sorter(v1, v2)
	if GetConVarNumber("lenny_aimsnap_prioritize") == 1 then
		if v1[5] > v2[5] then
			return true
		elseif v1[5] == v2[5] then
			if v1[3] < v2[3] then
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


local function aimsnap()
	disfromaim = {}
	surface.SetDrawColor(Color(255,255,255))
	for k, v in pairs(player.GetAll()) do
		if v != LocalPlayer() and v:Alive() then
			if v:GetFriendStatus() != "friend" or GetConVarNumber("lenny_aimsnap_target_friends") == 1 then
				local hat = v:LookupBone("ValveBiped.Bip01_Head1")
				if hat then
					local hatpos, hatang = v:GetBonePosition(hat)
					local scrpos = hatpos:ToScreen()
					local tracedat = {}
					tracedat.start = LocalPlayer():GetShootPos()
					tracedat.endpos = hatpos
					tracedat.mask = MASK_SHOT
					local trac = util.TraceLine(tracedat)
					if scrpos.visible then
						local dmg = 0
						if v:GetActiveWeapon():IsValid() then
							if v:GetActiveWeapon():Clip1() > 0 then
								--dmg = v:GetActiveWeapon().Primary.Damage or 0
							end
						end
						local distocenter = math.Dist(midx,midy, scrpos.x,scrpos.y)
						if GetConVarNumber("lenny_aimsnap_ignore_blocked") == 1 then
							if trac.Entity == NULL or trac.Entity == v then
								if isinfov(distocenter) then
									table.insert(disfromaim, {v,  scrpos, distocenter, hatpos, dmg})
								end
							end
						else
							if isinfov(distocenter) then
								table.insert(disfromaim, {v,  scrpos, distocenter, hatpos, dmg})
							end
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
		hook.Add("CreateMove", "snappyaim", function(cmd)
			if disfromaim[1] then
				cmd:SetViewAngles((disfromaim[1][4] - LocalPlayer():GetShootPos()):Angle())
			end
		end)
	end

end)

concommand.Add("-lenny_aim", function()
	hook.Remove("CreateMove", "snappyaim")
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



MsgC(Color(0,255,0), "\nLennys AimSnap initialized!\n")
