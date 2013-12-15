--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_stopfalldmg_prop", "models/props_trainstation/trainstation_post001.mdl")
local origAngs
local function falldamage()
    if !LocalPlayer():IsOnGround() then
    hook.Add("CreateMove", "anti-falldmg", function(cmd)
        origAngs = EyeAngles()
        cmd:SetViewAngles(Angle(90, 0, 0))
        local trace = LocalPlayer():GetEyeTrace()
        if trace.HitWorld then
            if LocalPlayer():GetPos():Distance(trace.HitPos) < 25 then
                RunConsoleCommand("gm_spawn", GetConVarString("lenny_stopfalldmg_prop"))
                cmd:SetViewAngles(Angle(origAngs)) -- This doesn't work properly and I don't know why
                hook.Remove("CreateMove", "anti-falldmg")
                timer.Simple(.1, function()
                    RunConsoleCommand("undo")
                end)
            end
        end
    end)
    end
end

concommand.Add("lenny_stopfalldmg", falldamage)
MsgC(Color(0, 255, 0), "\nLennys Anti-Falldmg initialized!\n")