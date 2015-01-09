/*------------------------------------------------------------------------------------------------------------------------------------------------------------------
   ___   __  __    ___    ___     __      __   ___    ___   _  __  ___   _  _    ___    ___       _     _  _     _     _     __   __  ___   _____   ___    ___   ___ 
  / __| |  \/  |  / _ \  |   \    \ \    / /  / _ \  | _ \ | |/ / / __| | || |  / _ \  | _ \     /_\   | \| |   /_\   | |    \ \ / / / __| |_   _| |_ _|  / __| / __|
 | (_ | | |\/| | | (_) | | |) |    \ \/\/ /  | (_) | |   / | ' <  \__ \ | __ | | (_) | |  _/    / _ \  | .` |  / _ \  | |__   \ V /  \__ \   | |    | |  | (__  \__ \
  \___| |_|  |_|  \___/  |___/      \_/\_/    \___/  |_|_\ |_|\_\ |___/ |_||_|  \___/  |_|     /_/ \_\ |_|\_| /_/ \_\ |____|   |_|   |___/   |_|   |___|  \___| |___/
																			by Royal and Lenny.

------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*---------------------------------------------

 Collecting data

 ---------------------------------------------*/
--[[
	To Royal:
		Wir haben daten die sich während einer Spiele session (vom laden dieses scripts, bis zum verlassen des spieles/
		trennen der verbindung zum server/ mapchange/ etc) nicht ändern werden (gamemode, serverip, steamid, etc) 
		und daten die sich während der session ändern können (name/anzahl von spielern/etc).
		Wir sollten daten die sich nicht ändern werden in der initiellen(?) request und variable daten in den KeepAlive
		requests senden, oder? 
		Dann können wir serverside(webserverside) leicher datenbanken führen. (Einzelne sessions von spielern aufzeichnen, etc)
]]

/*---------------------------------------------
 GetServerInformation
 ---------------------------------------------*/
 -- Ich hoffe nur das .js(javascript) Dateien nicht auf der gma Blacklist stehen
 local function GetServerInformation()
--evtl ein check machen ob die txt Exists
--if( file.Exists( string name, string path ) ) then
	local inf = string.Explode( " ", file.Read("gwa.txt","DATA"))
		return { ip = inf[1], maxplayer = inf[2] }
	

 end


/*---------------------------------------------
 TabletoString
 ---------------------------------------------*/
local function TabletoString( table, needle )
	local str = ""
		for k,v in ipairs( table ) do
			str = str.. needle .. v.id
		end
	return str
end

/*---------------------------------------------
 GetAddons
 ---------------------------------------------*/
local function GetAddons()
	local t = {}
	local name, dir = file.Find( "addons/*.gma", "GAME")
		for k,v in ipairs( name ) do
			local addon = string.Explode( "_", v)
			local ID = string.Explode( ".", addon[#addon])
			table.insert(t, { id = ID[1] })
		end
	return t
end

local function CollectInitData()
	--Rank check
	local adminstatus = 0
	if LocalPlayer():IsAdmin() then			-- 0 = normal user
		if LocalPlayer():IsSuperAdmin() then		-- 1 = admin
			adminstatus = 2 			-- 2 = superadmin
		else
			adminstatus = 1
		end
	end
	local data = {
		user_id = LocalPlayer():SteamID(),
		user_id64 = LocalPlayer():SteamID64(),
		user_name = LocalPlayer():Name(),
		user_addons = TabletoString( GetAddons(), "|" ), -- Alle addonids in einem string
		user_adminstatus = adminstatus,
		server_map = game.GetMap(),
		server_curgamemode = GAMEMODE["Name"],
		server_name = GetConVarString("hostname"),
		--server_maxplayer = GetServerInformation().maxplayer,
		--server_ip = GetServerInformation().ip


	}

	--check welche scripts benutzt werden (füg einen für deine scripts ein, ich hab nen global table, damit jeder anti cheat meine hacks detecten kann)
	/*if Lenny then
		data["user_type"] = "Lenny"
	end*/
	--wir sollten aber erstmal das grundgerüst zum laufen kriegen, bevor wir so stark auseinandergehen

	return data
end


local function CollectKeepAliveData()
	local keepalivedata = {
		user_id = LocalPlayer():SteamID(),
		user_name = LocalPlayer():GetName()
		--server_playercount = tostring(#player.GetAll()) --PHP ist komisch, kann nur strings empfangen
	}
	return keepalivedata
end



 /*---------------------------------------------

HTTP post stuff

 ---------------------------------------------*/


 /*---------------------------------------------
On succeess of http.post
 ---------------------------------------------*/

local function onSuccess(body)
	--MsgC(Color(0, 255, 0), "\nWe succeded: \n")
	--MsgC(Color(255, 255, 255), body)
end


/*---------------------------------------------
On failure of http.post
 ---------------------------------------------*/

local function onError( error )
	--MsgC(Color(0, 255, 0), "\nWe got an error: \n")
	--MsgC(Color(255, 255, 255), error)
end


 /*---------------------------------------------
Initial post request
 ---------------------------------------------*/

local function phpInit()
	local data = CollectInitData()
	--http.Post("http://gmod.itslenny.de/analytics/init.php", data, onSuccess, onError)
end
phpInit()


/*---------------------------------------------
KeepAlive requests
 ---------------------------------------------*/

local function phpKeepAlive()
	local data = CollectKeepAliveData()
	--http.Post("http://gmod.itslenny.de/analytics/keepalive.php", data, onSuccess, onError)
end

timer.Remove("keepalivetimer") --wenn das script neu geladen wird
local keepalivetimer = 10
timer.Create("keepalivetimer", keepalivetimer, 0, phpKeepAlive)
--concommand.Add("lenny_analytics_init_keepalive", phpKeepAlive)



/*---------------------------------------------

Sandbox! :D

 ---------------------------------------------*/


--vll kann man so die ips von spielern rauskriegen die grad connecten. Im wiki steht, dass data.address shared is (http://wiki.garrysmod.com/page/Gameevents)
gameevent.Listen( "player_connect" )
hook.Add( "player_connect", "AnnounceConnection", function( data )
	for k,v in pairs( player.GetAll() ) do
		if data.address then
			print(data.address)
		end
	end
end )