--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_flashlightspam", 0)


local function flashspammer(cmd)
    if input.IsKeyDown(KEY_F) then
        cmd:SetImpulse(100)
    end
end

-- preperation
hook.Remove("CreateMove", "flashspam")

if GetConVarNumber("lenny_flashlightspam") == 1 then
    hook.Add("CreateMove", "flashspam", flashspammer)
end
-- end of prep


cvars.AddChangeCallback("lenny_flashlightspam", function()
    if GetConVarNumber("lenny_flashlightspam") == 1 then
        hook.Add("CreateMove", "flashspam", flashspammer)
    else
        hook.Remove("CreateMove", "flashspam")
    end
end)

MsgC(Color(0, 255, 0), "\nLennys Flashlight spam initialized!\n")