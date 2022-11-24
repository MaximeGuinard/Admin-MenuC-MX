AnaisAdmin_Alert = nil

net.Receive("SvAnaisAdmin_SendAlert",function()
	AnaisAdmin_Alert = net.ReadString()
end)

hook.Add( "HUDPaint", "Anais_Admin_Alert", function()
	if AnaisAdmin_Alert != nil then
		if AnaisAdmin_Alert != "" then
		draw.RoundedBox(0,0,0,ScrW(),ScrH()/15,Color(0,0,0,150))
		draw.RoundedBox(0,0,ScrH()/15,ScrW(),2,AnaisAdminMenu.Config.MainColor)
		draw.SimpleText(AnaisAdmin_Alert ,"Anais:Roboto:30",ScrW()/2,(ScrH()/15)/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
	end
end )