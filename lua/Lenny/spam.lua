--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_spam_time", 3)
CreateClientConVar("lenny_spam_namechange", 1)
CreateClientConVar("lenny_spam_message", "/advert Server now owned by NoN-Anonymous. steamcommunity.com/groups/nonanonpub")

local cname = 0
local namechange = GetConVarNumber("lenny_spam_namechange")
local time = GetConVarNumber("lenny_spam_time")
local message = GetConVarString("lenny_spam_message")

--uuurgh using think is ugly, but we can't manage to namechange everytime the game allowes us to otherwise

-- TODO find a better solution for this


local nextspam = CurTime()
local nextnamechange = CurTime()
local function spammer()

    if namechange == 1 then
        if nextnamechange <= CurTime() then
            RunConsoleCommand("lenny_namechange") --This runs first so it doesn't get missed by the chat delay. namechange.Priority > spam.Priority
            nextnamechange = CurTime() + 5.5
        end
    end

    if nextspam <= CurTime() then
        LocalPlayer():ConCommand("say " .. message)
        nextspam = CurTime() + time
    end
end



local toggler = 0
local function spam()
    if toggler == 0 then
        cname = 0

        hook.Add("Think", "Spammer", spammer)

        toggler = 1
    else
        hook.Remove("Think", "Spammer")
        toggler = 0
    end
end

concommand.Add("lenny_spam", spam)

cvars.AddChangeCallback("lenny_spam_namechange", function(name, old, new)
    namechange = new
end)
cvars.AddChangeCallback("lenny_spam_time", function(name, old, new)
    time = new
end)
cvars.AddChangeCallback("lenny_spam_message", function(name, old, new)
    message = new
end)
MsgC(Color(0, 255, 0), "\nLennys Chatspammer initialized!\n")