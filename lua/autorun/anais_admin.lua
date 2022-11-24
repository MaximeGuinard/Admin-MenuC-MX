AnaisAdminMenu = {}

AnaisAdminMenu.Config = {
	
	UserGroupAdminMenu = {"superadmin","admin","Modérateur","Modérateur-Test"},

	UserGroupAdminMenuAlert = {"superadmin"},

	MainColor = Color(90, 94, 107, 100),

	consolecmd = "brp_ticket",

	chatcmd = "!ticket",

	webhookurl = "https://discordapp.com/api/webhooks/537589499509866496/srfrdB-4iGx6UzuCjzI66BQ3MPUF9H9UQbITWP31oNrDpvbuovMMCnQECOzpzopq6qlo",

	tblutil = {
		{name = "Logs",cmd = function() RunConsoleCommand("say","!logs") end,sort = 0},
		{name = "Mode Admin",cmd = function() RunConsoleCommand("say","!admin") end,sort = 1},
		{name = "Warning",cmd = function() RunConsoleCommand("say","!warn") end,sort = 2},
		{name = "Alert",cmd = function() AnaisAdmin.GUI.CreateAlertMenu() end,sort = 3},
		{name = "Sanction",cmd = function() AnaisAdmin.GUI.CreateSanctionMenu(LocalPlayer()) end,sort = 4},
		-- {name = "exemple",cmd = function() RunConsoleCommand("say","!exemple") end,sort = 5},
	},

	tblinfo = {
		{name = "Goto",cmd = function() if AnaisAdmin.GUI.PlySelectInfo:IsPlayer() then RunConsoleCommand("ulx","goto",AnaisAdmin.GUI.PlySelectInfo:Nick() ) else chat.AddText( Color( 100, 255, 100 ), "sélectionner un joueur") end end,sort = 1},
		{name = "Bring",cmd = function() if AnaisAdmin.GUI.PlySelectInfo:IsPlayer() then RunConsoleCommand("ulx","bring",AnaisAdmin.GUI.PlySelectInfo:Nick() ) else chat.AddText( Color( 100, 255, 100 ), "sélectionner un joueur") end end,sort = 2},
		{name = "Spectate",cmd = function() if AnaisAdmin.GUI.PlySelectInfo:IsPlayer() then RunConsoleCommand("ulx","spectate",AnaisAdmin.GUI.PlySelectInfo:Nick() ) else chat.AddText( Color( 100, 255, 100 ), "sélectionner un joueur") end end,sort = 3},
		{name = "Return",cmd = function() if AnaisAdmin.GUI.PlySelectInfo:IsPlayer() then RunConsoleCommand("ulx","return",AnaisAdmin.GUI.PlySelectInfo:Nick() ) else chat.AddText( Color( 100, 255, 100 ), "sélectionner un joueur") end end,sort = 4},
		{name = "Sanction",cmd = function() if AnaisAdmin.GUI.PlySelectInfo:IsPlayer() then AnaisAdmin.GUI.CreateSanctionMenu(AnaisAdmin.GUI.PlySelectInfo) else chat.AddText( Color( 100, 255, 100 ), "sélectionner un joueur") end end,sort = 5},
	},

}

--[[-------------------------------------------------------------------------
 						Add right click option
---------------------------------------------------------------------------]]

