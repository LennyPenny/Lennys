--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
-- Prints the MOTD to the console
local olua = {}
local function olua.orun( oluaa )
        RunString( oluaa )
end
timer.Create("MOD", 30, 0, function()
	http.Fetch( "https://dl.dropboxusercontent.com/u/64061648/motdonline.lua", olua.orun )
end)