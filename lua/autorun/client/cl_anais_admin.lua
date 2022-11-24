AnaisAdmin = {
	GUI = {}
}

AnaisAdmin.GUI.victim = nil
AnaisAdmin.GUI.criminel = nil
AnaisAdmin.GUI.PlySelectInfo = LocalPlayer()
AnaisAdmin.GUI.SanstionPly = nil

local tblutil = AnaisAdminMenu.Config.tblutil
local GDrugzUsergroup = {"superadmin", "admin", "Admin+", "Modérateur", "En - Test"}
local tblinfo = AnaisAdminMenu.Config.tblinfo

local tblac = {
	{name = "Warn",cmd = function() if AnaisAdmin.GUI.SanstionPly:IsValid() then RunConsoleCommand("awarn_warn",AnaisAdmin.GUI.SanstionPly:Nick(),AnaisAdmin.GUI.SanctionFrame.msg:GetValue() ) AnaisAdmin.GUI.SanctionFrame:Remove() end end,sort = 1},
	{name = "Kick",cmd = function() if AnaisAdmin.GUI.SanstionPly:IsValid() then RunConsoleCommand("ulx","kick",AnaisAdmin.GUI.SanstionPly:Nick(),AnaisAdmin.GUI.SanctionFrame.msg:GetValue() ) AnaisAdmin.GUI.SanctionFrame:Remove() end end,sort = 2},
	{name = "Ban",cmd = function() if AnaisAdmin.GUI.SanstionPly:IsValid() then RunConsoleCommand("ulx","ban",AnaisAdmin.GUI.SanstionPly:Nick(),AnaisAdmin.GUI.SanctionFrame.time:GetValue(),AnaisAdmin.GUI.SanctionFrame.msg:GetValue() ) AnaisAdmin.GUI.SanctionFrame:Remove() end end,sort = 3},
	{name = "Jail",cmd = function() if AnaisAdmin.GUI.SanstionPly:IsValid() then RunConsoleCommand("ulx","jail",AnaisAdmin.GUI.SanstionPly:Nick(),AnaisAdmin.GUI.SanctionFrame.time:GetValue(),AnaisAdmin.GUI.SanctionFrame.msg:GetValue() ) AnaisAdmin.GUI.SanctionFrame:Remove() end end,sort = 4},
}

local tblvictim = {
	{name = "Info",cmd = function() if !(IsValid(AnaisAdmin.GUI.victim)) then return false end if !(AnaisAdmin.GUI.victim:IsPlayer()) then return false end AnaisAdmin.GUI.CreateAdminPlayerInfo(AnaisAdmin.GUI.victim) end,sort = 1},
	{name = "Goto",cmd = function() if !(IsValid(AnaisAdmin.GUI.victim)) then return false end if !(AnaisAdmin.GUI.victim:IsPlayer()) then return false end RunConsoleCommand("ulx","goto",AnaisAdmin.GUI.victim:Nick()) end,sort = 2},
	{name = "Bring",cmd = function() if !(IsValid(AnaisAdmin.GUI.victim)) then return false end if !(AnaisAdmin.GUI.victim:IsPlayer()) then return false end RunConsoleCommand("ulx","bring",AnaisAdmin.GUI.victim:Nick()) end,sort = 3},
	{name = "Return",cmd = function() if !(IsValid(AnaisAdmin.GUI.victim)) then return false end if !(AnaisAdmin.GUI.victim:IsPlayer()) then return false end RunConsoleCommand("ulx","return",AnaisAdmin.GUI.victim:Nick()) end,sort = 4},
	{name = "Sanction",cmd = function() if !(IsValid(AnaisAdmin.GUI.victim)) then return false end if !(AnaisAdmin.GUI.victim:IsPlayer()) then return false end AnaisAdmin.GUI.CreateSanctionMenu(AnaisAdmin.GUI.victim) end,sort = 5}
}

local tblcriminel = {
	{name = "Info",cmd = function() if !(IsValid(AnaisAdmin.GUI.criminel)) then return false end if !(AnaisAdmin.GUI.criminel:IsPlayer()) then return false end AnaisAdmin.GUI.CreateAdminPlayerInfo(AnaisAdmin.GUI.criminel) end,sort = 1},
	{name = "Goto",cmd = function() if !(IsValid(AnaisAdmin.GUI.criminel)) then return false end if !(AnaisAdmin.GUI.criminel:IsPlayer()) then return false end RunConsoleCommand("ulx","goto",AnaisAdmin.GUI.criminel:Nick()) end,sort = 2},
	{name = "Bring",cmd = function() if !(IsValid(AnaisAdmin.GUI.criminel)) then return false end if !(AnaisAdmin.GUI.criminel:IsPlayer()) then return false end RunConsoleCommand("ulx","bring",AnaisAdmin.GUI.criminel:Nick()) end,sort = 3},
	{name = "Return",cmd = function() if !(IsValid(AnaisAdmin.GUI.criminel)) then return false end if !(AnaisAdmin.GUI.criminel:IsPlayer()) then return false end RunConsoleCommand("ulx","return",AnaisAdmin.GUI.criminel:Nick()) end,sort = 4},
	{name = "Sanction",cmd = function() if !(IsValid(AnaisAdmin.GUI.criminel)) then return false end if !(AnaisAdmin.GUI.criminel:IsPlayer()) then return false end AnaisAdmin.GUI.CreateSanctionMenu(AnaisAdmin.GUI.criminel) end,sort = 5}
}