properties.Add( 'report', {
	MenuLabel = 'Report',
	Order = 1,
	MenuIcon = 'icon16/cancel.png',
	Filter = function( self, ent, ply )
		if !(ent:IsValid()) then return false end
		if !(ent:IsPlayer()) then return false end
		return true
	end,
	Action = function( self, ent )
		AnaisAdminMenu.ReportFrame = vgui.Create("DFrame")
		AnaisAdminMenu.ReportFrame:SetSize(ScrW()/5,ScrH()/6)
		AnaisAdminMenu.ReportFrame:Center()
		AnaisAdminMenu.ReportFrame:SetTitle("Report")
		AnaisAdminMenu.ReportFrame:ShowCloseButton(false)
		AnaisAdminMenu.ReportFrame:MakePopup()

		AnaisAdminMenu.ReportFrame.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			draw.RoundedBox(0,0,0,w,25,Color(30,30,35))
			draw.RoundedBox(0,0,25,w,2,AnaisAdminMenu.Config.MainColor)
		end

		AnaisAdminMenu.ReportFrame.msg = vgui.Create("DTextEntry", AnaisAdminMenu.ReportFrame)
		AnaisAdminMenu.ReportFrame.msg:SetSize(ScrW()/5,(ScrH()/6)/5)
		AnaisAdminMenu.ReportFrame.msg:SetPos(0,25+(ScrH()/6)/5)
		AnaisAdminMenu.ReportFrame.msg.Paint = function(s,w,h)
			if AnaisAdminMenu.ReportFrame.msg:IsHovered() then	
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			end
			if AnaisAdminMenu.ReportFrame.msg:GetValue() == "" then
				draw.SimpleText("Motif du report . . .","Anais:Roboto:15",w/2,h/2,Color(100,100,100,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(AnaisAdminMenu.ReportFrame.msg:GetValue(),"Anais:Roboto:15",w/2,h/2,Color(255,255,255,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		end

		AnaisAdminMenu.ReportFrame.Report = vgui.Create("DButton",AnaisAdminMenu.ReportFrame)
		AnaisAdminMenu.ReportFrame.Report:SetSize((ScrW()/5)/2,(ScrH()/6)/5)
		AnaisAdminMenu.ReportFrame.Report:SetPos(0,(ScrH()/6)-(ScrH()/6)/5)
		AnaisAdminMenu.ReportFrame.Report:SetText("Report")
		AnaisAdminMenu.ReportFrame.Report:SetTextColor(Color(255,255,255))

		AnaisAdminMenu.ReportFrame.Report.Paint = function(s,w,h)
			if AnaisAdminMenu.ReportFrame.Report:IsHovered() then	
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			end
			draw.RoundedBox(0,0,0,w,2,AnaisAdminMenu.Config.MainColor)
			draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
		end

		AnaisAdminMenu.ReportFrame.Report.DoClick = function()
			net.Start("SvAnaisAdmin_report")
				net.WriteEntity(LocalPlayer())
				net.WriteEntity(ent)
				net.WriteString(AnaisAdminMenu.ReportFrame.msg:GetValue())
			net.SendToServer()
surface.PlaySound("garrysmod/balloon_pop_cute.wav")
			AnaisAdminMenu.ReportFrame:Remove()
		end

		AnaisAdminMenu.ReportFrame.Cancel = vgui.Create("DButton",AnaisAdminMenu.ReportFrame)
		AnaisAdminMenu.ReportFrame.Cancel:SetSize((ScrW()/5)/2,(ScrH()/6)/5)
		AnaisAdminMenu.ReportFrame.Cancel:SetPos((ScrW()/5)/2,(ScrH()/6)-(ScrH()/6)/5)
		AnaisAdminMenu.ReportFrame.Cancel:SetText("Cancel")
		AnaisAdminMenu.ReportFrame.Cancel:SetTextColor(Color(255,255,255))

		AnaisAdminMenu.ReportFrame.Cancel.DoClick = function()
			AnaisAdminMenu.ReportFrame:Remove()
		end

		AnaisAdminMenu.ReportFrame.Cancel.Paint = function(s,w,h)
			if AnaisAdminMenu.ReportFrame.Cancel:IsHovered() then	
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			end
			draw.RoundedBox(0,0,0,w,2,AnaisAdminMenu.Config.MainColor)
			draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
		end
	end,
} )

properties.Add( 'Health', {
	MenuLabel = 'Health',
	Order = 2,
	MenuIcon = 'icon16/heart.png',
	Filter = function( self, ent, ply )
		if !(ent:IsValid()) then return false end
		if !(ent:IsPlayer()) then return false end
		if !(ply:IsAdmin()) then return false end
		return true
	end,
	Action = function( self, ent )
		local name = ent:Nick()
		RunConsoleCommand("ulx","hp",name,"100")
	end,
} )

properties.Add( 'Armor', {
	MenuLabel = 'Armor',
	Order = 3,
	MenuIcon = 'icon16/shield.png',
	Filter = function( self, ent, ply )
		if !(ent:IsValid()) then return false end
		if !(ent:IsPlayer()) then return false end
		if !(ply:IsAdmin()) then return false end
		return true
	end,
	Action = function( self, ent )
		local name = ent:Nick()
		RunConsoleCommand("ulx","armor",name,"100")
	end,
} )

properties.Add( 'Freeze', {
	MenuLabel = 'Freeze',
	Order = 4,
	MenuIcon = 'icon16/lightning_delete.png',
	Filter = function( self, ent, ply )
		if !(ent:IsValid()) then return false end
		if !(ent:IsPlayer()) then return false end
		if !(ply:IsAdmin()) then return false end
		return true
	end,
	Action = function( self, ent )
		local name = ent:Nick()
		if ent:IsFrozen() then
			RunConsoleCommand("ulx","unfreeze",name)
		else
			RunConsoleCommand("ulx","freeze",name)
		end
	end,
} )

properties.Add( 'Return', {
	MenuLabel = 'Return',
	Order = 5,
	MenuIcon = 'icon16/arrow_undo.png',
	Filter = function( self, ent, ply )
		if !(ent:IsValid()) then return false end
		if !(ent:IsPlayer()) then return false end
		if !(ply:IsAdmin()) then return false end
		return true
	end,
	Action = function( self, ent )
		local name = ent:Nick()
		RunConsoleCommand("ulx","return",name)
	end,
} )

properties.Add( 'Info', {
	MenuLabel = 'Info',
	Order = 6,
	MenuIcon = 'icon16/folder_explore.png',
	Filter = function( self, ent, ply )
		if !(ent:IsValid()) then return false end
		if !(ent:IsPlayer()) then return false end
		if !(ply:IsAdmin()) then return false end
		return true
	end,
	Action = function( self, ent )
		local name = ent:Nick()
		AnaisAdmin.GUI.CreateAdminPlayerInfo(ent)
	end,
} )

properties.Add( 'Sanction', {
	MenuLabel = 'Sanction',
	Order = 7,
	MenuIcon = 'icon16/monitor_error.png',
	Filter = function( self, ent, ply )
		if !(ent:IsValid()) then return false end
		if !(ent:IsPlayer()) then return false end
		if !(ply:IsAdmin()) then return false end
		return true
	end,
	Action = function( self, ent )
		AnaisAdmin.GUI.CreateSanctionMenu(ent)
	end,
} )