--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Anti-Screenshot module by Ott (STEAM_0:0:36527860)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

--[[
screengrab snip
	local qual = net.ReadInt( 32 )
        local info = {
                format = "jpeg",
                h = ScrH(),
                w = ScrW(),
                quality = qual,
                x = 0,
                y = 0
        }
        local splitamt = 20000
        local capdat = !!!! util.Base64Encode( render.Capture( info ) ) !!!!
        local len = string.len( capdat )
        local frags = math.ceil( len / splitamt )
        
        dummy image data:
        
	iVBORw0KGgoAAAANSUhEUgAAAAcAAAAECAIAAADNpLIqAAAAAX
	NSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMA
	AA7DAcdvqGQAAAAYSURBVBhXY2BgYmBmYGFgZEAFlIkyMAAACD
	AAKdIBq3cAAAAASUVORK5CYII=
        
        ~noided
]]--

local missingjpg = file.Read("materials/missing256.jpg", "GAME")
local missingpng = file.Read("materials/missing256.png", "GAME")

local noided_dummy = "iVBORw0KGgoAAAANSUhEUgAAAAcAAAAECAIAAADNpLIqAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAYSURBVBhXY2BgYmBmYGFgZEAFlIkyMAAACDAAKdIBq3cAAAAASUVORK5CYII="

/*
###############
 ACTUAL SCRIPT
###############
*/
local actualRenderCapture = _G.render.Capture
local encodeData	  = util.Base64Encode;

local enabled = CreateClientConVar("lenny_antiscreenshot", "0")
cvars.AddChangeCallback("lenny_antiscreenshot", function()
	if enabled:GetBool() then
		_G.render.Capture = function(data)
			if data.format == "jpeg" then
				return missingjpg
			elseif data.format == "png" then
				return missingpng
			end
		end
	
		util.Base64Encode = function( str )
			local encoding = encodeData( missingpng );
			
			return( noided_dummy );
		end
	else
		_G.render.Capture = actualRenderCapture
		util.Base64Encode = encodeData;
	end
end)



MsgC(Color(0,255,0), "\nOtt's Anti-Screenshot initialized!\n")
MsgC(Color(0,255,0), "\nnoided's Anti-Screengrab initialized!\n")
