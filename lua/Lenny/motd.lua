--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]


function lennymotd(w, h, col)
	--BackGround
		surface.SetDrawColor(col)
		surface.DrawRect(0, 0 , w, h)
	--BackGround

	--Bottom BAR
		surface.SetDrawColor(255,128,0,255)
		--surface.DrawRect(0, h-5 , w, 5)
	--BOTTOM BAR

	--TOP BAR
		surface.SetDrawColor(255,128,0,255)
		--surface.DrawRect(0, 0 , w, 5)
	--TOP BAR

	--Left BAR
		surface.SetDrawColor(255,128,0,255)
		surface.DrawRect(0, 0 , 3, h)


	--right BAR
		surface.SetDrawColor(255,128,0,255)
		surface.DrawRect(w-3, 0 , w-3, h)

	end

local function lennymenu()
	local w = ScrW()
	local h = ScrH()

	local frame = vgui.Create("DFrame")
	frame:SetSize(w - 150, h - 150)
	frame:Center()
	frame:MakePopup()
	frame:ShowCloseButton(false)

	local fw, fh = frame:GetWide(), frame:GetTall()

	frame:SetTitle( "" )

	frame.Paint = function ()
		lennymotd(fw, fh, Color(30,30,30,255))
	end
	
	local closebtn = vgui.Create("DButton", frame)
	closebtn:SetSize(35,35)
	closebtn:SetText("")
	closebtn:SetPos(fw-60, 20)
	closebtn.DoClick = function()
		frame:Close()
	end
	closebtn.Paint = function()
		lennymotd(closebtn:GetWide(), closebtn:GetTall(), Color(30,30,30,255))
		draw.DrawText("X", "Trebuchet24", closebtn:GetWide()*.5, closebtn:GetTall()*.15, Color(255, 0, 0),TEXT_ALIGN_CENTER)
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
		lennymotd(donbtn:GetWide(), donbtn:GetTall(), Color(0,100,255,255))
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
		lennymotd(websitebtn:GetWide(), websitebtn:GetTall(), Color(50, 150, 150,255))
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
		lennymotd(tutsitebtn:GetWide(), tutsitebtn:GetTall(), Color(150, 150, 50,255))
		draw.DrawText("Tutorials (Coming Soon!)", "Trebuchet24", tutsitebtn:GetWide()*.5, tutsitebtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
	end

	local hofbtn = vgui.Create("DButton", frame)
	hofbtn:SetSize(250,75)
	hofbtn:SetPos(50, 535)
	hofbtn:SetText("")
	hofbtn.DoClick = function()
		gui.OpenURL("http://www.gmod.itsLenny.de/Lennys/hof")
	end
	hofbtn.Paint = function()
		lennymotd(hofbtn:GetWide(), hofbtn:GetTall(), Color(150, 50, 150,255))
		draw.DrawText("Hall Of Fame (New!)", "Trebuchet24", hofbtn:GetWide()*.5, hofbtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
	end

	local creditsbtn = vgui.Create("DButton", frame)
	creditsbtn:SetSize(250,75)
	creditsbtn:SetPos(50, 640)
	creditsbtn:SetText("")
	creditsbtn.DoClick = function()
		gui.OpenURL("http://bly.itslenny.de/1egpIXx")
	end
	creditsbtn.Paint = function()
		lennymotd(creditsbtn:GetWide(), creditsbtn:GetTall(), Color(150, 150, 150,255))
		draw.DrawText("Credits", "Trebuchet24", creditsbtn:GetWide()*.5, creditsbtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
	end

	local analyticsbtn = vgui.Create("DButton", frame)
	analyticsbtn:SetSize(300,60)
	analyticsbtn:SetPos(dbx - 400, fh-100)
	analyticsbtn:SetText("")
	analyticsbtn.DoClick = function()
		gui.OpenURL("http://www.gmod.itslenny.de/analytics/")
	end
	analyticsbtn.Paint = function()
		lennymotd(analyticsbtn:GetWide(), analyticsbtn:GetTall(), Color(0, 200, 255,255))
		draw.DrawText("Analytics (New!)", "Trebuchet24", analyticsbtn:GetWide()*.5, analyticsbtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
	end

	local serverbrowserbtn = vgui.Create("DButton", frame)
	serverbrowserbtn:SetSize(300,60)
	serverbrowserbtn:SetPos(dbx + 400, fh-100)
	serverbrowserbtn:SetText("")
	serverbrowserbtn.DoClick = function()
		gui.OpenURL("http://www.gmod.itslenny.de/analytics/serverbrowser")
	end
	serverbrowserbtn.Paint = function()
		lennymotd(serverbrowserbtn:GetWide(), serverbrowserbtn:GetTall(), Color(255, 0, 100, 255))
		draw.DrawText("Server Browser (New!)", "Trebuchet24", serverbrowserbtn:GetWide()*.5, serverbrowserbtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
	end
end

concommand.Add("lenny_menu", lennymenu)

timer.Simple(.1, function() RunConsoleCommand("lenny_menu") end)