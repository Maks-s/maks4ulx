local positionTP = {}
local map = game.GetMap()

if !file.Exists("posjailtp.txt","DATA") or util.JSONToTable(file.Read("posjailtp.txt","DATA"))[map] == nil then
	-- If file doesn't exist or if map hasn't any pos 
	positionTP[map][1] = Vector(0,0,0)
else
	positionTP = util.JSONToTable(file.Read("posjailtp.txt","DATA"))
end

function ulx.prison( calling_ply, target_ply, numberPrison )
	if positionTP[map][1] == Vector(0,0,0) then
		ulx.fancyLogAdmin( calling_ply, true, "You must set a jail with !setprison <id who must be a number>")
		return
	end
	if IsValid(target_ply) and target_ply:Alive() then
		target_ply.ulx_prevpos = target_ply:GetPos() -- For !return command
		target_ply.ulx_prevang = target_ply:EyeAngles()
		if numberPrison == nil then -- Automaticaly set to 1 if lazy admin
			numberPrison = 1
		end
		target_ply:SetPos(positionTP[map][numberPrison]) -- Teleport then jail player
		RunConsoleCommand("ulx","jail",target_ply:Nick()) -- 'Cause lazy
	end
end
local prison = ulx.command( "Maks", "ulx prison", ulx.prison, "!prison", true)
prison:addParam{ type=ULib.cmds.PlayerArg }
prison:addParam{ type=ULib.cmds.NumArg, hint="Prison ID", ULib.cmds.optional, ULib.cmds.round, min=1, default=1 }
prison:defaultAccess( ULib.ACCESS_ADMIN )
prison:help( "Jail player at position defined by !setprison" )

function ulx.setprison( calling_ply, numberPrison )
	if IsValid(calling_ply) and calling_ply:IsPlayer() then
		if numberPrison == nil then -- Automaticaly set to 1 if lazy admin
			numberPrison = 1
		end
		positionTP[map][numberPrison] = calling_ply:GetPos() + Vector(0,0,32) -- teleporting in the ground isn't funny
		file.Write("posjailtp.txt",util.TableToJSON(positionTP,true))
	end
	ulx.fancyLogAdmin( calling_ply, false, "#A define position for prison #s", numberPrison)
end
local setprison = ulx.command( "Maks", "ulx setprison", ulx.setprison, "!setprison", true)
setprison:addParam{ type=ULib.cmds.NumArg, hint="Prison ID", ULib.cmds.round, min=1, default=1, ULib.cmds.optional }
setprison:defaultAccess( ULib.ACCESS_ADMIN )
setprison:help( "Define position for !prison command" )