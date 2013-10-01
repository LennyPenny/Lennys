--[[
Don't use this.
I just used the shitty aimbot from the old wiki and ported it to the CreateMove hook to make it faster, also added some nice tweaks. Credit goes to whoever made this. (If you know who it was, tell me: STEAM_0:0:30422103)
]]

CreateClientConVar("lenny_aim", 0)

local function shitaimbad(cmd)
	target = LocalPlayer():GetEyeTrace().Entity
	if target  then
		if target:IsPlayer() or target:IsNPC() then
			print()
			if LocalPlayer():GetActiveWeapon():Clip1() > 0 then
				hat = target:LookupBone("ValveBiped.Bip01_Head1")
				if hat then
					hatpos, hatang = target:GetBonePosition(hat)
					cmd:SetViewAngles((hatpos - LocalPlayer():GetShootPos()):Angle())
				end
			end
		end
	end
end

-- prepping
hook.Remove("CreateMove", "shitaimbad")

if GetConVarNumber("lenny_aim") == 1 then
	hook.Add("CreateMove", "shitaimbad", shitaimbad)
end
--end of prep

cvars.AddChangeCallback("lenny_aim", function() 
	if GetConVarNumber("lenny_aim") == 1 then
		hook.Add("CreateMove", "shitaimbad", shitaimbad)
	else
		hook.Remove("CreateMove", "shitaimbad")
	end
end)


MsgC(Color(0,255,0), "\nLennys ShitAimBad initialized!\n")