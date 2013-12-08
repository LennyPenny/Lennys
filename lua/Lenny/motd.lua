--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]



local function lennymenu()
	local w = ScrW()
	local h = ScrH()

	local frame = vgui.Create("DFrame")
	frame:SetSize(w - 150, h - 150)
	frame:Center()
	frame:MakePopup()
	--frame:ShowCloseButton(false)

	local fw, fh = frame:GetWide(), frame:GetTall()

	frame:SetTitle( "Lenny's Scripts" )
	frame.Paint = function ()
		draw.RoundedBox(20, 0, 0, fw, fh, Color(50, 50, 50)  )
	end
	
	local closebtn = vgui.Create("DButton", frame)
	closebtn:SetSize(150,50)
	closebtn:SetText("Close")
	closebtn:SetPos(fw-160, fh-60)
	closebtn.DoClick = function()
		frame:Close()
	end
	closebtn.Paint = function()
		surface.SetDrawColor(255, 255, 200)
		surface.DrawRect(0, 0, closebtn:GetWide(), closebtn:GetTall())
	end

	local donbtn = vgui.Create("DButton", frame)
	donbtn:SetSize(300,60)
	donbtn:SetText("")
	donbtn:Center()
	local dbx, dby = donbtn:GetPos()
	donbtn:SetPos(dbx, fh-100)
	dbx, dby = donbtn:GetPos()
	donbtn.DoClick = function()
		gui.OpenURL("http://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=R6E7PJUATS5KW")
	end
	donbtn.Paint = function()
		surface.SetDrawColor(0, 100, 255)
		surface.DrawRect(0, 0, donbtn:GetWide(), donbtn:GetTall())
		draw.DrawText("Donate!", "Trebuchet24", donbtn:GetWide()*.5, donbtn:GetTall()*.3, Color(0, 255, 0),TEXT_ALIGN_CENTER)
	end

	/*local dontext = vgui.Create("DPanel", frame)
	dontext:SetSize(360,425)
	dontext:SetPos(dbx-30, dby - 300)
	dontext.Paint = function()
		draw.DrawText("If you like using this,\n please consider making a small \ndonation toward its development!", "Trebuchet24", dontext:GetWide()*.5, dontext:GetTall()*.5, Color(255, 255, 0),TEXT_ALIGN_CENTER)
	end*/

	local htmllogo = vgui.Create("HTML", frame)
	htmllogo:SetSize(500, 250)
	htmllogo:SetPos(50, 50)
	htmllogo:OpenURL("http://www.gmod.itslenny.de/Lennys/logo.png")

	local htmldtext = vgui.Create("HTML", frame)
	htmldtext:SetSize(300, 150)
	htmldtext:SetPos(dbx, fh-250)
	htmldtext:OpenURL("http://www.gmod.itslenny.de/Lennys/text.png")


	local htmlmotd = vgui.Create("HTML", frame)
	htmlmotd:SetSize(1000, 600)
	htmlmotd:SetPos(dbx-100, 50)
	htmlmotd:OpenURL("http://www.gmod.itslenny.de/Lennys/motd.html")

	local websitebtn = vgui.Create("DButton", frame)
	websitebtn:SetSize(250,75)
	websitebtn:SetPos(50, 325)
	websitebtn:SetText("")
	websitebtn.DoClick = function()
		gui.OpenURL("http://www.gmod.itsLenny.de/Lennys")
	end
	websitebtn.Paint = function()
		surface.SetDrawColor(50, 150, 150)
		surface.DrawRect(0, 0, websitebtn:GetWide(), websitebtn:GetTall())
		draw.DrawText("Wesbite", "Trebuchet24", websitebtn:GetWide()*.5, websitebtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
	end

	local tutsitebtn = vgui.Create("DButton", frame)
	tutsitebtn:SetSize(250,75)
	tutsitebtn:SetPos(50, 430)
	tutsitebtn:SetText("")
	tutsitebtn.DoClick = function()
		gui.OpenURL("http://www.gmod.itsLenny.de/Lennys")
	end
	tutsitebtn.Paint = function()
		surface.SetDrawColor(150, 150, 50)
		surface.DrawRect(0, 0, tutsitebtn:GetWide(), tutsitebtn:GetTall())
		draw.DrawText("Tutorials (Coming Soon!)", "Trebuchet24", tutsitebtn:GetWide()*.5, tutsitebtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
	end

	local hofbtn = vgui.Create("DButton", frame)
	hofbtn:SetSize(250,75)
	hofbtn:SetPos(50, 535)
	hofbtn:SetText("")
	hofbtn.DoClick = function()
		gui.OpenURL("http://www.gmod.itsLenny.de/Lennys")
	end
	hofbtn.Paint = function()
		surface.SetDrawColor(150, 50, 150)
		surface.DrawRect(0, 0, hofbtn:GetWide(), hofbtn:GetTall())
		draw.DrawText("Hall Of Fame (Coming Soon)", "Trebuchet24", hofbtn:GetWide()*.5, hofbtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
	end

	local creditsbtn = vgui.Create("DButton", frame)
	creditsbtn:SetSize(250,75)
	creditsbtn:SetPos(50, 640)
	creditsbtn:SetText("")
	creditsbtn.DoClick = function()
		gui.OpenURL("http://bly.itslenny.de/1egpIXx")
	end
	creditsbtn.Paint = function()
		surface.SetDrawColor(150, 150, 150)
		surface.DrawRect(0, 0, creditsbtn:GetWide(), creditsbtn:GetTall())
		draw.DrawText("Credits", "Trebuchet24", creditsbtn:GetWide()*.5, creditsbtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
	end
end

concommand.Add("lenny_menu", lennymenu)

timer.Simple(.1, function() RunConsoleCommand("lenny_menu") end)