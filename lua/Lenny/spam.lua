--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_spam_message", "spam")
CreateClientConVar("lenny_spam_timer", 0)

local spamstring = GetConVarString("lenny_spam_message")
local spamtimer = GetConVarNumber("lenny_spam_timer")



local toggler = 0
local usetimer = 0
local function spam(ply, cmd, args, str)
	if toggler == 0 then

		if spamtimer > 0 then
			timer.Create("spamtimer", spamtimer, 0 , function()
				LocalPlayer():ConCommand("say "..spamstring)
			end)
			usetimer = 1
		else
			hook.Add("CreateMove", "SpamHook", function()
				LocalPlayer():ConCommand("say "..spamstring)
			end)
			usetimer = 0
		end

		toggler = 1
	else
		if usetimer == 1 then
			timer.Remove("spamtimer") 
		else
			hook.Remove("CreateMove", "SpamHook")
		end
		toggler = 0
	end
end


cvars.AddChangeCallback("lenny_spam_message", function() 
	spamstring = GetConVarString("lenny_spam_message")
end)
cvars.AddChangeCallback("lenny_spam_timer", function() 
	spamtimer = GetConVarNumber("lenny_spam_timer")
end)

concommand.Add("lenny_spam2", spam)


MsgC(Color(0,255,0), "\nLennys Chatspammer initialized!\n")