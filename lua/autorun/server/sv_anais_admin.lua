SvAnaisAdmin = {}

util.AddNetworkString("SvAnaisAdmin_report")
util.AddNetworkString("SvAnaisAdmin_SendReport")
util.AddNetworkString("SvAnaisAdmin_Panel_Open")
util.AddNetworkString("SvAnaisAdmin_ClaimReport")
util.AddNetworkString("SvAnaisAdmin_DeleteReport")
util.AddNetworkString("SvAnaisAdmin_CreateAlert")
util.AddNetworkString("SvAnaisAdmin_SendAlert")

function SvAnaisAdmin.PostMessage(webhookurl,msg) -- discordlogs.PostMessage(string,string)

	http.Post(webhookurl, {content = msg} ,function(good) print(good) end,function(failed) print(failed) end,{ ["Content-Type"] = "application/json"} )

end

function SvAnaisAdmin.PostMarkdown(msg) -- discordlogs.PostMarkdown(string)

	local txt = "```Markdown\n"..msg.."\n```"

	SvAnaisAdmin.PostMessage(AnaisAdminMenu.Config.webhookurl,txt)

end


function SvAnaisAdmin.SendReport(plyvictim,plycriminal,motif) -- Send report to admin
	if !(plyvictim:IsPlayer()) then return false end
	if !(plycriminal:IsPlayer()) then return false end
	if plyvictim == plycriminal then
		SvAnaisAdmin.PostMarkdown("#Ticket du "..os.date( "%d/%m/%Y à %Hh%M" , os.time() ).."\n".."Victime: "..plyvictim:Nick().." | "..plyvictim:SteamID().."\n".."Motif: "..motif)
	else
		SvAnaisAdmin.PostMarkdown("#Report du "..os.date( "%d/%m/%Y à %Hh%M" , os.time() ).."\n".."Victime: "..plyvictim:Nick().." | "..plyvictim:SteamID().."\n".."Criminel: "..plycriminal:Nick().." | "..plycriminal:SteamID().."\n".."Motif: "..motif)
	end
	for k, v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			net.Start("SvAnaisAdmin_SendReport")
				net.WriteEntity(plyvictim)
				net.WriteEntity(plycriminal)
				net.WriteString(motif)
			net.Send(v)
		end
	end
end

function SvAnaisAdmin.DeleteReport(id) -- Remove report id
	for k, v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			net.Start("SvAnaisAdmin_DeleteReport")
				net.WriteString(id)
			net.Send(v)
		end
	end
end

function SvAnaisAdmin.StartAlert(msg) -- Set Alert
	if msg != "" then
		SvAnaisAdmin.PostMarkdown("#Alerte du "..os.date( "%d/%m/%Y à %Hh%M" , os.time() ).."\nAlerte: "..msg)
	end
	for k, v in pairs(player.GetAll()) do
		net.Start("SvAnaisAdmin_SendAlert")
			net.WriteString(msg)
		net.Send(v)
	end
end

net.Receive("SvAnaisAdmin_CreateAlert",function(len, ply) -- Send Alert
	if table.HasValue(AnaisAdminMenu.Config.UserGroupAdminMenuAlert,ply:GetUserGroup()) then
		SvAnaisAdmin.StartAlert(net.ReadString())
	end
end)

net.Receive("SvAnaisAdmin_report",function(len, ply) -- Send report to admin
	SvAnaisAdmin.SendReport(net.ReadEntity(),net.ReadEntity(),net.ReadString())
end)

net.Receive("SvAnaisAdmin_ClaimReport",function(len, ply) -- Remove report on claim
	local id = net.ReadString()
	SvAnaisAdmin.DeleteReport(id)
end)

hook.Add("PlayerInitialSpawn", "SvAnaisAdmin_Init", function(ply) -- Init client
	if table.HasValue(AnaisAdminMenu.Config.UserGroupAdminMenu,ply:GetUserGroup()) then
		net.Start("SvAnaisAdmin_Panel_Open")
		net.Send(ply)  
	end
end)

hook.Add("AWarnPlayerIDWarned", "SvAnaisAdmin_WarnCallID", function(id,ply,reason)
	SvAnaisAdmin.PostMarkdown("#Warn du "..os.date( "%d/%m/%Y à %Hh%M" , os.time() ).."\nSteamID: "..id.."\nAdmin: "..ply:Name().."\nRaison: "..reason)
end)

hook.Add("AWarnPlayerWarned", "SvAnaisAdmin_WarnCall", function(target_ply,ply,reason)
	SvAnaisAdmin.PostMarkdown("#Warn du "..os.date( "%d/%m/%Y à %Hh%M" , os.time() ).."\nSteamID: "..target_ply:SteamID().."\nAdmin: "..ply:Name().."\nRaison: "..reason)
end)