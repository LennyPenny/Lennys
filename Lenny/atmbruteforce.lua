--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
Thanks to Meepdarkeness for reducement of packet loss
]]




local function bruteforce()

local pintable = {}

for i=0, 9 do
	table.insert(pintable, "000"..i)
end

for i = 10, 99 do
	table.insert(pintable, "00"..i)
end

for i = 100, 999 do
	table.insert(pintable, "0"..i)
end

for i = 1000, 9999 do
	table.insert(pintable, i)	
end

local function bruteforceall( ply, cmd, args )
	MsgC(Color(0,255,0), "\nBruteforcing...\n")
	for k, v in pairs(player.GetAll()) do
		for _, pin in pairs(pintable) do
			timer.Simple(tonumber(pin)*.015, function() --thx meepdarkness, keep in mind that multiplication is faster than divison
			RunConsoleCommand("rp_atm_withdraw", util.CRC(pin), v:UniqueID(), args[1])
			end)
		end
	end
end

local function bruteforceply( ply, cmd , args )
	MsgC(Color(0,255,0), "\nBruteforcing...\n")
	for k, v in pairs(player.GetAll()) do
		if string.find(string.lower(v:Name()), string.lower(args[1])) then
			for _, pin in pairs(pintable) do
				timer.Simple(tonumber(pin)*.01, function()
				MsgC(Color(0,255,0), "\nChecking: "..pin.."\n")
				RunConsoleCommand("rp_atm_withdraw", util.CRC(pin), v:UniqueID(), args[2])
				end)
			end
		end
	end
end

concommand.Add("lenny_atmbruteforce_all", bruteforceall) --put amount to withdraw as an argument

concommand.Add("lenny_atmbruteforce_ply", bruteforceply) -- put name, then amount to withdraw as arguments

MsgC(Color(0,255,0), "\nInitialzed!!\n")

end




concommand.Add("lenny_atmbruteforce", bruteforce) -- don't want you to lag when you load it 

MsgC(Color(0,255,0), "\nLennys atm bruteforce initialized!\n")