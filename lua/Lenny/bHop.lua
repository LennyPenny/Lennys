--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
-- by MeepDarknessMeep

local bhop_cv = CreateClientConVar("lenny_bhop", 0);
local auto_cv = CreateClientConVar("lenny_strafe", 0);

local FW = true; -- forward
local BW = false; -- backwards
local NONE = nil; -- neither

local cd = 6; -- cooldown
local ccd = 0; -- current cooldown
local lastc = 0; -- last cmd number
local lp = LocalPlayer(); -- localplayer

local function FWorBW(vel, ang)
	local a = vel;
	a:Rotate(-ang) 
	if(a.x > 0) then 
		return FW;
	elseif(a.x < 0) then
		return BW;
	end
	return NONE
end

local function bhopper(cmd)
	if(lp:GetMoveType() == MOVETYPE_NOCLIP or lp:WaterLevel() >= 2) then return; end --does it make sense to jump?
	if (cmd:KeyDown(IN_JUMP)) then
		if(auto_cv:GetBool()) then
			local mul = FWorBW(lp:GetVelocity(), lp:EyeAngles()) == BW and -1 or 1;
			if(cmd:GetMouseX() < 0) then
				cmd:SetSideMove(-10000 * mul);
				ccd = -cd;
			elseif(cmd:GetMouseX() > 0) then
				cmd:SetSideMove(10000 * mul);
				ccd = cd;
			elseif(ccd < 0) then
				cmd:SetSideMove(-10000 * mul);
				ccd = ccd + 1;
			elseif(ccd > 0) then
				cmd:SetSideMove(10000 * mul);
				ccd = ccd - 1;
			end
		end
		if (lp:OnGround() and cmd:CommandNumber() ~= lastc + 1) then
			cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_JUMP));
			if(cmd:CommandNumber() ~= 0) then lastc = cmd:CommandNumber(); end
			return;
		end
	end
	cmd:RemoveKey(IN_JUMP);
end


-- preperation
hook.Remove("CreateMove", "bunnyhop");
if(bhop_cv:GetBool()) then
	hook.Add("CreateMove", "bunnyhop", bhopper);
end
-- end of prep


cvars.AddChangeCallback("lenny_bhop", function() 
	if(bhop_cv:GetBool()) then
		hook.Add("CreateMove", "bunnyhop", bhopper);
	else
		hook.Remove("CreateMove", "bunnyhop");
	end
end)

MsgC(Color(0,255,0), "\nLenny Bhop initialized!\n");

--lenny script incorporated code above
