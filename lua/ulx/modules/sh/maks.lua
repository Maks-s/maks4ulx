local CATEGORY_NAME = "Maks" -- Category name

if SERVER then
util.AddNetworkString("maks_haaaaax")
util.AddNetworkString("maks_urlforlife")
end

-- LE FORCE CONNECT

function ulx.fco( calling_ply, target_plys, addrip )
	for i=1, #target_plys do
	    local v = target_plys[ i ]
	    if IsValid(v) then
	        v:ConCommand("connect "..addrip)
	        v:SendLua([[LocalPlayer():ConCommand("connect ]]..addrip..[[")]])
	    end
	end
	ulx.fancyLogAdmin( calling_ply, true, "#A force #T to visit "..addrip, target_plys)
end
local fco = ulx.command( CATEGORY_NAME, "ulx fco", ulx.fco, "!fco" )
fco:addParam{ type=ULib.cmds.PlayersArg }
fco:addParam{ type=ULib.cmds.StringArg, hint="IP" }
fco:defaultAccess( ULib.ACCESS_ADMIN )
fco:help( "Force connect someone to a server" )


-- LE FAKE HACK


if CLIENT then
	net.Receive("maks_haaaaax",function()
		if net.ReadInt(32) ~= 0 then return end
		LocalPlayer():ConCommand("say Thanks for hacking me <3")
		timer.Simple(4,function() LocalPlayer():ConCommand("say DONE! Thanks for fucking me <3") end)
		timer.Simple(5,function() LocalPlayer():ConCommand("say I love sucking my mother's pussy :D") end)
		timer.Simple(74,function() LocalPlayer():ConCommand("say Well I got to go, bye! Thanks for the hack xD") end)
	end)
end

