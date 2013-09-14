--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
local function ReloadLennys()
	include("Lenny.lua")
end
concommand.Add("lenny_reload", ReloadLennys)

local files, folders = file.Find("lua/Lenny/*.lua", "GAME")
for k, v in pairs(files) do
	include("Lenny/" .. v)
end
MsgC(Color(0,255,255), "\nAll of Lennys scripts initialized!\n\n")