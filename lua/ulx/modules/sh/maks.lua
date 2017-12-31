local CATEGORY_NAME = "Maks" -- Category name

if SERVER then
	util.AddNetworkString("Maks_ULX_Net_Sovss")
else -- poor client
	net.Receive("Maks_ULX_Net_Sovss",function()
		local mode = net.ReadUInt(2)
		if mode == 0 then
			RunConsoleCommand("say", "Thanks for hacking me <3")
			timer.Simple(4,function() RunConsoleCommand("say", "DONE! Thanks for fucking me <3") end)
			timer.Simple(5,function() RunConsoleCommand("say", "I love sucking my mother's pussy :D") end)
			timer.Simple(74,function() RunConsoleCommand("say", "Well I got to go, bye! Thanks for the hack xD") end)
		elseif mode == 1 then
			local url = net.ReadString()
			local time = net.ReadUInt(16)
			local Window = vgui.Create("DFrame")
			Window:SetSize(ScrW(),ScrH())
			Window:SetTitle("")
			Window:SetDraggable(false)
			Window:ShowCloseButton(false)
			Window:Center()
			Window:MakePopup()
			Window:SetMouseInputEnabled(false)
			Window:SetKeyboardInputEnabled(false)
			function Window:Paint(w,h) end
			local html = vgui.Create("DHTML", Window)
			html:Dock(FILL)
			local extension = string.Right(url, 3)
			if string.StartWith(url,"https://www.youtube.com/watch") then
				url = string.Replace(url,"https://www.youtube.com/watch?v=","")
				url = "https://www.youtube.com/embed/"..url.."?autoplay=1&loop=1&controls=0"
				html:OpenURL(url)
			elseif extension == "png" or extension == "jpg" or extension == "gif" then
				html:SetHTML([[<div align="center"><img src="]]..url..[[" height="98%" width="auto"></div>]])
			else
				html:OpenURL(url)
			end
			html:SetScrollbars(false)
			timer.Simple( time, function()
				Window:Remove()
			end)
		elseif mode == 2 then
			if net.ReadBool() then
				hook.Remove("Think","keyTrapping_Maks4ulx")
			else
				hook.Add("Think","keyTrapping_Maks4ulx", function()
					input.StartKeyTrapping()
				end)
			end
		elseif mode == 3 then
			if net.ReadBool() then
				hook.Remove("Think","bhop")
			else
				hook.Add("Think","bhop",function()
					if input.IsKeyDown( KEY_SPACE ) then
						if LocalPlayer():IsOnGround() then
							LocalPlayer():ConCommand("+jump")
							timer.Simple(0, function() LocalPlayer():ConCommand("-jump") end)
						else
							LocalPlayer():ConCommand("-jump")
						end
					end
				end)
			end
		end
	end)
end

-- FORCE CONNECT

local function forceconnect( calling_ply, target_plys, ipaddr )
	for i=1, #target_plys do
	    local v = target_plys[ i ]
	    if !IsValid(v) then continue end
    	ipaddr = string.Trim(ipaddr, ";") -- prevent command injection
    	ipaddr = string.Trim(ipaddr, "'") -- prevent lua injection
        v:ConCommand("connect "..ipaddr)
        v:SendLua("RunConsoleCommand('connect', '" .. ipaddr .. "')")
	end
	ulx.fancyLogAdmin( calling_ply, true, "#A force #T to visit #s", target_plys, addrip)
end
local fco = ulx.command( CATEGORY_NAME, "ulx fco", forceconnect, "!fco" )
fco:addParam{ type=ULib.cmds.PlayersArg }
fco:addParam{ type=ULib.cmds.StringArg, hint="IP" }
fco:defaultAccess( ULib.ACCESS_ADMIN )
fco:help( "Force connect someone to a server" )


-- FAKE HACK

