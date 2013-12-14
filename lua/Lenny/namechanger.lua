--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
Thanks to oubielette and ab0mbs
]]

local blacklist = {
	"owner",
	"moderator",
	"mod"
}

local function GenerateName(parts)
	local name = ""
		while #name <= 25 and #parts > 0 do
			local part = parts[1]

			local len = #name + # part
			
			if len <= 25 then
				name = name.." "..part
			end
			table.remove(parts, num)
		end
	return name
end

local function sorter(v1, v2)
	if #v1 > #v2 then
		return true
	end
end

local function TrimNameTable(parts)
	local lplyn = string.lower(LocalPlayer():Name())
	for k, v in pairs(parts) do
		if string.find(lplyn, string.lower(v), 0, 0) then
			table.remove(parts, k)
		end
	end

	table.sort(parts, sorter)

	return parts
end

local function CheckBlackList(ply)
	local failed = false
	if !ply:IsAdmin() and !ply:IsSuperAdmin() then
		for k, v in pairs(blacklist) do
			if string.find(string.lower(ply:Name()), v, 0, 0) then
				failed = true
				break
			end
		end
	else
		failed = true
	end

	return failed
end

local function GetNameParts()
	local parts = {}
	local name = ""
	for k, v in pairs(player.GetAll()) do
		if !CheckBlackList(v) then
			for k, v in pairs(string.Explode(" ", v:Name())) do
				table.insert(parts, v)
			end
		end
	end
	parts = TrimNameTable(parts)

	name = GenerateName(parts)

	LocalPlayer():ConCommand("say /name"..name)
end


local function namechange()
	local parts = GetNameParts()
end

concommand.Add("lenny_namechange", namechange)


MsgC(Color(0,255,0), "\nLennys NameChanger initialized!\n")
