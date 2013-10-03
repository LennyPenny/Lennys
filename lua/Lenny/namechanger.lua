--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

CreateClientConVar("lenny_namechange_realnames", 0)

local firstnames = {}
local lastnames = {}
local gamernicks = {}

--thinking about adding a feature to add the name of everyone on the server to the databases
local function loadnamedb()
	firstnames = string.Explode("\n",file.Read("LennysDBfirstname.txt", "LUA"))
	lastnames = string.Explode("\n",file.Read("LennysDBfirstname.txt", "LUA")) -- simply edit the files to add/remove new names
	gamernicks = string.Explode("\n",file.Read("LennysDBgamenick.txt", "LUA"))
end
loadnamedb()


local function namechange()
	if GetConVarNumber("lenny_namechange_realnames") == 1 then
		LocalPlayer():ConCommand("say /rpname "..table.Random(firstnames).." "..table.Random(lastnames))
	else
		LocalPlayer():ConCommand("say /rpname "..table.Random(gamernicks))
	end
end

concommand.Add("lenny_namechange", namechange)

MsgC(Color(0,255,0), "\nLennys NameChanger initialized!\n")