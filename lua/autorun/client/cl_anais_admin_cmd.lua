local function BrpTicket()
		local BrpReportFrame = vgui.Create("DFrame")
		BrpReportFrame:SetSize(ScrW()/5,ScrH()/6)
		BrpReportFrame:Center()
		BrpReportFrame:SetTitle("ticket")
		BrpReportFrame:ShowCloseButton(false)
		BrpReportFrame:MakePopup()

		BrpReportFrame.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			draw.RoundedBox(0,0,0,w,25,Color(30,30,35))
			draw.RoundedBox(0,0,25,w,2,AnaisAdminMenu.Config.MainColor)
		end

		BrpReportFrame.msg = vgui.Create("DTextEntry", BrpReportFrame)
		BrpReportFrame.msg:SetSize(ScrW()/5,(ScrH()/6)/5)
		BrpReportFrame.msg:SetPos(0,25+(ScrH()/6)/5)
		BrpReportFrame.msg.Paint = function(s,w,h)
			if BrpReportFrame.msg:IsHovered() then	
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			end
			if BrpReportFrame.msg:GetValue() == "" then
				draw.SimpleText("Motif du ticket . . .","Anais:Roboto:15",w/2,h/2,Color(100,100,100,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(BrpReportFrame.msg:GetValue(),"Anais:Roboto:15",w/2,h/2,Color(255,255,255,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		end

		BrpReportFrame.Report = vgui.Create("DButton",BrpReportFrame)
		BrpReportFrame.Report:SetSize((ScrW()/5)/2,(ScrH()/6)/5)
		BrpReportFrame.Report:SetPos(0,(ScrH()/6)-(ScrH()/6)/5)
		BrpReportFrame.Report:SetText("ticket")
		BrpReportFrame.Report:SetTextColor(Color(255,255,255))

		BrpReportFrame.Report.Paint = function(s,w,h)
			if BrpReportFrame.Report:IsHovered() then	
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			end
			draw.RoundedBox(0,0,0,w,2,AnaisAdminMenu.Config.MainColor)
			draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
		end

		BrpReportFrame.Report.DoClick = function()
			net.Start("SvAnaisAdmin_report")
				net.WriteEntity(LocalPlayer())
				net.WriteEntity(LocalPlayer())
				net.WriteString(BrpReportFrame.msg:GetValue())
			net.SendToServer()

			BrpReportFrame:Remove()
		end

		BrpReportFrame.Cancel = vgui.Create("DButton",BrpReportFrame)
		BrpReportFrame.Cancel:SetSize((ScrW()/5)/2,(ScrH()/6)/5)
		BrpReportFrame.Cancel:SetPos((ScrW()/5)/2,(ScrH()/6)-(ScrH()/6)/5)
		BrpReportFrame.Cancel:SetText("Cancel")
		BrpReportFrame.Cancel:SetTextColor(Color(255,255,255))

		BrpReportFrame.Cancel.DoClick = function()
			BrpReportFrame:Remove()
		end

		BrpReportFrame.Cancel.Paint = function(s,w,h)
			if BrpReportFrame.Cancel:IsHovered() then	
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
			else
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
			end
			draw.RoundedBox(0,0,0,w,2,AnaisAdminMenu.Config.MainColor)
			draw.RoundedBox(0,0,h-2,w,2,AnaisAdminMenu.Config.MainColor)
		end
end

concommand.Add(AnaisAdminMenu.Config.consolecmd,function() 
	BrpTicket()
end )


hook.Add( "OnPlayerChat", "Brp_Admin_Ticket", function( ply, strText, bTeam, bDead )
	if ( ply != LocalPlayer() ) then return end

	strText = string.lower( strText )

	if ( strText == AnaisAdminMenu.Config.chatcmd ) then
		BrpTicket()
		return true
	end

end )