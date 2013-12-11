--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
Murder Hack by Deagler. (STEAM_0:1:32634764)
Credits to garrys_mod from MPGH (Unknown)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]


CreateClientConVar("lenny_murder", 0)
CreateClientConVar("lenny_murder_glows", 0)
surface.CreateFont( "murderplayer", {
 font = "Default",
 size = 13,
 weight = 300,
 outline=false,
shadow=false

} )
local function murderhaks()
if GetConVarNumber("lenny_murder") == 1 then
	for _,v in pairs (player.GetAll()) do
		for k2, v2 in pairs(v:GetWeapons()) do
			if string.find(v2:GetPrintName(), "Knife") then
			    local man = v2.Owner
				local pos = (man:GetPos() + Vector(0,0,60)):ToScreen()
                local col = man:GetPlayerColor()

                if GetConVarNumber("lenny_murder_glows") == 1 then
                effects.halo.Add({man}, Color(255,0,0,255), 1, 1, 5, true, true)
            	end

		
				draw.DrawText(man:GetBystanderName().."<Murderer>", "murderplayer", pos.x, pos.y - 15,Color(col.x * 255, col.y * 255, col.z * 255),TEXT_ALIGN_CENTER)
			end
			if string.find(v2:GetPrintName(), "Magnum") and v2.Owner then
			    local man = v2.Owner
				local pos =  (man:GetPos() + Vector(0,0,60)):ToScreen()
                local col = man:GetPlayerColor()

                if GetConVarNumber("lenny_murder_glows") == 1  then
                effects.halo.Add({man}, Color(0,0,255,255), 1, 1, 5, true, true)
            	end

				draw.DrawText(man:GetBystanderName().."<Gun Holder>", "murderplayer", pos.x, pos.y - 15,Color(col.x * 255, col.y * 255, col.z * 255),TEXT_ALIGN_CENTER)
			end
		end
	end  


	for b,c in pairs(ents.FindByClass("mu_loot")) do
			 local pos = ( c:GetPos() + Vector( 0,0,30 ) ):ToScreen()
			draw.DrawText( "Loot", "default", pos.x, pos.y, Color( 0, 255, 0, 255 ), TEXT_ALIGN_CENTER)
			if GetConVarNumber("lenny_murder_glows") == 1  then
			effects.halo.Add({c}, Color(0,255,0), 1, 1, 5, true, true)
			end
		end
end

end

hook.Remove("RenderScreenspaceEffects", "fukinmurdererfinderbrah")

if GetConVarNumber("lenny_murder") == 1 then
	hook.Add("RenderScreenspaceEffects", "fukinmurdererfinderbrah", murderhaks)
end


cvars.AddChangeCallback("lenny_murder", function() 
	if GetConVarNumber("lenny_murder") == 1 then
		hook.Add("RenderScreenspaceEffects", "fukinmurdererfinderbrah", murderhaks)
	else
	hook.Remove("RenderScreenspaceEffects", "fukinmurdererfinderbrah")
	end
end)



MsgC(Color(0,255,0), "\nDeaglers \"Murder\" Hack initialized!\n")