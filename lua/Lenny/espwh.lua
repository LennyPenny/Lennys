--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]
/*CreateClientConVar("lenny_wh_radius", 500)
CreateClientConVar("lenny_wh", 0)
local radius = GetConVarNumber("lenny_wh_radius")


local plys = {}
local props = {}

timer.Create("entrefresh", 1, 0, function()
	plys = {}
	props = {}
	for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), radius)) do
		if (v:IsPlayer() and !(LocalPlayer() == v)) or v:IsNPC() then
			table.insert(plys, v)
		elseif v:GetClass() == "prop_physics" then
			table.insert(props, v)
		end
	end
	PrintTable(plys)
end)


hook.Add("HUDPaint", "wh" , function()
	if GetConVarNumber("lenny_wh") == 1 then
		cam.Start3D()
		for k, v in pairs(plys) do
			render.SetColorModulation( 255, 0, 0, 0)
			render.SetBlend(.75)
			v:DrawModel()
		end
		cam.End3D()
	end
end )


cvars.AddChangeCallback("lenny_wh_radius", function() 
	radius = GetConVarNumber("lenny_wh_radius")
end)

*/
MsgC(Color(0,255,0), "\nLennys ESP and Wallhack initialized!\n")