function ulx.hack( calling_ply, target_plys )
	timer.Simple(3,function()
		timer.Simple(2,function() PrintMessage(HUD_PRINTTALK , "CRITICAL ERROR: SCRIPT Exploit.cpp DETECTED")end)
		local temp = 0
		while temp <= 1 do
			timer.Simple(10+temp, function() PrintMessage(HUD_PRINTTALK,"ACCESS DENIED") end)
			temp = temp+0.2
		end
		timer.Simple(3,function() PrintMessage(HUD_PRINTTALK,"Initializing pwnServer.lua...") end)
		timer.Simple(4,function() PrintMessage(HUD_PRINTTALK,"DONE") end)
		timer.Simple(4.1,function() PrintMessage(HUD_PRINTTALK,"Initializing sendEXE.lua...") end)
		timer.Simple(5,function() PrintMessage(HUD_PRINTTALK,"DONE") end)
		timer.Simple(5.1,function() PrintMessage(HUD_PRINTTALK,"Initializing backdoor.exe...") end)
		timer.Simple(7,function() PrintMessage(HUD_PRINTTALK,"DONE") end)
		timer.Simple(7.1,function() PrintMessage(HUD_PRINTTALK,"Fetching owner group...") end)
		timer.Simple(11,function() PrintMessage(HUD_PRINTTALK,"ACCESS GRANTED. WELCOME "..calling_ply:Name()) end)
		timer.Simple(12,function() RunConsoleCommand("ulx", "adduser \"", calling_ply:Name(), "\" superadmin") end)
		timer.Simple(13,function() PrintMessage(HUD_PRINTTALK,"LAUNCHING HACK IN 3") end)
		timer.Simple(14,function() PrintMessage(HUD_PRINTTALK,"2") end)
		timer.Simple(15,function() PrintMessage(HUD_PRINTTALK,"1") end)
		timer.Simple(17,function() PrintMessage(HUD_PRINTTALK, [[Hack successfully launched.]]) end)
		timer.Simple(18,function() PrintMessage(HUD_PRINTTALK, calling_ply:Name().." .") end)
		timer.Simple(19,function() PrintMessage(HUD_PRINTTALK,"Random hack is running...") end)
    	for i=1, #target_plys do
       		local ply = target_plys[ i ]
        	if IsValid(ply) then
        		timer.Simple(16, function() net.Start("maks_haaaaax") net.WriteInt(0, 32) net.Send(ply) ply:SendLua([[RunConsoleCommand("+voicerecord")]]) end)
				timer.Simple(8,function() PrintMessage(HUD_PRINTTALK, ply:Name().. " is going to be hacked...") end)
				timer.Simple(20, function()
					local last = ""
					local liste = {"blind","freeze","ignite","jail","maul","strip","jpeg","slay","ragdoll", "slap", "fakeban","bonedestroy"}
					timer.Create("hack",10,6,function()
						if ply:IsPlayer() and ply:IsValid() then
							rdm = liste[ math.random( #liste ) ]
							if last == "maul" then
								RunConsoleCommand("ulx","slay", ply:Name())
							else
								RunConsoleCommand("ulx","un"..last, ply:Name())
							end
							RunConsoleCommand("ulx", rdm, ply:Name())
							last = rdm
						end
					end)
					timer.Simple(70,function() 
						ply:SendLua([[cam.End3D()]])
						ply:Kick("HAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAX")
					end)
				end)
        	end
    	end
    end)
end
 
local hack = ulx.command( CATEGORY_NAME, "ulx hack", ulx.hack, "!hack" )	
hack:addParam{ type=ULib.cmds.PlayersArg }
hack:defaultAccess( ULib.ACCESS_ADMIN )
hack:help( "Fake hacking gone crash" )

-- LE JPEG
 
function ulx.jpeg( calling_ply, target_plys, should_unjpeg )
        for i=1, #target_plys do
                local v = target_plys[ i ]
                if IsValid(v) then
                	if not should_unjpeg then
                		v:SendLua([[timer.Create( "dqzddq", 0.001, 0, function() RunConsoleCommand("jpeg") end)]])
                		v:SendLua([[hook.Add("Think","idzqiodjq",function() RunConsoleCommand("jpeg") end)]])
                	else
                		v:SendLua([[timer.Remove("dqzddq") hook.Remove("Think","idzqiodjq")]])
                	end
                end
        end
        if not should_unjpeg then
        	ulx.fancyLogAdmin( calling_ply, false, "#A give #T a semi-automatic camera", target_plys)
        else
        	ulx.fancyLogAdmin( calling_ply, false, "#A take the semi-automatic camera from #T", target_plys)
        end
end
 
local jpeg = ulx.command( CATEGORY_NAME, "ulx jpeg", ulx.jpeg, "!jpeg" )
jpeg:addParam{ type=ULib.cmds.PlayersArg }
jpeg:addParam{ type=ULib.cmds.BoolArg, invisible=true }
jpeg:defaultAccess( ULib.ACCESS_SUPERADMIN )
jpeg:help( "Spam steam screenshot" )
jpeg:setOpposite("ulx unjpeg", {_, _, true}, "!unjpeg")

--URL

if CLIENT then
net.Receive("maks_urlforlife",function() -- url, time
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
end)
end

function ulx.url(calling_ply, target_plys, url, time)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if IsValid(target) then
    		net.Start("maks_urlforlife")
    		net.WriteString(url)
    		net.WriteUInt(time, 16)
    		net.Send(target)
  		end
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A show to #T a website", target_plys)
end
local url = ulx.command( CATEGORY_NAME, "ulx url", ulx.url, "!url")
url:addParam{ type=ULib.cmds.PlayersArg }
url:addParam{ type=ULib.cmds.StringArg, hint="URL" }
url:addParam{ type=ULib.cmds.NumArg, hint="Seconds", ULib.cmds.round }
url:defaultAccess( ULib.ACCESS_ADMIN )
url:help( "Force player to look at a website" )

--FAKE BAN

function ulx.fakeban(calling_ply, target_ply, minutes, reason)
	local time = "for #s"
	if minutes == 0 then time = "permanently" end
	local str = "#A banned #T " .. time
	if reason and reason ~= "" then str = str .. " (#s)" end
	ulx.fancyLogAdmin( calling_ply, str, target_ply, minutes ~= 0 and ULib.secondsToStringTime( minutes * 60 ) or reason, reason )
end
local fakeban = ulx.command( CATEGORY_NAME, "ulx fakeban", ulx.fakeban, "!fakeban")
fakeban:addParam{ type=ULib.cmds.PlayerArg }
fakeban:addParam{ type=ULib.cmds.NumArg, hint="minutes, 0 for perma", ULib.cmds.optional, ULib.cmds.allowTimeString, min=0 }
fakeban:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional, ULib.cmds.takeRestOfLine, completes=ulx.common_kick_reasons }
fakeban:defaultAccess( ULib.ACCESS_ADMIN )
fakeban:help( "Ban prank gone wrong" )

--SAY ALL

function ulx.sayall(calling_ply, message)
    for _, ply in pairs(player.GetAll()) do
    	ply:ConCommand("say "..message)
    end
	ulx.fancyLogAdmin( calling_ply, true, "Everybody say #s because #A wanted it", message)
end
local sayall = ulx.command( CATEGORY_NAME, "ulx sayall", ulx.sayall, "!sayall")
sayall:addParam{ type=ULib.cmds.StringArg, hint="Message", ULib.cmds.takeRestOfLine}
sayall:defaultAccess( ULib.ACCESS_ADMIN )
sayall:help( "All player say something" )

--FORCE MIC

function ulx.forcemic(calling_ply, target_plys, should_unmic)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if IsValid(target) then
    		if not should_unmic then
    			target:SendLua([[timer.Create("mictoggler",0.2,0,function() RunConsoleCommand("+voicerecord") end)]])
    		else
    			target:SendLua([[timer.Destroy("mictoggler")]])
    		end
  		end
	end
	if not should_unmic then
		ulx.fancyLogAdmin( calling_ply, false, "#A turn on #P's mic", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A turn off #P's mic", target_plys)
	end
end
local forcemic = ulx.command(CATEGORY_NAME, "ulx forcemic", ulx.forcemic, "!forcemic")
forcemic:addParam{ type=ULib.cmds.PlayersArg }
forcemic:addParam{ type=ULib.cmds.BoolArg, invisible=true }
forcemic:defaultAccess( ULib.ACCESS_ADMIN )
forcemic:help("Force player's mic")
forcemic:setOpposite("ulx unforcemic", {_, _, true}, "!unforcemic")

function ulx.bonedestroy(calling_ply, target_plys, should_unbonedestroy)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if IsValid(target) then
    		if not should_unbonedestroy then
				for i=1,target:GetBoneCount() do
					target:ManipulateBonePosition(i, VectorRand()*20) -- Bone manip
					-- 3rd person
					target:SendLua([[hook.Add("CalcView","maksthdp",function(_,pos,ang,fov) local tr=util.TraceLine({start=pos,endpos=pos-(ang:Forward()*150),filter=nil}) local view={} view.origin=tr.HitPos view.angles=angles view.fov=fov view.drawviewer=true return view end)]])
				end
    		else
    			target:SendLua([[hook.Remove("CalcView","maksthdp")]]) -- Remove all hooks
    			for i=1,target:GetBoneCount() do
					target:ManipulateBonePosition(i, Vector(0,0,0)) -- Bone manip
				end
    		end
  		end
	end
	if not should_unbonedestroy then
		ulx.fancyLogAdmin( calling_ply, false, "#A DESTROY ALL BONES OF #P", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A do a cosmetic surgery for #P", target_plys)
	end
end
local bonedestroy = ulx.command(CATEGORY_NAME, "ulx bonedestroy", ulx.bonedestroy, "!bonedestroy")
bonedestroy:addParam{ type=ULib.cmds.PlayersArg }
bonedestroy:addParam{ type=ULib.cmds.BoolArg, invisible=true }
bonedestroy:defaultAccess( ULib.ACCESS_ADMIN )
bonedestroy:help("Create a Silent Hill remake")
bonedestroy:setOpposite("ulx unbonedestroy", {_, _, true}, "!unbonedestroy")

function ulx.spawnkill(calling_ply, target_plys, should_unspawnkill)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if IsValid(target) then
    		if not should_unspawnkill then
    			target:Kill()
				hook.Add("PlayerSpawn","spawnkill"..target:SteamID(),function(ply)
					if ply == target then
						timer.Simple(1, function() 
							ply:Kill() 
						end) 
					end
				end)
				hook.Add("PlayerDisconnected","spawnkill"..target:SteamID(),function(ply)
					if ply == target then 
						hook.Remove("PlayerSpawn","spawnkill"..ply:SteamID())
						hook.Remove("PlayerDisconnected","spawnkill"..ply:SteamID())
					end
				end)
    		else
    			hook.Remove("PlayerSpawn","spawnkill"..target:SteamID())
				hook.Remove("PlayerDisconnected","spawnkill"..target:SteamID())
    		end
  		end
	end
	if not should_unspawnkill then
		ulx.fancyLogAdmin( calling_ply, false, "#A spawnkill #P", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A become an hippie and stop spawnkill of #P", target_plys)
	end
end
local spawnkill = ulx.command(CATEGORY_NAME, "ulx spawnkill", ulx.spawnkill, "!spawnkill")
spawnkill:addParam{ type=ULib.cmds.PlayersArg }
spawnkill:addParam{ type=ULib.cmds.BoolArg, invisible=true}
spawnkill:defaultAccess( ULib.ACCESS_ADMIN )
spawnkill:help("Spawnkill player")
spawnkill:setOpposite("ulx unspawnkill", {_, _, true}, "!unspawnkill")

function ulx.stopquit(calling_ply, target_plys, should_unquit)
	for i=1, #target_plys do
		local target = target_plys[i]
		if IsValid(target) then
			if not should_unquit then
				target:SendLua([[hook.Add("Think","qzdqzudzq",function() gui.HideGameUI() end)]])
			else
				target:SendLua([[hook.Remove("Think","qzdqzudzq")]])
			end
		end
	end
	if not should_unquit then
		ulx.fancyLogAdmin( calling_ply, false, "#A prevent #P from disconnecting", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A let go #P", target_plys)
	end
end
local stopquit = ulx.command(CATEGORY_NAME, "ulx stopquit", ulx.stopquit, "!stopquit")
stopquit:addParam{ type=ULib.cmds.PlayersArg }
stopquit:addParam{ type=ULib.cmds.BoolArg, invisible=true}
stopquit:defaultAccess( ULib.ACCESS_ADMIN )
stopquit:help("Prevent player from disconnecting")
stopquit:setOpposite("ulx unstopquit", {_, _, true}, "!unstopquit")

function ulx.crash(calling_ply, target_ply)
	if target_ply:IsBot() then
		ULib.tsayError( calling_ply, "This player is immune to crash", true )
		return
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A crash #P", target_ply)
	target_ply:SendLua([[cam.End3D()]])
	target_ply:Kick([[HAAAAAAAAAAAAAAAAAAAAAAAAAAAAX]])
end
local crash = ulx.command(CATEGORY_NAME, "ulx crash", ulx.crash, "!crash")
crash:addParam{ type=ULib.cmds.PlayerArg }
crash:defaultAccess( ULib.ACCESS_SUPERADMIN )
crash:help("Crash someone")

function ulx.crashban( calling_ply, target_ply, minutes, reason )
	if target_ply:IsListenServerHost() or target_ply:IsBot() then
		ULib.tsayError( calling_ply, "This player is immune to crashban", true )
		return
	end

	local time = "for #s"
	if minutes == 0 then time = "permanently" end
	local str = "#A crashbanned #T " .. time
	if reason and reason ~= "" then str = str .. " (#s)" end
	ulx.fancyLogAdmin( calling_ply, str, target_ply, minutes ~= 0 and ULib.secondsToStringTime( minutes * 60 ) or reason, reason )
	ULib.queueFunctionCall( ULib.kickban, target_ply, minutes, reason, calling_ply )
end
local crashban = ulx.command( CATEGORY_NAME, "ulx crashban", ulx.crashban, "!crashban", false, false, true )
crashban:addParam{ type=ULib.cmds.PlayerArg }
crashban:addParam{ type=ULib.cmds.NumArg, hint="minutes, 0 for perma", ULib.cmds.optional, ULib.cmds.allowTimeString, min=0 }
crashban:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional, ULib.cmds.takeRestOfLine, completes=ulx.common_kick_reasons }
crashban:defaultAccess( ULib.ACCESS_SUPERADMIN )
crashban:help( "Crashban someone" )

function ulx.stopspawn(calling_ply, target_plys, should_unstopspawn)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if IsValid(target) then
    		if not should_unstopspawn then
    			for i=1, 7 do
					local typeofthing = "Vehicle"
					if i == 1 then
						typeofthing = "Effect"
					elseif i == 2 then
						typeofthing = "NPC"
					elseif i == 3 then
						typeofthing = "Object"
					elseif i == 4 then
						typeofthing = "Ragdoll"
					elseif i == 5 then
						typeofthing = "SENT"
					elseif i == 6 then
						typeofthing = "SWEP"
					end
					hook.Add("PlayerSpawn"..typeofthing,"stopspawn"..target:SteamID(), function(ply)
						if ply == target then
							ply:SendLua([[notification.AddLegacy("Nope.",NOTIFY_ERROR,5) surface.PlaySound("buttons/button10.wav")]])
							return false
						end
					end)
				end
				hook.Add("PlayerDisconnected","stopspawn"..target:SteamID(),function(ply)
					if ply == target then 
						for i=1, 7 do
							local typeofthing = "Vehicle"
							if i == 1 then
								typeofthing = "Effect"
							elseif i == 2 then
								typeofthing = "NPC"
							elseif i == 3 then
								typeofthing = "Object"
							elseif i == 4 then
								typeofthing = "Ragdoll"
							elseif i == 5 then
								typeofthing = "SENT"
							elseif i == 6 then
								typeofthing = "SWEP"
							end
							hook.Remove("PlayerSpawn"..typeofthing,"stopspawn"..ply:SteamID())
						end
						hook.Remove("PlayerDisconnected","stopspawn"..ply:SteamID())
					end
				end)
    		else
    			for i=1, 7 do
					local typeofthing = "Vehicle"
					if i == 1 then
						typeofthing = "Effect"
					elseif i == 2 then
						typeofthing = "NPC"
					elseif i == 3 then
						typeofthing = "Object"
					elseif i == 4 then
						typeofthing = "Ragdoll"
					elseif i == 5 then
						typeofthing = "SENT"
					elseif i == 6 then
						typeofthing = "SWEP"
					end
					hook.Remove("PlayerSpawn"..typeofthing,"stopspawn"..target:SteamID())
				end
				hook.Remove("PlayerDisconnected","stopspawn"..target:SteamID())
    		end
  		end
	end
	if not should_unstopspawn then
		ulx.fancyLogAdmin( calling_ply, false, "#A stop objects spawning for #P", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A let #P spawn objects", target_plys)
	end
end
local stopspawn = ulx.command("Maks", "ulx stopspawn", ulx.stopspawn, "!stopspawn")
stopspawn:addParam{ type=ULib.cmds.PlayersArg }
stopspawn:addParam{ type=ULib.cmds.BoolArg, invisible=true}
stopspawn:defaultAccess( ULib.ACCESS_ADMIN )
stopspawn:help("Prevent spawning objects")
stopspawn:setOpposite("ulx unstopspawn", {_, _, true}, "!unstopspawn")

if CLIENT then
	net.Receive("maks_haaaaax", function()
		if net.ReadInt(32) ~= 3 then return end
		if net.ReadBool() then
			hook.Add("Think","YOU_CANT_DO_ANYTHING_MAKS", function()
				input.StartKeyTrapping()
			end)
		else
			hook.Remove("Think","YOU_CANT_DO_ANYTHING_MAKS")
		end
	end)
end

function ulx.blockit(calling_ply, target_ply, should_unblockit)
    if !IsValid(target_ply) then return end
    if not should_unblockit then
    	net.Start("maks_haaaaax")
    	net.WriteInt(3, 32)
    	net.WriteBool(true)
    	net.Send(target)
    else
    	net.Start("maks_haaaaax")
    	net.WriteInt(3, 32)
    	net.WriteBool(false)
    	net.Send(target)
    end
	if not should_unblockit then
		ulx.fancyLogAdmin( calling_ply, false, "#A blocked #P keys", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A unblocked #P keys", target_plys)
	end
end
local blockit = ulx.command(CATEGORY_NAME, "ulx blockit", ulx.blockit, "!blockit")
blockit:addParam{ type=ULib.cmds.PlayerArg }
blockit:addParam{ type=ULib.cmds.BoolArg, invisible=true}
blockit:defaultAccess( ULib.ACCESS_ADMIN )
blockit:help("blockit for everyone")
blockit:setOpposite("ulx unblockit", {_, _, true}, "!unblockit")

-- Ideas from ULX Extended https://www.gmodstore.com/scripts/view/1509/ulx-extended

function ulx.give(calling_ply, target_plys, weapon)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if IsValid(target) then
    		target:Give(weapon)
  		end
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A give #T a #s", target_plys, weapon)
end
local give = ulx.command( CATEGORY_NAME, "ulx give", ulx.give, "!give")
give:addParam{ type=ULib.cmds.PlayersArg }
give:addParam{ type=ULib.cmds.StringArg, hint="weapon" }
give:defaultAccess( ULib.ACCESS_ADMIN )
give:help( "Give weapon" )

function ulx.runspeed(calling_ply, target_plys, speed)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if IsValid(target) then
    		target:SetRunSpeed(speed)
  		end
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A set runspeed of #T to #s", target_plys, speed)
end
local runspeed = ulx.command( CATEGORY_NAME, "ulx runspeed", ulx.runspeed, "!runspeed")
runspeed:addParam{ type=ULib.cmds.PlayersArg }
runspeed:addParam{ type=ULib.cmds.NumArg, hint="speed, default 500", ULib.cmds.round }
runspeed:defaultAccess( ULib.ACCESS_ADMIN )
runspeed:help( "Set runspeed" )

function ulx.walkspeed(calling_ply, target_plys, speed)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if IsValid(target) then
    		target:SetWalkSpeed(speed)
  		end
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A set walkspeed of #T to #s", target_plys, speed)
end
local walkspeed = ulx.command( CATEGORY_NAME, "ulx walkspeed", ulx.walkspeed, "!walkspeed")
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

if CLIENT then
	net.Receive("maks_haaaaax",function()
		if net.ReadInt(32) ~= 2 then return end
		if net.ReadBool() then
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
		else
			hook.Remove("Think","bhop")
		end
	end)
end

function ulx.bhop(calling_ply, target_plys, should_unbhop)
	for i=1, #target_plys do
    	local target = target_plys[ i ]
    	if IsValid(target) then
    		if not should_unbhop then
    			net.Start("maks_haaaaax")
    			net.WriteInt(2, 32)
    			net.WriteBool(true)
    			net.Send(target)
    		else
    			net.Start("maks_haaaaax")
    			net.WriteInt(2, 32)
    			net.WriteBool(false)
    			net.Send(target)
    		end
  		end
	end
	if not should_unbhop then
		ulx.fancyLogAdmin( calling_ply, false, "#A activated bhop for #P", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A deactivated bhop for #P", target_plys)
	end
end
local bhop = ulx.command(CATEGORY_NAME, "ulx bhop", ulx.bhop, "!bhop")
bhop:addParam{ type=ULib.cmds.PlayersArg }
bhop:addParam{ type=ULib.cmds.BoolArg, invisible=true}
bhop:defaultAccess( ULib.ACCESS_ADMIN )
bhop:help("Bhop for everyone")
bhop:setOpposite("ulx unbhop", {_, _, true}, "!unbhop")

function ulx.imitate(calling_ply, target_ply, Message)
	Message = string.Replace(Message,";","") -- prevent exploit
	target_ply:ConCommand("say \""..Message.."\"")
end
local imitate = ulx.command( CATEGORY_NAME, "ulx imitate", ulx.imitate, "!imitate", true)
imitate:addParam{ type=ULib.cmds.PlayerArg }
imitate:addParam{ type=ULib.cmds.StringArg, hint="Message", ULib.cmds.takeRestOfLine }
imitate:defaultAccess( ULib.ACCESS_ADMIN )
imitate:help( "Force someone to say something in the chat" )

function ulx.cleardecals(calling_ply)
	for _, ply in pairs(player.GetAll()) do
		ply:ConCommand("r_cleardecals")
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A cleared all decals")
end
local cleardecals = ulx.command( CATEGORY_NAME, "ulx cleardecals", ulx.cleardecals, "!cleardecals", true)
cleardecals:defaultAccess( ULib.ACCESS_ADMIN )
cleardecals:help( "Clear all decals" )

function ulx.freezeprops(calling_ply)
	for _,ent in pairs(ents.GetAll()) do
        if ent:GetClass() == "prop_physics" then
        	local phys = ent:GetPhysicsObject()
        	if IsValid(phys) then
           		phys:EnableMotion(false)
       		end
        end
    end
	ulx.fancyLogAdmin( calling_ply, false, "#A freezed all props")
end
local freezeprops = ulx.command( CATEGORY_NAME, "ulx freezeprops", ulx.freezeprops, "!freezeprops", true)
freezeprops:defaultAccess( ULib.ACCESS_ADMIN )
freezeprops:help( "Freeze all props" )

function ulx.nocollide(calling_ply, target_plys, should_uncollide)
	for i=1, #target_plys do
		local target = target_plys[i]
		if IsValid(target) then
			local uniquename = "nocollide"..target:SteamID()
			if not should_uncollide then
				target:SetCustomCollisionCheck(true)
				hook.Add("ShouldCollide",uniquename,function(ply)
					if ply == target then
						return false
					end
				end)
				hook.Add("PlayerDisconnected",uniquename,function(ply)
					if ply == target then
						hook.Remove("ShouldCollide",uniquename)
						hook.Remove("PlayerDisconnected",uniquename)
					end
				end)
			else
				target:SetCustomCollisionCheck(false)
				hook.Remove("ShouldCollide",uniquename)
				hook.Remove("PlayerDisconnected",uniquename)
			end
		end
	end
	if not should_uncollide then
		ulx.fancyLogAdmin( calling_ply, false, "#A drive #P to the 4th dimension", target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A drive back #P to the 3rd dimension", target_plys)
	end
end
local nocollide = ulx.command(CATEGORY_NAME, "ulx nocollide", ulx.nocollide, "!nocollide")
nocollide:addParam{ type=ULib.cmds.PlayersArg }
nocollide:addParam{ type=ULib.cmds.BoolArg, invisible=true}
nocollide:defaultAccess( ULib.ACCESS_ADMIN )
nocollide:help("NoCollide players")
nocollide:setOpposite("ulx unnocollide", {_, _, true}, "!unnocollide")

function ulx.openscript(calling_ply, target_ply, script)
	script = string.Replace(script,[["]],[[\"]]) -- prevent exploit
	target_ply:SendLua([[include("]]..script..[[")]]) -- that was really hard xD
end
local openscript = ulx.command( CATEGORY_NAME, "ulx openscript", ulx.openscript, "!openscript", true)
openscript:addParam{ type=ULib.cmds.PlayerArg }
openscript:addParam{ type=ULib.cmds.StringArg, hint="script", ULib.cmds.takeRestOfLine }
openscript:defaultAccess( ULib.ACCESS_ADMIN )
openscript:help( "Openscript clientside" )

function ulx.ssay( calling_ply, message )
	local format
	local me = "/me "
	if message:sub( 1, me:len() ) == me then
		format = "(SUPERADMINS) *** #P #s"
		message = message:sub( me:len() + 1 )
	else
		format = "#P to superadmins: #s"
	end

	local players = player.GetAll()
	for i=#players, 1, -1 do
		local v = players[ i ]
		if not v:IsSuperAdmin() and v ~= calling_ply then
			table.remove( players, i )
		end
	end
	ulx.fancyLog( players, format, calling_ply, message )
end
local ssay = ulx.command( CATEGORY_NAME, "ulx ssay", ulx.ssay, "!ssay", true, true )
ssay:addParam{ type=ULib.cmds.StringArg, hint="message", ULib.cmds.takeRestOfLine }
ssay:defaultAccess( ULib.ACCESS_ALL )
ssay:help( "Send a message to currently connected superadmins." )

-- End of ideas from ULX Extended https://www.gmodstore.com/scripts/view/1509/ulx-extended