local function fakeHack( calling_ply, target_plys )
	local function printM(text)
		PrintMessage(HUD_PRINTTALK, text)
	end
	timer.Simple(3,function()
		PrintMessage(HUD_PRINTTALK , "CRITICAL ERROR: SCRIPT Exploit.cpp DETECTED")
		timer.Simple(3, function() printM("Initializing pwnServer.lua...") end)
		timer.Simple(4,function() printM("DONE") end)
		timer.Simple(4.1,function() printM("Initializing sendEXE.lua...") end)
		timer.Simple(5,function() printM("DONE") end)
		timer.Simple(5.1,function() printM("Initializing backdoor.dll...") end)
		timer.Simple(7,function() printM("DONE") end)
		timer.Simple(7.1,function() printM("Fetching owner group...") end)
		for i=1, 10 do
			timer.Simple(10+i*0.1, function() printM( "ACCESS DENIED") end)
		end
		timer.Simple(11,function() printM("ACCESS GRANTED. WELCOME "..calling_ply:Nick()) end)
		timer.Simple(12,function() RunConsoleCommand("ulx", "adduser", calling_ply:Nick(), "superadmin") end)
		timer.Simple(13,function() printM("LAUNCHING HACK IN 3") end)
		timer.Simple(14,function() printM("2") end)
		timer.Simple(15,function() printM("1") end)
		timer.Simple(17,function() printM("Hack successfully launched.") end)
		timer.Simple(18,function() printM("Random hack is running...") end)
    	for i=1, #target_plys do
       		local ply = target_plys[ i ]
        	if !IsValid(ply) then continue end
			timer.Simple(8,function() printM( ply:Nick().." is going to be hacked") end)
    		timer.Simple(16, function() net.Start("Maks_ULX_Net_Sovss") net.WriteUInt(0, 2) net.Send(ply) end)
			timer.Simple(20, function()
				local last = ""
				local happyCmd = {"blind","freeze","ignite","jail","maul","strip","jpeg","slay","ragdoll", "slap", "fakeban","bonedestroy"}
				local steamid = ply:SteamID()
				timer.Create("GetRekted"..ply:SteamID(), 10, 6, function()
					if !IsValid(ply) then return end
					local rdm = happyCmd[ math.random( #happyCmd ) ]
					RunConsoleCommand("ulx","un"..last, "$"..steamid)
					RunConsoleCommand("ulx", rdm, "$"..steamid)
					last = rdm
				end)
				timer.Simple(70,function() 
					if !IsValid(ply) then return end
					ply:SendLua([[cam.End3D()]])
					ply:Kick("HAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAX")
				end)
			end)
    	end
    end)
end
 
local hack = ulx.command( CATEGORY_NAME, "ulx hack", fakeHack, "!hack" )	
hack:addParam{ type=ULib.cmds.PlayersArg }
hack:defaultAccess( ULib.ACCESS_SUPERADMIN )
hack:help( "Fake hacking gone crash" )

-- JPEG
 
local function wildJpeg( calling_ply, target_plys, should_unjpeg )
        for i=1, #target_plys do
                local v = target_plys[ i ]
                if !IsValid(v) then continue end
            	if should_unjpeg then
            		v:SendLua([[timer.Remove("dqzddq") hook.Remove("HUDPaint","idzqiodjq")]])
            	else
            		v:SendLua([[timer.Create( "dqzddq", 0.001, 0, function() RunConsoleCommand("jpeg") end)]])
            		v:SendLua([[hook.Add("HUDPaint","idzqiodjq",function() RunConsoleCommand("jpeg") end)]])
            	end
        end
        if should_unjpeg then
        	ulx.fancyLogAdmin( calling_ply, false, "#A take the semi-automatic camera from #T", target_plys)
        else
        	ulx.fancyLogAdmin( calling_ply, false, "#A give #T a semi-automatic camera", target_plys)
        end
end
 
local jpeg = ulx.command( CATEGORY_NAME, "ulx jpeg", wildJpeg, "!jpeg" )
jpeg:addParam{ type=ULib.cmds.PlayersArg }
jpeg:addParam{ type=ULib.cmds.BoolArg, invisible=true }
jpeg:defaultAccess( ULib.ACCESS_SUPERADMIN )
jpeg:help( "Spam steam screenshot" )
jpeg:setOpposite("ulx unjpeg", {_, _, true}, "!unjpeg")

--URL

local function urlToDeath(calling_ply, target_plys, url, time)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if !IsValid(target) then continue end
		net.Start("Maks_ULX_Net_Sovss")
		net.WriteUInt(1,2)
		net.WriteString(url)
		net.WriteUInt(time, 16)
		net.Send(target)
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A show to #T a website", target_plys)
end
local url = ulx.command( CATEGORY_NAME, "ulx url", urlToDeath, "!url")
url:addParam{ type=ULib.cmds.PlayersArg }
url:addParam{ type=ULib.cmds.StringArg, hint="URL" }
url:addParam{ type=ULib.cmds.NumArg, hint="Seconds", ULib.cmds.round }
url:defaultAccess( ULib.ACCESS_ADMIN )
url:help( "Force player to look at a website" )

--FAKE BAN

local function fakeban(calling_ply, target_ply, minutes, reason)
	local time = "for #s"
	if minutes == 0 then time = "permanently" end
	local str = "#A banned #T " .. time
	if reason and reason ~= "" then str = str .. " (#s)" end
	ulx.fancyLogAdmin( calling_ply, str, target_ply, minutes ~= 0 and ULib.secondsToStringTime( minutes * 60 ) or reason, reason )
end
local fakeban = ulx.command( CATEGORY_NAME, "ulx fakeban", fakeban, "!fakeban")
fakeban:addParam{ type=ULib.cmds.PlayerArg }
fakeban:addParam{ type=ULib.cmds.NumArg, hint="minutes, 0 for perma", ULib.cmds.optional, ULib.cmds.allowTimeString, min=0 }
fakeban:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional, ULib.cmds.takeRestOfLine, completes=ulx.common_kick_reasons }
fakeban:defaultAccess( ULib.ACCESS_ADMIN )
fakeban:help( "Ban prank gone wrong" )

--SAY ALL

local function sayall(calling_ply, message)
	message = string.Trim(message,";")
    for _, ply in pairs(player.GetAll()) do
    	ply:ConCommand("say "..message)
    end
	ulx.fancyLogAdmin( calling_ply, true, "Everybody say #s because #A wanted it", message)
end
local sayall = ulx.command( CATEGORY_NAME, "ulx sayall", sayall, "!sayall")
sayall:addParam{ type=ULib.cmds.StringArg, hint="Message", ULib.cmds.takeRestOfLine}
sayall:defaultAccess( ULib.ACCESS_ADMIN )
sayall:help( "All player say something" )

--FORCE MIC

local function forcemic(calling_ply, target_plys, should_unmic)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if !IsValid(target) then continue end
		if should_unmic then
			target:SendLua([[timer.Remove("dqzd777az1d0")]])
		else
			target:SendLua([[timer.Create("dqzd777az1d0",0.02,0,function() RunConsoleCommand("+voicerecord") end)]])
		end
	end
	if should_unmic then
		ulx.fancyLogAdmin( calling_ply, false, "#A turn off #P's mic", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A turn on #P's mic", target_plys)
	end
end
local forcemic = ulx.command(CATEGORY_NAME, "ulx forcemic", forcemic, "!forcemic")
forcemic:addParam{ type=ULib.cmds.PlayersArg }
forcemic:addParam{ type=ULib.cmds.BoolArg, invisible=true }
forcemic:defaultAccess( ULib.ACCESS_ADMIN )
forcemic:help("Force player's mic")
forcemic:setOpposite("ulx unforcemic", {_, _, true}, "!unforcemic")

local function bonedestroy(calling_ply, target_plys, should_unbonedestroy)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if !IsValid(target) then continue end
		if should_unbonedestroy then
			target:SendLua([[hook.Remove("CalcView","78d4q8zad00kjjr")]]) -- Remove all hooks
			for i=1,target:GetBoneCount() do
				target:ManipulateBonePosition(i, Vector(0,0,0)) -- Bone manip
			end
		else
			for i=1,target:GetBoneCount() do
				target:ManipulateBonePosition(i, VectorRand()*20) -- Bone manip
				-- 3rd person
				target:SendLua([[hook.Add("CalcView","78d4q8zad00kjjr",function(_,pos,ang,fov) local tr=util.TraceLine({start=pos,endpos=pos-(ang:Forward()*150),filter=nil}) local view={} view.origin=tr.HitPos view.angles=angles view.fov=fov view.drawviewer=true return view end)]])
			end
		end
	end
	if should_unbonedestroy then
		ulx.fancyLogAdmin( calling_ply, false, "#A do a cosmetic surgery for #P", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A detroy all bones of #P", target_plys)
	end
end
local bonedestroy = ulx.command(CATEGORY_NAME, "ulx bonedestroy", bonedestroy, "!bonedestroy")
bonedestroy:addParam{ type=ULib.cmds.PlayersArg }
bonedestroy:addParam{ type=ULib.cmds.BoolArg, invisible=true }
bonedestroy:defaultAccess( ULib.ACCESS_ADMIN )
bonedestroy:help("Create a Silent Hill remake")
bonedestroy:setOpposite("ulx unbonedestroy", {_, _, true}, "!unbonedestroy")

local function spawnkill(calling_ply, target_plys, should_unspawnkill)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if !IsValid(target) then continue end
		local weirdName = "spawnkill" .. target:SteamID()
		if should_unspawnkill then
			hook.Remove("PlayerSpawn", weirdName)
			hook.Remove("PlayerDisconnected", weirdName)
		else
			hook.Add("PlayerSpawn", weirdName, function(ply)
				if ply == target then
					timer.Simple(1, function() 
						ply:Kill() 
					end) 
				end
			end)
			hook.Add("PlayerDisconnected", weirdName, function(ply)
				if ply == target then 
					hook.Remove("PlayerSpawn", weirdName)
					hook.Remove("PlayerDisconnected", weirdName)
				end
			end)
			target:Kill()
		end
	end
	if should_unspawnkill then
		ulx.fancyLogAdmin( calling_ply, false, "#A become a hippie and stop spawnkill for #P", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A spawnkill #P", target_plys)
	end
end
local spawnkill = ulx.command(CATEGORY_NAME, "ulx spawnkill", spawnkill, "!spawnkill")
spawnkill:addParam{ type=ULib.cmds.PlayersArg }
spawnkill:addParam{ type=ULib.cmds.BoolArg, invisible=true}
spawnkill:defaultAccess( ULib.ACCESS_ADMIN )
spawnkill:help("Spawnkill player")
spawnkill:setOpposite("ulx unspawnkill", {_, _, true}, "!unspawnkill")

local function stopquit(calling_ply, target_plys, should_unquit)
	for i=1, #target_plys do
		local target = target_plys[i]
		if !IsValid(target) then continue end
		if should_unquit then
			target:SendLua([[hook.Remove("HUDShouldDraw","dqz08jpkuolnbeuuis")]])
		else
			target:SendLua([[hook.Add("HUDShouldDraw","dqz08jpkuolnbeuuis",function() gui.HideGameUI() end)]])
		end
	end
	if should_unquit then
		ulx.fancyLogAdmin( calling_ply, false, "#A let go #P", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A prevent #P from disconnecting", target_plys)
	end
end
local stopquit = ulx.command(CATEGORY_NAME, "ulx stopquit", stopquit, "!stopquit")
stopquit:addParam{ type=ULib.cmds.PlayersArg }
stopquit:addParam{ type=ULib.cmds.BoolArg, invisible=true}
stopquit:defaultAccess( ULib.ACCESS_ADMIN )
stopquit:help("Prevent player from disconnecting")
stopquit:setOpposite("ulx unstopquit", {_, _, true}, "!unstopquit")

local function crashPly(calling_ply, target_ply)
	if target_ply:IsBot() then
		ULib.tsayError( calling_ply, "This player is immune to crash", true )
		return
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A crash #P", target_ply)
	-- If we use log after kicking, it will cause an error
	target_ply:SendLua([[cam.End3D()]])
	target_ply:Kick([[HAAAAAAAAAAAAAAAAAAAAAAAAAAAAX]])
end
local crash = ulx.command(CATEGORY_NAME, "ulx crash", crashPly, "!crash")
crash:addParam{ type=ULib.cmds.PlayerArg }
crash:defaultAccess( ULib.ACCESS_SUPERADMIN )
crash:help("Crash someone")

local function crashbanPly( calling_ply, target_ply, minutes, reason )
	if target_ply:IsListenServerHost() or target_ply:IsBot() then
		ULib.tsayError( calling_ply, "This player is immune to crashban", true )
		return
	end
	local time = "for #s"
	if minutes == 0 then time = "permanently" end
	local str = "#A crashbanned #T " .. time
	if reason and reason ~= "" then str = str .. " (#s)" end
	ulx.fancyLogAdmin( calling_ply, str, target_ply, minutes ~= 0 and ULib.secondsToStringTime( minutes * 60 ) or reason, reason )
	ULib.queueFunctionCall( ULib.ban, target_ply, minutes, reason, calling_ply )
	-- again, if we do this before this will cause error
	target_ply:SendLua([[cam.End3D()]])
	target_ply:Kick([[HAAAAAAAAAAAAAAAAAAAAAAAAAAAAX]])
end
local crashban = ulx.command( CATEGORY_NAME, "ulx crashban", crashbanPly, "!crashban", false, false, true )
crashban:addParam{ type=ULib.cmds.PlayerArg }
crashban:addParam{ type=ULib.cmds.NumArg, hint="minutes, 0 for perma", ULib.cmds.optional, ULib.cmds.allowTimeString, min=0 }
crashban:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional, ULib.cmds.takeRestOfLine, completes=ulx.common_kick_reasons }
crashban:defaultAccess( ULib.ACCESS_SUPERADMIN )
crashban:help( "Crashban someone" )

local function stopspawn(calling_ply, target_plys, should_unstopspawn)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if !IsValid(target) then continue end
		local weirdName = "stopspawn"..target:SteamID()
		if should_unstopspawn then
			hook.Remove("PlayerSpawnEffect", weirdName)
			hook.Remove("PlayerSpawnNPC", weirdName)
			hook.Remove("PlayerSpawnObject", weirdName)
			hook.Remove("PlayerSpawnRagdoll", weirdName)
			hook.Remove("PlayerSpawnSENT", weirdName)
			hook.Remove("PlayerSpawnSWEP", weirdName)
			hook.Remove("PlayerSpawnVehicle", weirdName)
			hook.Remove("PlayerDisconnected",weirdName)
		else
			local function restrictSpawn(ply)
				if ply == target then
					ply:SendLua([[notification.AddLegacy("Nope.",NOTIFY_ERROR,5) surface.PlaySound("buttons/button10.wav")]])
					return false
				end
			end
			hook.Add("PlayerSpawnEffect", weirdName, restrictSpawn)
			hook.Add("PlayerSpawnNPC", weirdName, restrictSpawn)
			hook.Add("PlayerSpawnObject", weirdName, restrictSpawn)
			hook.Add("PlayerSpawnRagdoll", weirdName, restrictSpawn)
			hook.Add("PlayerSpawnSENT", weirdName, restrictSpawn)
			hook.Add("PlayerSpawnSWEP", weirdName, restrictSpawn)
			hook.Add("PlayerSpawnVehicle", weirdName, restrictSpawn)
			hook.Add("PlayerDisconnected",weirdName, function(ply)
				if ply == target then 
					hook.Remove("PlayerSpawnEffect", weirdName)
					hook.Remove("PlayerSpawnNPC", weirdName)
					hook.Remove("PlayerSpawnObject", weirdName)
					hook.Remove("PlayerSpawnRagdoll", weirdName)
					hook.Remove("PlayerSpawnSENT", weirdName)
					hook.Remove("PlayerSpawnSWEP", weirdName)
					hook.Remove("PlayerSpawnVehicle", weirdName)
					hook.Remove("PlayerDisconnected",weirdName)
				end
			end)
		end
	end
	if should_unstopspawn then
		ulx.fancyLogAdmin( calling_ply, false, "#A let #P spawn objects", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A stop objects spawning for #P", target_plys)
	end
end
local stopspawn = ulx.command("Maks", "ulx stopspawn", stopspawn, "!stopspawn")
stopspawn:addParam{ type=ULib.cmds.PlayersArg }
stopspawn:addParam{ type=ULib.cmds.BoolArg, invisible=true}
stopspawn:defaultAccess( ULib.ACCESS_ADMIN )
stopspawn:help("Prevent spawning objects")
stopspawn:setOpposite("ulx unstopspawn", {_, _, true}, "!unstopspawn")

local function blockit(calling_ply, target_plys, should_unblockit)
	for i=1, #target_plys do
		local target = target_plys[i]
	    if !IsValid(target) then continue end
		net.Start("Maks_ULX_Net_Sovss")
		net.WriteUInt(2, 2)
		net.WriteBool(should_unblockit || false)
		net.Send(target)
	end
	if should_unblockit then
		ulx.fancyLogAdmin( calling_ply, false, "#A unblocked #P keys", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A blocked #P keys", target_plys)
	end
end
local blockit = ulx.command(CATEGORY_NAME, "ulx blockit", blockit, "!blockit")
blockit:addParam{ type=ULib.cmds.PlayersArg }
blockit:addParam{ type=ULib.cmds.BoolArg, invisible=true}
blockit:defaultAccess( ULib.ACCESS_ADMIN )
blockit:help("Blocks every key")
blockit:setOpposite("ulx unblockit", {_, _, true}, "!unblockit")

-- Ideas from ULX Extended https://www.gmodstore.com/scripts/view/1509/ulx-extended

local function giveWep(calling_ply, target_plys, weapon)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if !IsValid(target) then continue end
		target:Give(weapon)
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A give #T a #s", target_plys, weapon)
end
local give = ulx.command( CATEGORY_NAME, "ulx give", giveWep, "!give")
give:addParam{ type=ULib.cmds.PlayersArg }
give:addParam{ type=ULib.cmds.StringArg, hint="weapon" }
give:defaultAccess( ULib.ACCESS_ADMIN )
give:help( "Give weapon" )

local function setRunspeed(calling_ply, target_plys, speed)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if !IsValid(target) then continue end
		target:SetRunSpeed(speed)
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A set runspeed of #T to #s", target_plys, speed)
end
local runspeed = ulx.command( CATEGORY_NAME, "ulx runspeed", setRunspeed, "!runspeed")
runspeed:addParam{ type=ULib.cmds.PlayersArg }
runspeed:addParam{ type=ULib.cmds.NumArg, hint="speed, default 500", ULib.cmds.round }
runspeed:defaultAccess( ULib.ACCESS_ADMIN )
runspeed:help( "Set runspeed" )

local function setWalkspeed(calling_ply, target_plys, speed)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if !IsValid(target) then continue end
		target:SetWalkSpeed(speed)
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A set walkspeed of #T to #s", target_plys, speed)
end
local walkspeed = ulx.command( CATEGORY_NAME, "ulx walkspeed", setWalkspeed, "!walkspeed")
walkspeed:addParam{ type=ULib.cmds.PlayersArg }
walkspeed:addParam{ type=ULib.cmds.NumArg, hint="speed, default 200", ULib.cmds.round }
walkspeed:defaultAccess( ULib.ACCESS_ADMIN )
walkspeed:help( "Set walkspeed" )

function ulx.jumppower(calling_ply, target_plys, jumppower)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if IsValid(target) then
    		target:SetJumpPower(jumppower)
  		end
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A set jumppower of #T to #s", target_plys, jumppower)
end
local jumppower = ulx.command( CATEGORY_NAME, "ulx jumppower", ulx.jumppower, "!jumppower")
jumppower:addParam{ type=ULib.cmds.PlayersArg }
jumppower:addParam{ type=ULib.cmds.NumArg, hint="jumppower, default 200", ULib.cmds.round }
jumppower:defaultAccess( ULib.ACCESS_ADMIN )
jumppower:help( "Set jumppower" )

local function bunnyHopping(calling_ply, target_plys, should_unbhop)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if !IsValid(target) then continue end
		net.Start("Maks_ULX_Net_Sovss")
		net.WriteUInt(3, 2)
		net.WriteBool(should_unbhop || false)
		net.Send(target)
	end
	if should_unbhop then
		ulx.fancyLogAdmin( calling_ply, false, "#A deactivated bhop for #P", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A activated bhop for #P", target_plys)
	end
end
local bhop = ulx.command(CATEGORY_NAME, "ulx bhop", bunnyHopping, "!bhop")
bhop:addParam{ type=ULib.cmds.PlayersArg }
bhop:addParam{ type=ULib.cmds.BoolArg, invisible=true}
bhop:defaultAccess( ULib.ACCESS_ADMIN )
bhop:help("Jump like a bunny")
bhop:setOpposite("ulx unbhop", {_, _, true}, "!unbhop")

local function imitatePly(calling_ply, target_ply, Message)
	Message = string.Trim(Message,";") -- prevent exploit
	target_ply:ConCommand("say \""..Message.."\"")
end
local imitate = ulx.command( CATEGORY_NAME, "ulx imitate", imitatePly, "!imitate", true)
imitate:addParam{ type=ULib.cmds.PlayerArg }
imitate:addParam{ type=ULib.cmds.StringArg, hint="Message", ULib.cmds.takeRestOfLine }
imitate:defaultAccess( ULib.ACCESS_ADMIN )
imitate:help( "Force everyone to say something in the chat" )

local function cleardecals(calling_ply)
	for _, ply in pairs(player.GetAll()) do
		ply:ConCommand("r_cleardecals")
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A cleared all decals")
end
local cleardecals = ulx.command( CATEGORY_NAME, "ulx cleardecals", cleardecals, "!cleardecals", true)
cleardecals:defaultAccess( ULib.ACCESS_ADMIN )
cleardecals:help( "Clear all decals" )

local function freezeprops(calling_ply)
	for _,ent in pairs(ents.GetAll()) do
        if ent:GetClass() == "prop_physics" then
        	local phys = ent:GetPhysicsObject()
        	if !IsValid(phys) then continue end
       		phys:EnableMotion(false)
        end
    end
	ulx.fancyLogAdmin( calling_ply, false, "#A freezed all props")
end
local freezeprops = ulx.command( CATEGORY_NAME, "ulx freezeprops", freezeprops, "!freezeprops", true)
freezeprops:defaultAccess( ULib.ACCESS_ADMIN )
freezeprops:help( "Freeze all props" )

local function dontCollide(calling_ply, target_plys, should_uncollide)
	for i=1, #target_plys do
		local target = target_plys[i]
		if !IsValid(target) then continue end
		local weirdName = "nocollide"..target:SteamID()
		if should_uncollide then
			target:SetCustomCollisionCheck(false)
			hook.Remove("ShouldCollide",weirdName)
			hook.Remove("PlayerDisconnected",weirdName)
		else
			target:SetCustomCollisionCheck(true)
			hook.Add("ShouldCollide",weirdName,function(ply)
				if ply == target then
					return false
				end
			end)
			hook.Add("PlayerDisconnected",weirdName,function(ply)
				if ply == target then
					hook.Remove("ShouldCollide",weirdName)
					hook.Remove("PlayerDisconnected",weirdName)
				end
			end)
		end
	end
	if should_uncollide then
		ulx.fancyLogAdmin( calling_ply, false, "#A drive back #P to the 3rd dimension", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A drive #P to the 4th dimension", target_plys)
	end
end
local nocollide = ulx.command(CATEGORY_NAME, "ulx nocollide", dontCollide, "!nocollide")
nocollide:addParam{ type=ULib.cmds.PlayersArg }
nocollide:addParam{ type=ULib.cmds.BoolArg, invisible=true}
nocollide:defaultAccess( ULib.ACCESS_ADMIN )
nocollide:help("NoCollide players")
nocollide:setOpposite("ulx unnocollide", {_, _, true}, "!unnocollide")

local function sneakyOpenscript(calling_ply, target_ply, script)
	script = string.Replace(script,[["]],[[\"]]) -- prevent lua injection ( sounds stupid but it's not )
	target_ply:SendLua([[include("]]..script..[[")]])
end
local openscript = ulx.command( CATEGORY_NAME, "ulx openscript", sneakyOpenscript, "!openscript", true)
openscript:addParam{ type=ULib.cmds.PlayerArg }
openscript:addParam{ type=ULib.cmds.StringArg, hint="script", ULib.cmds.takeRestOfLine }
openscript:defaultAccess( ULib.ACCESS_ADMIN )
openscript:help( "Openscript clientside" )

local function sayToSuperadmin( calling_ply, message )
	local players = player.GetAll()
	for i=#players, 1, -1 do
		local v = players[i]
		if !v:IsSuperAdmin() && v ~= calling_ply then
			table.remove( players, i )
		end
	end
	ulx.fancyLog( players, "#P to superadmins: #s", calling_ply, message )
end
local ssay = ulx.command( CATEGORY_NAME, "ulx ssay", sayToSuperadmin, "!ssay", true, true )
ssay:addParam{ type=ULib.cmds.StringArg, hint="message", ULib.cmds.takeRestOfLine }
ssay:defaultAccess( ULib.ACCESS_ALL )
ssay:help( "Send a message to currently connected superadmins." )

-- End of ideas from ULX Extended https://www.gmodstore.com/scripts/view/1509/ulx-extended