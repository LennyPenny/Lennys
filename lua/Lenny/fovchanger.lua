--[[
Script by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
CreateClientConVar("lenny_fov_on", 0)
CreateClientConVar("lenny_fov", 100)

local newfov = GetConVarNumber("lenny_fov")

local function fov(ply, ori, ang, fov, nz, fz)
    local view = {}

    view.origin = ori
    view.angles = ang
    view.fov = newfov

    return view
end


-- preperation
hook.Remove("CalcView", "fov")
timer.Simple(1, function()
    if GetConVarNumber("lenny_fov_on") == 1 then
        hook.Add("CalcView", "fov", fov)
    end
end)
-- end of prep

cvars.AddChangeCallback("lenny_fov", function()
    newfov = GetConVarNumber("lenny_fov")
end)

cvars.AddChangeCallback("lenny_fov_on", function()
    if GetConVarNumber("lenny_fov_on") == 1 then
        hook.Add("CalcView", "fov", fov)
    else
        hook.Remove("CalcView", "fov")
    end
end)

MsgC(Color(0, 255, 0), "\nLenny's FOV changer initialized!\n")