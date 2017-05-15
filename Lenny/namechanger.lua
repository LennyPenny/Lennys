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
	for i=1, math.random(2, 3) do
		local part = table.Random(parts)
		name = name.." "..part
		for k,v in pairs(parts) do
			if string.find(v, part) then
				table.remove(parts, k)
			end
		end
	end
	if string.len(name) < 30 then
		local broke = 0
		for k, v in pairs(curname) do
			if string.find(name, v) then
				namechange()
				broke = 1
				break
			end
		end
		if broke == 0 then
			for k, v in pairs(blacklist) do 
				if string.find(string.lower(name), string.lower(v)) then
					namechange()
					broke = 1
					break
				end
			end
			if broke == 0 then
				LocalPlayer():ConCommand("say /name".. name)
				timer.Simple(.5, function() curname = string.Explode(" ", LocalPlayer():Name()) end)
			end
		end
	else
		namechange()
	end
end

concommand.Add("lenny_namechange", namechange)

MsgC(Color(0,255,0), "\nLennys NameChanger initialized!\n")

