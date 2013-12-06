--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
Thanks to oubielette
]]

local blacklist = {
        "admin",
        "owner"
}



curname = string.Explode(" ", LocalPlayer():Name())
local function namechange()
        local parts = {}
        local name = ""
        for k, v in pairs(player.GetAll()) do
                if !v:IsAdmin() and !v:IsSuperAdmin() then
                        for k, part in pairs(string.Explode(" ", v:Name())) do
                                table.insert(parts, part)
                        end
                end
        end
        local curnameBroke = false
        repeat
                curnameBroke = false
                for i=1, math.random(2, 3) do
                        local blacklistHit = false
                        if parts ~= nil then
                                local part = table.Random(parts)
                                local nameLength = string.len(name) + string.len(part)

                                repeat
                                        blacklistHit = false
                                        for k,v in ipairs(blacklist) do
                                                if string.find(part:lower(), v:lower()) then
                                                        blacklistHit = true
                                                end
                                        end

                                        if blacklistHit then
                                                part = table.Random(parts)
                                                nameLength = string.len(name) + string.len(part)
                                        end
                                until blacklistHit == false

                                while nameLength >= 30 do
                                        for k,v in pairs(parts) do
                                                if string.find(v, part) then
                                                        table.remove(parts, k)
                                                end
                                        end
                                        part = table.Random(parts)
                                        nameLength = string.len(name) + string.len(part)
                                end
                                name = name.." "..part
                                for k,v in pairs(parts) do
                                        if string.find(v, part) then
                                                table.remove(parts, k)
                                        end
                                end
                        end
                end
                for k, v in pairs(curname) do
                        if string.find(name:lower(), v:lower()) then
                                curnameBroke = true
                                name = ""
                        end
                end
        until curnameBroke == false

        LocalPlayer():ConCommand("say /name".. name)
        timer.Simple(.5, function() curname = string.Explode(" ", LocalPlayer():Name()) end)
end

concommand.Add("lenny_namechange", namechange)

MsgC(Color(0,255,0), "\nLennys NameChanger initialized!\n")
