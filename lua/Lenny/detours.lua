--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
Thanks to Meepdarkeness for reducement of packet loss
]]
oldchataddtext = chat.AddText()

local counter = 0
        / * function chat. AddText(args)
local detected = 0
for k, v in pairs(args) do
    if v:iscolor() then
        if string.find(string.lower(v), "error occured") then
            counter = counter + 1
            detected = 1
        end
    end
end
if detected == 1 then
    if counter > 1000 then
        oldchataddtext(Color(0, 255, 0), "Checked 1000")
        counter = 0
    end
else
    oldchataddtext(args)
end
end * /