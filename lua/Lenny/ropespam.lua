--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Modified and improved by Ott (STEAM_0:0:36527860)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

local counter = 0

local function ropespam(cmd)
    local buttonsetter = cmd:GetButtons()
    if counter == 0 then
        bit.band(buttonsetter, IN_ATTACK)
        counter = counter + 1
    end
    if counter == 1 then
        counter = counter - counter
    end
    cmd:SetButtons(buttonsetter)
end


concommand.Add("+lenny_ropespam", function()
    hook.Add("CreateMove", "RopeSpam", ropespam)
end)


concommand.Add("-lenny_ropespam", function()
    hook.Remove("CreateMove", "RopeSpam")
end)

MsgC(Color(0, 255, 0), "\nLennys Rope Spam initialized!\n")