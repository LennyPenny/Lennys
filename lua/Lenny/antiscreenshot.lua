--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Anti-Screenshot module by Ott (STEAM_0:0:36527860)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

local missingjpg = file.Read("materials/missing256.jpg", "GAME")
local missingpng = file.Read("materials/missing256.png", "GAME")

/*
###############
 ACTUAL SCRIPT
###############
*/
local actualRenderCapture = _G.render.Capture

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
	else
		_G.render.Capture = actualRenderCapture
	end
end)



MsgC(Color(0,255,0), "\nOtt's Anti-Screenshot initialized!\n")