--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Modified and improved by Ott (STEAM_0:0:36527860)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
CreateClientConVar("lenny_aimsnap", 0)
local ignoreblocked = CreateClientConVar("lenny_aimsnap_ignore_blocked", 1)
local midx = ScrW()*.5
local midy = ScrH()*.5



local function sorter(v1, v2)
	if v1[3] < v2[3] then
		return true
	end
end

	local disfromaim = {}
local function aimsnap()
	disfromaim = {}
	surface.SetDrawColor(Color(255,255,255))
	for k, v in pairs(player.GetAll()) do
		if v != LocalPlayer() and v:Alive() then
			if v:GetFriendStatus() != "friend" then
				local hat = v:LookupBone("ValveBiped.Bip01_Head1")
				if hat then
					local hatpos, hatang = v:GetBonePosition(hat)
					local scrpos = hatpos:ToScreen()
					local tracedat = {}
					tracedat.start = LocalPlayer():GetShootPos()
					tracedat.endpos = hatpos
					tracedat.mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE + CONTENTS_DEBRIS + CONTENTS_HITBOX + CONTENTS_MONSTER
					local trac = util.TraceLine(tracedat)
					if scrpos.visible then
						if ignoreblocked:GetBool() then
							if trac.Entity == NULL then
								table.insert(disfromaim, {v,  scrpos, math.Dist(midx,midy, scrpos.x,scrpos.y), hatpos})
							end
						else
							table.insert(disfromaim, {v,  scrpos, math.Dist(midx,midy, scrpos.x,scrpos.y), hatpos})
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


MsgC(Color(0,255,0), "\nLennys AimSnap initialized!\n")