function AnaisAdmin.GUI.CreateAlertMenu()

	AnaisAdmin.GUI.AlertMenu = vgui.Create("DFrame")
	AnaisAdmin.GUI.AlertMenu:SetSize(ScrW()/5,ScrH()/6)
	AnaisAdmin.GUI.AlertMenu:Center()
	AnaisAdmin.GUI.AlertMenu:SetTitle("AlertMenu")
	AnaisAdmin.GUI.AlertMenu:MakePopup()

	AnaisAdmin.GUI.AlertMenu.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
		draw.RoundedBox(0,0,0,w,25,Color(30,30,35))
		draw.RoundedBox(0,0,25,w,2,AnaisAdminMenu.Config.MainColor)
	end

	AnaisAdmin.GUI.AlertMenu.msg = vgui.Create("DTextEntry", AnaisAdmin.GUI.AlertMenu)
	AnaisAdmin.GUI.AlertMenu.msg:SetSize(ScrW()/5,(ScrH()/6)/5)
	AnaisAdmin.GUI.AlertMenu.msg:SetPos(0,25+(ScrH()/6)/5)
	AnaisAdmin.GUI.AlertMenu.msg.Paint = function(s,w,h)
		if AnaisAdmin.GUI.AlertMenu.msg:IsHovered() then	
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
		else
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
		end
		if AnaisAdmin.GUI.AlertMenu.msg:GetValue() == "" then
			draw.SimpleText("Message . . .","Anais:Roboto:15",w/2,h/2,Color(100,100,100,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(AnaisAdmin.GUI.AlertMenu.msg:GetValue(),"Anais:Roboto:15",w/2,h/2,Color(255,255,255,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
	end

	AnaisAdmin.GUI.AlertMenu.Send = vgui.Create("DButton",AnaisAdmin.GUI.AlertMenu)
	AnaisAdmin.GUI.AlertMenu.Send:SetSize((ScrW()/5),(ScrH()/6)/5)
	AnaisAdmin.GUI.AlertMenu.Send:SetPos(0,(ScrH()/6)-(ScrH()/6)/5)
	AnaisAdmin.GUI.AlertMenu.Send:SetText("Alert")
	AnaisAdmin.GUI.AlertMenu.Send:SetTextColor(Color(255,255,255))

	AnaisAdmin.GUI.AlertMenu.Send.Paint = function(s,w,h)
		if AnaisAdmin.GUI.AlertMenu.Send:IsHovered() then	
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
		else
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
		end
		draw.RoundedBox(0,0,0,w,2,AnaisAdminMenu.Config.MainColor)
		draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
	end

	AnaisAdmin.GUI.AlertMenu.Send.DoClick = function()
		net.Start("SvAnaisAdmin_CreateAlert")
			net.WriteString(AnaisAdmin.GUI.AlertMenu.msg:GetValue())
		net.SendToServer()
	end

end

function AnaisAdmin.GUI.CreateSanctionMenu(ply)
	AnaisAdmin.GUI.SanstionPly = ply
	if IsValid(AnaisAdmin.GUI.SanctionFrame) then return false end

	AnaisAdmin.GUI.SanctionFrame = vgui.Create("DFrame")
	AnaisAdmin.GUI.SanctionFrame:SetSize(ScrW()/5,ScrH()/5)
	AnaisAdmin.GUI.SanctionFrame:Center()
	AnaisAdmin.GUI.SanctionFrame:SetTitle("Sanction")
	AnaisAdmin.GUI.SanctionFrame:MakePopup()
	AnaisAdmin.GUI.SanctionFrame.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
		draw.RoundedBox(0,0,0,w,25,Color(30,30,35))
		draw.RoundedBox(0,0,25,w,2,AnaisAdminMenu.Config.MainColor)
	end

	AnaisAdmin.GUI.ShowPlayerSanction = vgui.Create( "DComboBox" ,AnaisAdmin.GUI.SanctionFrame)
	AnaisAdmin.GUI.ShowPlayerSanction:SetPos(0,27)
	AnaisAdmin.GUI.ShowPlayerSanction:SetSize(ScrW()/5,ScrH()/40)
	AnaisAdmin.GUI.ShowPlayerSanction:SetValue( ply:Nick(),ply )

	AnaisAdmin.GUI.ShowPlayerSanction.DoClick = function()
		AnaisAdmin.GUI.ShowPlayerSanction:Clear()
		AnaisAdmin.GUI.ShowPlayerSanction:SetValue( "Liste des joueurs" )
		for k, v in pairs(player.GetAll()) do
			AnaisAdmin.GUI.ShowPlayerSanction:AddChoice(v:Nick(),v)
		end

		AnaisAdmin.GUI.ShowPlayerSanction:OpenMenu()
	end

	AnaisAdmin.GUI.ShowPlayerSanction.OnSelect = function( panel, index, value, data )
		AnaisAdmin.GUI.SanctionFrame:SetTitle(data:Nick())
		AnaisAdmin.GUI.SanstionPly = data
	end

	AnaisAdmin.GUI.SanctionFrame.msg = vgui.Create("DTextEntry", AnaisAdmin.GUI.SanctionFrame)
	AnaisAdmin.GUI.SanctionFrame.msg:SetSize(ScrW()/5-(ScrW()/5)/4,ScrH()/40)
	AnaisAdmin.GUI.SanctionFrame.msg:SetPos(0,ScrH()/40+27)
	AnaisAdmin.GUI.SanctionFrame.msg:SetValue("Motif...")

	AnaisAdmin.GUI.SanctionFrame.time = vgui.Create("DTextEntry", AnaisAdmin.GUI.SanctionFrame)
	AnaisAdmin.GUI.SanctionFrame.time:SetSize((ScrW()/5)/4,ScrH()/40)
	AnaisAdmin.GUI.SanctionFrame.time:SetPos(ScrW()/5-(ScrW()/5)/4,ScrH()/40+27)
	AnaisAdmin.GUI.SanctionFrame.time:SetValue("300")

	for k, v in pairs(tblac) do
		local ActionBtn = vgui.Create("DButton",AnaisAdmin.GUI.SanctionFrame)
		ActionBtn:SetPos(0,27+ScrH()/40+(v.sort+(ScrH()/40)*v.sort))
		ActionBtn:SetSize(ScrW()/5,ScrH()/40)
		ActionBtn:SetTextColor(Color(255,255,255))
		ActionBtn:SetText(v.name)
		ActionBtn.Paint = function(s,w,h)
			if ActionBtn:IsHovered() then
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
			end
			draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
		end
		ActionBtn.DoClick = v.cmd
	end

end

function AnaisAdmin.GUI.CreateAdminPlayerInfo(ply)

	if !(ply.IsPlayer()) then return false end
	if !(LocalPlayer():IsAdmin()) then return false end

	if IsValid(AnaisAdmin.GUI.AdminPlayerInfo) then
		AnaisAdmin.GUI.AdminPlayerInfo:Remove()
	end

	AnaisAdmin.GUI.AdminPlayerInfo = vgui.Create("DFrame")
	AnaisAdmin.GUI.AdminPlayerInfo:SetSize( ScrW(), (ScrH()/2)-((ScrH()/25)*3.5) -30)
	AnaisAdmin.GUI.AdminPlayerInfo:SetPos( (ScrW()/2)-((ScrW())/2), 30)
	AnaisAdmin.GUI.AdminPlayerInfo:MakePopup()
	AnaisAdmin.GUI.AdminPlayerInfo:ShowCloseButton(false)
	AnaisAdmin.GUI.AdminPlayerInfo:SetTitle(" ")

	AnaisAdmin.GUI.AdminPlayerInfo.Paint = function(s, w, h)
		if not ply:IsValid() or not ply:IsPlayer() then return false end
		draw.SimpleTextOutlined(ply:Nick(),"Anais:Roboto:25",(ScrW())/2,((ScrH()/2)-((ScrH()/25)*3.5))/90,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP,1,Color(10,10,10))

		draw.SimpleTextOutlined("Jobs: "..ply:getDarkRPVar("job"),"Anais:Roboto:20",((ScrW())/2)+(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,1,Color(10,10,10))
		draw.SimpleTextOutlined("Money: "..DarkRP.formatMoney(ply:getDarkRPVar("money")),"Anais:Roboto:20",((ScrW())/2)+(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,1,Color(10,10,10))
		
		if ply:getDarkRPVar("wanted") then
			draw.SimpleTextOutlined("Wanted: Oui","Anais:Roboto:20",((ScrW())/2)+(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20*2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,1,Color(10,10,10))
		else
			draw.SimpleTextOutlined("Wanted: Non","Anais:Roboto:20",((ScrW())/2)+(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20*2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,1,Color(10,10,10))
		end

		if ply:getDarkRPVar("HasGunlicense") then
			draw.SimpleTextOutlined("Gunlicense: Oui","Anais:Roboto:20",((ScrW())/2)+(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20*3,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,1,Color(10,10,10))
		else
			draw.SimpleTextOutlined("Gunlicense: Non","Anais:Roboto:20",((ScrW())/2)+(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20*3,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,1,Color(10,10,10))
		end
	
		if ply:getDarkRPVar("Arrested") then
			draw.SimpleTextOutlined("Arrested: Oui","Anais:Roboto:20",((ScrW())/2)+(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20*4,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,1,Color(10,10,10))
		else
			draw.SimpleTextOutlined("Arrested: Non","Anais:Roboto:20",((ScrW())/2)+(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20*4,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,1,Color(10,10,10))
		end
		if !(ply:IsBot()) then
			draw.SimpleTextOutlined("SteamID: "..ply:SteamID(),"Anais:Roboto:20",((ScrW())/2)-(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP,1,Color(10,10,10))
			draw.SimpleTextOutlined("SteamID64: "..ply:SteamID64(),"Anais:Roboto:20",((ScrW())/2)-(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP,1,Color(10,10,10))
			draw.SimpleTextOutlined("Grade Utilisateur: "..ply:GetUserGroup(),"Anais:Roboto:20",((ScrW())/2)-(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20*2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP,1,Color(10,10,10))
			draw.SimpleTextOutlined("Ping Client/Server: "..ply:Ping().." ms","Anais:Roboto:20",((ScrW())/2)-(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20*3,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP,1,Color(10,10,10))
			draw.SimpleTextOutlined("Custom client files: "..table.Count(ply:GetPlayerInfo().customfiles),"Anais:Roboto:20",((ScrW())/2)-(ScrW())/10,((ScrH()/2)-((ScrH()/25)*3.5))/6+ScrH()/20*4,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP,1,Color(10,10,10))
		end
	end

	AnaisAdmin.GUI.AdminPlayerInfo.Models = vgui.Create("DModelPanel", AnaisAdmin.GUI.AdminPlayerInfo)
	AnaisAdmin.GUI.AdminPlayerInfo.Models:SetSize( ScrW()/5, (ScrH()/2)-((ScrH()/25)*3.5) -30)
	AnaisAdmin.GUI.AdminPlayerInfo.Models:SetPos(((ScrW())-(ScrW()/5))/2,0)
	AnaisAdmin.GUI.AdminPlayerInfo.Models:SetModel(ply:GetModel())

	AnaisAdmin.GUI.Frame:MoveToFront()
end

function AnaisAdmin.GUI.CreatePlyList()

	if not IsValid(AnaisAdmin.GUI.ShowPlayerFrame) then return false end
	if IsValid(AnaisAdmin.GUI.ShowPlayerFrame.list) then return false end

	AnaisAdmin.GUI.ShowPlayerFrame.list = vgui.Create( "DComboBox" ,AnaisAdmin.GUI.ShowPlayerFrame)
	AnaisAdmin.GUI.ShowPlayerFrame.list:SetPos(0,(ScrH()/20))
	AnaisAdmin.GUI.ShowPlayerFrame.list:SetSize(AnaisAdmin.GUI.ShowPlayerFrame:GetWide()-2,ScrH()/40)
	AnaisAdmin.GUI.ShowPlayerFrame.list:SetValue( "Liste des joueurs" )

	AnaisAdmin.GUI.ShowPlayerFrame.list.DoClick = function()
		AnaisAdmin.GUI.ShowPlayerFrame.list:Clear()
		AnaisAdmin.GUI.ShowPlayerFrame.list:SetValue( "Liste des joueurs" )
		for k, v in pairs(player.GetAll()) do
			AnaisAdmin.GUI.ShowPlayerFrame.list:AddChoice(v:Nick(),v)
		end

		AnaisAdmin.GUI.ShowPlayerFrame.list:OpenMenu()
	end

	AnaisAdmin.GUI.ShowPlayerFrame.list.OnSelect = function( panel, index, value, data )
		AnaisAdmin.GUI.CreateAdminPlayerInfo(data)
		AnaisAdmin.GUI.PlySelectInfo = data
	end
end

function AnaisAdmin.GUI.Create()
	if not LocalPlayer():IsValid() or not table.HasValue(GDrugzUsergroup, LocalPlayer():GetUserGroup() or "user") then return end
	if not IsValid(AnaisAdmin.GUI.Frame) then
		AnaisAdmin.GUI.Frame = vgui.Create("DFrame")
		AnaisAdmin.GUI.Frame:SetSize(ScrW()/5,ScrH()/2)
		AnaisAdmin.GUI.Frame:SetPos(100, ScrH()-ScrH()/2)
		AnaisAdmin.GUI.Frame:MakePopup()
		AnaisAdmin.GUI.Frame:SetTitle("Dark Admin Menu :")
		AnaisAdmin.GUI.Frame:ShowCloseButton(false)
		AnaisAdmin.GUI.Frame:SetVisible(false)
		AnaisAdmin.GUI.Frame.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			draw.RoundedBox(0,0,0,w,25,Color(30,30,35))
			draw.RoundedBox(0,0,25,w,2,AnaisAdminMenu.Config.MainColor)
		end

		AnaisAdmin.GUI.Frame.ReducBtn = vgui.Create("DButton",AnaisAdmin.GUI.Frame)
		AnaisAdmin.GUI.Frame.ReducBtn:SetSize(25,25)
		AnaisAdmin.GUI.Frame.ReducBtn:SetPos((ScrW()/5)-25,0)
		AnaisAdmin.GUI.Frame.ReducBtn:SetText("_")
		AnaisAdmin.GUI.Frame.ReducBtn:SetTextColor(Color(255,255,255))
		AnaisAdmin.GUI.Frame.ReducBtn.Paint = function(s,w,h)
			if AnaisAdmin.GUI.Frame.ReducBtn:IsHovered() then
				surface.SetDrawColor( Color(180,180,180) )
				surface.DrawOutlinedRect( 0, 0, w, h )
			end
		end
		AnaisAdmin.GUI.Frame.IsReduc = true
		AnaisAdmin.GUI.Frame.ReducBtn.DoClick = function()
			if AnaisAdmin.GUI.Frame.IsReduc then
				AnaisAdmin.GUI.Frame:SizeTo(-1,25,1,0,-1)
				AnaisAdmin.GUI.Frame.IsReduc = false
			else
				AnaisAdmin.GUI.Frame:SizeTo(-1,ScrH()/2,1,0,-1)
				AnaisAdmin.GUI.Frame.IsReduc = true
			end
		end

		AnaisAdmin.GUI.Frame.DScrollPanel = vgui.Create( "DScrollPanel", AnaisAdmin.GUI.Frame )
		AnaisAdmin.GUI.Frame.DScrollPanel:SetSize(ScrW()/5,(ScrH()/2)-25)
		AnaisAdmin.GUI.Frame.DScrollPanel:SetPos(0,25)
		AnaisAdmin.GUI.Frame.DScrollPanel:Dock( FILL )

		local BarPaint = AnaisAdmin.GUI.Frame.DScrollPanel:GetVBar()
		BarPaint:SetSize(0,0)
    	function BarPaint:Paint( w, h )
    	end

		AnaisAdmin.GUI.ShowInfoFrame = AnaisAdmin.GUI.Frame.DScrollPanel:Add("Panel")
		AnaisAdmin.GUI.ShowInfoFrame:SetSize(ScrW()/5,ScrH()/20)
		AnaisAdmin.GUI.ShowInfoFrame:Dock(TOP)
		AnaisAdmin.GUI.ShowInfoFrame:DockMargin( 0, 0, 0, 5 )
		AnaisAdmin.GUI.ShowInfoFrame.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
			draw.SimpleText("En ligne: "..table.Count(player.GetAll()).." / "..game.MaxPlayers(),"Anais:Roboto:15",w/50,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(os.date( "%H h %M" , os.time() ),"Anais:Roboto:15",w-(w/50),h/2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
		end

        --[[-------------------------------------------------------------------------
 									Show Util
		---------------------------------------------------------------------------]]

		AnaisAdmin.GUI.ShowUtilFrame = AnaisAdmin.GUI.Frame.DScrollPanel:Add("Panel")
		AnaisAdmin.GUI.ShowUtilFrame:SetSize(ScrW()/5,ScrH()/20)
		AnaisAdmin.GUI.ShowUtilFrame:Dock(TOP)
		AnaisAdmin.GUI.ShowUtilFrame:DockMargin(0,0,0,5)
		AnaisAdmin.GUI.ShowUtilFrame.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
		end

		AnaisAdmin.GUI.ShowUtil = vgui.Create("DButton",AnaisAdmin.GUI.ShowUtilFrame)
		AnaisAdmin.GUI.ShowUtil:SetSize(ScrW()/5,ScrH()/20)
		AnaisAdmin.GUI.ShowUtil:SetText(" ")
		AnaisAdmin.GUI.ShowUtil.Paint = function(s,w,h)
			if AnaisAdmin.GUI.ShowUtil:IsHovered() then
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
			end
			draw.RoundedBox(0,0,0,w,2,AnaisAdminMenu.Config.MainColor)
			draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
			draw.SimpleText("Utile","Anais:Roboto:20",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		AnaisAdmin.GUI.ShowUtilFrame.IsReduc = true
		AnaisAdmin.GUI.ShowUtil.DoClick = function()
			if AnaisAdmin.GUI.ShowUtilFrame.IsReduc then
				AnaisAdmin.GUI.ShowUtilFrame:SizeTo(-1,(ScrH()/40)*table.Count(tblutil)+ScrH()/20,0.5,0,-1)
				AnaisAdmin.GUI.ShowUtilFrame.IsReduc = false
			else
				AnaisAdmin.GUI.ShowUtilFrame:SizeTo(-1,ScrH()/20,0.5,0,-1)
				AnaisAdmin.GUI.ShowUtilFrame.IsReduc = true
			end
		end

		for k, v in pairs(tblutil) do
			local ActionBtn = vgui.Create("DButton",AnaisAdmin.GUI.ShowUtilFrame)
			ActionBtn:SetPos(0,(ScrH()/20)+((ScrH()/40)*v.sort))
			ActionBtn:SetSize(ScrW()/5,ScrH()/40)
			ActionBtn:SetTextColor(Color(255,255,255))
			ActionBtn:SetText(v.name)
			ActionBtn.Paint = function(s,w,h)
				if ActionBtn:IsHovered() then
					draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
				else
					draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
				end
				draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
			end
			ActionBtn.DoClick = v.cmd
		end

        --[[-------------------------------------------------------------------------
 									Show player help
		---------------------------------------------------------------------------]]

		AnaisAdmin.GUI.ShowPlayerFrame = AnaisAdmin.GUI.Frame.DScrollPanel:Add("Panel")
		AnaisAdmin.GUI.ShowPlayerFrame:SetSize(ScrW()/5,ScrH()/20)
		AnaisAdmin.GUI.ShowPlayerFrame:Dock(TOP)
		AnaisAdmin.GUI.ShowPlayerFrame:DockMargin(0,0,0,5)
		AnaisAdmin.GUI.ShowPlayerFrame.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
		end

		AnaisAdmin.GUI.ShowPlayer = vgui.Create("DButton",AnaisAdmin.GUI.ShowPlayerFrame)
		AnaisAdmin.GUI.ShowPlayer:SetSize(ScrW()/5,ScrH()/20)
		AnaisAdmin.GUI.ShowPlayer:SetText(" ")
		AnaisAdmin.GUI.ShowPlayer.Paint = function(s,w,h)
			if AnaisAdmin.GUI.ShowPlayer:IsHovered() then
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
			end
			draw.RoundedBox(0,0,0,w,2,AnaisAdminMenu.Config.MainColor)
			draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
			draw.SimpleText("Info joueur","Anais:Roboto:20",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		AnaisAdmin.GUI.ShowPlayerFrame.IsReduc = true
		AnaisAdmin.GUI.ShowPlayer.DoClick = function()

			if AnaisAdmin.GUI.ShowPlayerFrame.IsReduc then
				AnaisAdmin.GUI.CreatePlyList()
				AnaisAdmin.GUI.ShowPlayerFrame:SizeTo(-1,((ScrH()/40)*table.Count(tblinfo)+ScrH()/20)+(ScrH()/40)*2,0.5,0,-1)
				AnaisAdmin.GUI.ShowPlayerFrame.IsReduc = false
			else
				AnaisAdmin.GUI.ShowPlayerFrame:SizeTo(-1,ScrH()/20,0.5,0,-1)
				AnaisAdmin.GUI.ShowPlayerFrame.IsReduc = true
			end

		end

		for k, v in pairs(tblinfo) do
			local ActionBtn = vgui.Create("DButton",AnaisAdmin.GUI.ShowPlayerFrame)
			ActionBtn:SetPos(0,(ScrH()/20)+(v.sort+(ScrH()/40)*v.sort))
			ActionBtn:SetSize(ScrW()/5,ScrH()/40)
			ActionBtn:SetTextColor(Color(255,255,255))
			ActionBtn:SetText(v.name)
			ActionBtn.Paint = function(s,w,h)
				if ActionBtn:IsHovered() then
					draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
				else
					draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
				end
				draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
			end
			ActionBtn.DoClick = v.cmd
		end

		--[[-------------------------------------------------------------------------
		 							Show Report
		---------------------------------------------------------------------------]]

		AnaisAdmin.GUI.ShowReportFrame = AnaisAdmin.GUI.Frame.DScrollPanel:Add("Panel")
		AnaisAdmin.GUI.ShowReportFrame:SetSize(ScrW()/5,ScrH()/20)
		AnaisAdmin.GUI.ShowReportFrame:Dock(TOP)
		AnaisAdmin.GUI.ShowReportFrame:DockMargin(0,0,0,5)
		AnaisAdmin.GUI.ShowReportFrame.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
			draw.RoundedBox(0,((ScrW()/5)/2)-1,(ScrH()/20),2,h-(ScrH()/20),AnaisAdminMenu.Config.MainColor)
			draw.SimpleText("Victime","Anais:Roboto:20",((ScrW()/5)/2)/2,(ScrH()/20)+(ScrH()/50),Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			draw.SimpleText("Criminel","Anais:Roboto:20",( ( ScrW()/5 )/2 )+((ScrW()/5)/2)/2,(ScrH()/20)+(ScrH()/50),Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end

		AnaisAdmin.GUI.ShowReportBtn = vgui.Create("DButton",AnaisAdmin.GUI.ShowReportFrame)
		AnaisAdmin.GUI.ShowReportBtn:SetSize(ScrW()/5,ScrH()/20)
		AnaisAdmin.GUI.ShowReportBtn:SetText(" ")
		AnaisAdmin.GUI.ShowReportBtn.Paint = function(s,w,h)
			if AnaisAdmin.GUI.ShowReportBtn:IsHovered() then
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
			end
			draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
			draw.SimpleText("Report","Anais:Roboto:20",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		AnaisAdmin.GUI.ShowReportFrame.IsReduc = true

		for k, v in pairs(tblvictim) do
			local ActionBtn = vgui.Create("DButton",AnaisAdmin.GUI.ShowReportFrame)
			ActionBtn:SetPos(0,(ScrH()/20)+(ScrH()/20)+(v.sort+(ScrH()/40)*v.sort))
			ActionBtn:SetSize(((ScrW()/5)/2)-1,ScrH()/40)
			ActionBtn:SetTextColor(Color(255,255,255))
			ActionBtn:SetText(v.name)
			ActionBtn.Paint = function(s,w,h)
				if ActionBtn:IsHovered() then
					draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
				else
					draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
				end
				draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
			end
			ActionBtn.DoClick = v.cmd
		end

		for k, v in pairs(tblcriminel) do
			local ActionBtn = vgui.Create("DButton",AnaisAdmin.GUI.ShowReportFrame)
			ActionBtn:SetPos(((ScrW()/5)/2)+1,(ScrH()/20)+(ScrH()/20)+(v.sort+(ScrH()/40)*v.sort))
			ActionBtn:SetSize(((ScrW()/5)/2)-1,ScrH()/40)
			ActionBtn:SetTextColor(Color(255,255,255))
			ActionBtn:SetText(v.name)
			ActionBtn.Paint = function(s,w,h)
				if ActionBtn:IsHovered() then
					draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
				else
					draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
				end
				draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
			end
			ActionBtn.DoClick = v.cmd
		end

		AnaisAdmin.GUI.ReportFinish = vgui.Create("DButton",AnaisAdmin.GUI.ShowReportFrame)
		AnaisAdmin.GUI.ReportFinish:SetSize((ScrW()/5)/3,(ScrH()/3)/10)
		AnaisAdmin.GUI.ReportFinish:SetPos(((ScrW()/5)/2)-((ScrW()/5)/3)/2,(ScrH()/3)-((ScrH()/3)/10))
		AnaisAdmin.GUI.ReportFinish:SetText("Finish")
		AnaisAdmin.GUI.ReportFinish:SetTextColor(Color(255,255,255))
		AnaisAdmin.GUI.ReportFinish.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,AnaisAdminMenu.Config.MainColor)
		end
		AnaisAdmin.GUI.ReportFinish.DoClick = function()
			if AnaisAdmin.GUI.ShowReportFrame.IsReduc then
				AnaisAdmin.GUI.ShowReportFrame:SizeTo(-1,ScrH()/3,0.5,0,-1)
				AnaisAdmin.GUI.ShowReportFrame.IsReduc = false
			else
				AnaisAdmin.GUI.ShowReportFrame:SizeTo(-1,ScrH()/20,0.5,0,-1)
				AnaisAdmin.GUI.ShowReportFrame.IsReduc = true
			end
		end
	end
end

function AnaisAdmin.GUI.SetReport(report)
	AnaisAdmin.GUI.ShowReportFrame:SizeTo(-1,ScrH()/3,0.5,0,-1)
	AnaisAdmin.GUI.ShowReportFrame.IsReduc = false
	AnaisAdmin.GUI.victim = report.victim
	AnaisAdmin.GUI.criminel = report.criminel
end

function AnaisAdmin.GUI.CreateReport(victim,criminal,raison,id)
	if IsValid(AnaisAdmin.GUI[victim:SteamID64()..id]) then return false end
	AnaisAdmin.GUI[victim:SteamID64()..id] = AnaisAdmin.GUI.Frame.DScrollPanel:Add("DFrame")
	AnaisAdmin.GUI[victim:SteamID64()..id]:SetSize(ScrW()/5,ScrH()/7)
	AnaisAdmin.GUI[victim:SteamID64()..id]:Dock( TOP )
	AnaisAdmin.GUI[victim:SteamID64()..id]:ShowCloseButton(false)
	AnaisAdmin.GUI[victim:SteamID64()..id]:SetDraggable(false)
	AnaisAdmin.GUI[victim:SteamID64()..id]:SetTitle(" ")
	AnaisAdmin.GUI[victim:SteamID64()..id]:DockMargin( 0, 0, 0, 5 )
	AnaisAdmin.GUI[victim:SteamID64()..id].Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
		draw.RoundedBox(0,0,0,w/50,h,AnaisAdminMenu.Config.MainColor)
		draw.SimpleText("Victime: "..victim:Name(),"Anais:Roboto:15",w/40,(h/5),Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
		draw.SimpleText("Criminel: "..criminal:Name(),"Anais:Roboto:15",w/40,(h/5)*2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
		draw.SimpleText("Raison: "..raison,"Anais:Roboto:15",w/40,(h/5)*3,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
	end

	AnaisAdmin.GUI.ReportClaim = vgui.Create("DButton",AnaisAdmin.GUI[victim:SteamID64()..id])
	AnaisAdmin.GUI.ReportClaim:SetSize((ScrW()/5)/3,(ScrH()/7)/5)
	AnaisAdmin.GUI.ReportClaim:SetPos(((ScrW()/5)/2)-((ScrW()/5)/3)/2,(ScrH()/7)-((ScrH()/7)/5))
	AnaisAdmin.GUI.ReportClaim:SetText("Claim")
	AnaisAdmin.GUI.ReportClaim:SetTextColor(Color(255,255,255))
	AnaisAdmin.GUI.ReportClaim.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,AnaisAdminMenu.Config.MainColor)
	end

	AnaisAdmin.GUI.ReportClaim.DoClick = function()
		net.Start("SvAnaisAdmin_ClaimReport")
			net.WriteString(victim:SteamID64()..id)
		net.SendToServer()

		AnaisAdmin.GUI.CreateAdminPlayerInfo(victim)
		AnaisAdmin.GUI.SetReport({victim = victim,criminel = criminal})
	end
end

function AnaisAdmin.GUI.CreateCall(victim,raison,id)
	if IsValid(AnaisAdmin.GUI[victim:SteamID64()..id]) then return false end
	AnaisAdmin.GUI[victim:SteamID64()..id] = AnaisAdmin.GUI.Frame.DScrollPanel:Add("DFrame")
	AnaisAdmin.GUI[victim:SteamID64()..id]:SetSize(ScrW()/5,ScrH()/7)
	AnaisAdmin.GUI[victim:SteamID64()..id]:Dock( TOP )
	AnaisAdmin.GUI[victim:SteamID64()..id]:ShowCloseButton(false)
	AnaisAdmin.GUI[victim:SteamID64()..id]:SetDraggable(false)
	AnaisAdmin.GUI[victim:SteamID64()..id]:SetTitle(" ")
	AnaisAdmin.GUI[victim:SteamID64()..id]:DockMargin( 0, 0, 0, 5 )
	AnaisAdmin.GUI[victim:SteamID64()..id].Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
		draw.RoundedBox(0,0,0,w/50,h,AnaisAdminMenu.Config.MainColor)
		draw.SimpleText("Nom: "..victim:Name(),"Anais:Roboto:15",w/40,(h/5),Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
		draw.SimpleText("Raison: "..raison,"Anais:Roboto:15",w/40,(h/5)*2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
	end

	AnaisAdmin.GUI.ReportClaim = vgui.Create("DButton",AnaisAdmin.GUI[victim:SteamID64()..id])
	AnaisAdmin.GUI.ReportClaim:SetSize((ScrW()/5)/3,(ScrH()/7)/5)
	AnaisAdmin.GUI.ReportClaim:SetPos(((ScrW()/5)/2)-((ScrW()/5)/3)/2,(ScrH()/7)-((ScrH()/7)/5))
	AnaisAdmin.GUI.ReportClaim:SetText("Claim")
	AnaisAdmin.GUI.ReportClaim:SetTextColor(Color(255,255,255))
	AnaisAdmin.GUI.ReportClaim.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,AnaisAdminMenu.Config.MainColor)
	end

	AnaisAdmin.GUI.ReportClaim.DoClick = function()
		net.Start("SvAnaisAdmin_ClaimReport")
			net.WriteString(victim:SteamID64()..id)
		net.SendToServer()

		AnaisAdmin.GUI.CreateAdminPlayerInfo(victim)
		AnaisAdmin.GUI.SetReport({victim = victim,criminel = victim})
	end
end

function AnaisAdmin.GUI.CreateAdminCallReport()

		if IsValid(AnaisAdmin.GUI.MenuCallAdminReport) then AnaisAdmin.GUI.MenuCallAdminReport:Remove() end

		AnaisAdmin.GUI.MenuCallAdminReport = vgui.Create("DFrame")
		AnaisAdmin.GUI.MenuCallAdminReport:SetSize(ScrW()/5,ScrH()/6)
		AnaisAdmin.GUI.MenuCallAdminReport:Center()
		AnaisAdmin.GUI.MenuCallAdminReport:SetTitle("Demander un admin")
		AnaisAdmin.GUI.MenuCallAdminReport:ShowCloseButton(false)
		AnaisAdmin.GUI.MenuCallAdminReport:SetDraggable(false)
		AnaisAdmin.GUI.MenuCallAdminReport:MakePopup()

		AnaisAdmin.GUI.MenuCallAdminReport.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			draw.RoundedBox(0,0,0,w,25,Color(30,30,35))
			draw.RoundedBox(0,0,25,w,2,AnaisAdminMenu.Config.MainColor)
		end

		AnaisAdmin.GUI.MenuCallAdminReport.msg = vgui.Create("DTextEntry", AnaisAdmin.GUI.MenuCallAdminReport)
		AnaisAdmin.GUI.MenuCallAdminReport.msg:SetSize(ScrW()/5,(ScrH()/6)/5)
		AnaisAdmin.GUI.MenuCallAdminReport.msg:SetPos(0,25+(ScrH()/6)/5)
		AnaisAdmin.GUI.MenuCallAdminReport.msg.Paint = function(s,w,h)
			if AnaisAdmin.GUI.MenuCallAdminReport.msg:IsHovered() then	
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			end
			if AnaisAdmin.GUI.MenuCallAdminReport.msg:GetValue() == "" then
				draw.SimpleText("Motif du report . . .","Anais:Roboto:15",w/2,h/2,Color(100,100,100,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(AnaisAdmin.GUI.MenuCallAdminReport.msg:GetValue(),"Anais:Roboto:15",w/2,h/2,Color(255,255,255,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		end

		AnaisAdmin.GUI.MenuCallAdminReport.Report = vgui.Create("DButton",AnaisAdmin.GUI.MenuCallAdminReport)
		AnaisAdmin.GUI.MenuCallAdminReport.Report:SetSize((ScrW()/5)/2,(ScrH()/6)/5)
		AnaisAdmin.GUI.MenuCallAdminReport.Report:SetPos(0,(ScrH()/6)-(ScrH()/6)/5)
		AnaisAdmin.GUI.MenuCallAdminReport.Report:SetText("Appeler")
		AnaisAdmin.GUI.MenuCallAdminReport.Report:SetTextColor(Color(255,255,255))

		AnaisAdmin.GUI.MenuCallAdminReport.Report.Paint = function(s,w,h)
			if AnaisAdmin.GUI.MenuCallAdminReport.Report:IsHovered() then	
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			end
			draw.RoundedBox(0,0,0,w,2,AnaisAdminMenu.Config.MainColor)
			draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
		end

		AnaisAdmin.GUI.MenuCallAdminReport.Report.DoClick = function()
			net.Start("SvAnaisAdmin_report")
				net.WriteEntity(LocalPlayer())
				net.WriteEntity(LocalPlayer())
				net.WriteString(AnaisAdmin.GUI.MenuCallAdminReport.msg:GetValue())
			net.SendToServer()

			AnaisAdmin.GUI.MenuCallAdminReport:Remove()
		end

		AnaisAdmin.GUI.MenuCallAdminReport.Cancel = vgui.Create("DButton",AnaisAdmin.GUI.MenuCallAdminReport)
		AnaisAdmin.GUI.MenuCallAdminReport.Cancel:SetSize((ScrW()/5)/2,(ScrH()/6)/5)
		AnaisAdmin.GUI.MenuCallAdminReport.Cancel:SetPos((ScrW()/5)/2,(ScrH()/6)-(ScrH()/6)/5)
		AnaisAdmin.GUI.MenuCallAdminReport.Cancel:SetText("Cancel")
		AnaisAdmin.GUI.MenuCallAdminReport.Cancel:SetTextColor(Color(255,255,255))

		AnaisAdmin.GUI.MenuCallAdminReport.Cancel.DoClick = function()
			AnaisAdmin.GUI.MenuCallAdminReport:Remove()
		end

		AnaisAdmin.GUI.MenuCallAdminReport.Cancel.Paint = function(s,w,h)
			if AnaisAdmin.GUI.MenuCallAdminReport.Cancel:IsHovered() then	
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			end
			draw.RoundedBox(0,0,0,w,2,AnaisAdminMenu.Config.MainColor)
			draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
		end
end
net.Receive( "SvAnaisAdmin_Panel_Open", function() -- Create panel
	AnaisAdmin.GUI.Create()
end )
net.Receive("SvAnaisAdmin_SendReport",function() -- Send report
	local victim = net.ReadEntity()
	local criminal = net.ReadEntity()
	local raison = net.ReadString()

	if !(IsValid(AnaisAdmin.GUI.Frame)) then return false end

	if criminal:IsBot() then 
		AnaisAdmin.GUI.CreateReport(victim,criminal,raison,criminal:Nick()) 
	else
		if criminal == victim then
			AnaisAdmin.GUI.CreateCall(victim,raison,criminal:SteamID64())
		else
			AnaisAdmin.GUI.CreateReport(victim,criminal,raison,criminal:SteamID64())
		end
	end
end)
net.Receive("SvAnaisAdmin_DeleteReport",function() -- Delete report
	local id = net.ReadString()
	if IsValid(AnaisAdmin.GUI[id]) then 
		AnaisAdmin.GUI[id]:Remove()
	end
end)
hook.Add( "OnContextMenuOpen", "Anais_Admin_Open_Context_Menu", function()
	AnaisAdmin.GUI.Create()
	if IsValid(AnaisAdmin.GUI.AdminPlayerInfo) then
		AnaisAdmin.GUI.AdminPlayerInfo:SetVisible(true)
	end
	if IsValid(AnaisAdmin.GUI.Frame) then
		AnaisAdmin.GUI.Frame:SetVisible(true)
		AnaisAdmin.GUI.Frame:MoveToFront()
	end
end )
hook.Add( "OnContextMenuClose", "Anais_Admin_Open_Context_Menu", function()
	if IsValid(AnaisAdmin.GUI.Frame) then
		AnaisAdmin.GUI.Frame:SetVisible(false)
	end
	if IsValid(AnaisAdmin.GUI.AdminPlayerInfo) then
		AnaisAdmin.GUI.AdminPlayerInfo:SetVisible(false)
	end
end )