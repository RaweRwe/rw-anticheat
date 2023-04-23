ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local ResourceMetadata = {}
local ResourceFiles = {}

---------------------------
-------- BAN BOOGERS ------
--------------------------- 
function banlistregenerator()
	local o = LoadResourceFile(GetCurrentResourceName(), "ac-bans.json")
	if not o or o == "" then
		SaveResourceFile(GetCurrentResourceName(), "ac-bans.json", "[]", -1)
		print("^"..math.random(1, 9).."^3Warning! ^0Your ^1ac-bans.json ^0is missing, Regenerating your ^1ac-bans.json ^0file!")
	else
		local p = json.decode(o)
		if not p then
			SaveResourceFile(GetCurrentResourceName(), "ac-bans.json", "[]", -1)
			p = {}
			print("^"..math.random(1, 9).."^3Warning! ^0Your ^1ac-bans.json ^0is corrupted, Regenerating your ^1ac-bans.json ^0file!")
		end
	end
end

function AntiCheatBans(source,reason)
    local config = LoadResourceFile(GetCurrentResourceName(), "ac-bans.json")
    local data = json.decode(config)
    local _src = source

    if config == nil then
        banlistregenerator()
        return
    end

    if GetPlayerName(_src) == nil then -- Make sure no any nil to come on our json.
		return
	end

    local myid = GetIdentifier(_src);

    local playerSteam = myid.steam;
    local playerLicense = myid.license;
    local playerXbl = myid.xbl;
    local playerLive = myid.live;
    local playerDiscord = myid.discord;
    local banInfo = {};

    --Identifiers.
    banInfo['ID'] = tonumber(GetAndBanID());
	banInfo['reason'] = reason;
    banInfo['license'] = "No Info";
    banInfo['steam'] = "No Info";
    banInfo['xbl'] = "No Info";
    banInfo['live'] = "No Info";
    banInfo['discord'] = "No Info";
    
    --Input to our json.
    if playerLicense ~= nil and playerLicense ~= "nil" and playerLicense ~= "" then 
        banInfo['license'] = tostring(playerLicense);
    end
    if playerSteam ~= nil and playerSteam ~= "nil" and playerSteam ~= "" then 
        banInfo['steam'] = tostring(playerSteam);
    end
    if playerXbl ~= nil and playerXbl ~= "nil" and playerXbl ~= "" then 
        banInfo['xbl'] = tostring(playerXbl);
    end
    if playerLive ~= nil and playerLive ~= "nil" and playerLive ~= "" then 
        banInfo['live'] = tostring(playerXbl);
    end
    if playerDiscord ~= nil and playerDiscord ~= "nil" and playerDiscord ~= "" then 
        banInfo['discord'] = tostring(playerDiscord);
    end
    data[tostring(GetPlayerName(source))] = banInfo;
    SaveResourceFile(GetCurrentResourceName(), "ac-bans.json", json.encode(data, { indent = true }), -1)
end

function GetIdentifier(source)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)

        --Full to table
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function GetAndBanID()
    local config = LoadResourceFile(GetCurrentResourceName(), "ac-bans.json")
    local data = json.decode(config)
    local banID = 0;
    for k, v in pairs(data) do 
        banID = banID + 1;
    end
    return (banID + 1);
end

function sendwebhooktodc(content)
    local _source = source
    local connect = 
    {
        {
            ["color"] = "23295",
            ["title"] = "Rawe AntiCheat",
            ["description"] = "Player: "..GetPlayerName(_source).. " "  ..GetPlayerIdentifiers(_source)[1].."", content,
            ["footer"] = {
            ["text"] = "github.com/RaweRwe/rw-anticheat",
            },
        }
    }
    PerformHttpRequest(Config.WebhookDiscord, function(err, text, headers) end, 'POST', json.encode({username = "RW-AC", embeds = connect}), { ['Content-Type'] = 'application/json' })
end

-- kickorbancheater(source,"Content Text", "Info Text",kick,ban) c = Kick d = Ban
-- Example use: kickorbancheater(_src,"Weapon Explosion Detected", "This Player tried to change bullet type",true,true) 

function kickorbancheater(source,content,info,c,d)
    local _source = source
    local sname = GetPlayerName(_source)
    --Identifiers
    local steam = "unknown"
	local discord = "unknown"
	local license = "unknown"
	local live = "unknown"
	local xbl = "unknown"

    if not IsPlayerAceAllowed(_source, "rwacbypass") then -- checking player perm.
	    for m, n in ipairs(GetPlayerIdentifiers(_source)) do
	    	if n:match("steam") then
	    		steam = n
	    	elseif n:match("discord") then
	    		discord = n:gsub("discord:", "")
	    	elseif n:match("license") then
	    		license = n
	    	elseif n:match("live") then
	    		live = n
	    	elseif n:match("xbl") then
	    		xbl = n
	    	end
	    end

        local discordinfo = {
            {
                ["color"] = "23295",
                ["title"] = "Rawe AntiCheat",
                ["description"] = "**Player: **"..sname.. "\n**ServerID:** ".._source.."\n**Violation:** "..content.."\n**Details:** "..info.."\n**Steam:** "..steam.."\n**License: **"..license.."\n**Xbl: **"..xbl.."\n**Live: **"..live.."\n**Discord**: <@"..discord..">",
                ["footer"] = {
                ["text"] = "github.com/RaweRwe/rw-anticheat " ..os.date("%c").. "",
                },
            }
        }
        PerformHttpRequest(Config.WebhookDiscord, function(err, text, headers) end, 'POST', json.encode({username = "RW-AC", embeds = discordinfo}), { ['Content-Type'] = 'application/json' })

        if d then
            AntiCheatBans(source,content)
        end

        if c then
            DropPlayer(source, "Kicked : "..Config.DropMsg)
        end
    end
end
 
function OnPlayerConnecting(name, setKickReason, deferrals)
    deferrals.defer();
    local src = source;
    local banned = false;
    local ban = getBanned(src);
    
    Citizen.Wait(100);
   
	if ban then
        -- They are banned 
        local reason = ban['reason'];
        print("[BANNED PLAYER] Player " .. GetPlayerName(src) .. " tried to join, but was banned for: " .. reason);
        deferrals.done("(BAN ID: " .. ban['banID'] .. ") " .. Config.ReasonBanned);
        banned = true;
        CancelEvent();
		return;
    end

    if not banned then 
        deferrals.done();
    end	
end

function getBanned(source)
    local config = LoadResourceFile(GetCurrentResourceName(), "ac-bans.json")
    local data = json.decode(config)

    if config == nil then
        banlistregenerator()
        return
    end
    
	local myid = GetIdentifier(source);
    local playerSteam = myid.steam;
    local playerLicense = myid.license;
    local playerXbl = myid.xbl;
    local playerLive = myid.live;
    local playerDisc = myid.discord;
    for k, bigData in pairs(data) do 
        local reason = bigData['reason']
        local id = bigData['ID']
        local license = bigData['license']
        local steam = bigData['steam']
        local xbl = bigData['xbl']
        local live = bigData['live']
        local discord = bigData['discord']
        if tostring(license) == tostring(playerLicense) then return { ['banID'] = id, ['reason'] = reason } end;
        if tostring(steam) == tostring(playerSteam) then return { ['banID'] = id, ['reason'] = reason } end;
        if tostring(xbl) == tostring(playerXbl) then return { ['banID'] = id, ['reason'] = reason } end;
        if tostring(live) == tostring(playerLive) then return { ['banID'] = id, ['reason'] = reason } end;
        if tostring(discord) == tostring(playerDisc) then return { ['banID'] = id, ['reason'] = reason } end;
    end
    return false;
end

AddEventHandler("playerConnecting", OnPlayerConnecting)

RegisterCommand('ac-unban', function(source, args, rawCommand)
    local src = source;
    if (src <= 0) then
        -- Console unban
        if #args == 0 then 
            -- Not enough arguments
            print('^3[^6RW-AntiCheat^3] ^1Not enough arguments...');
            return; 
        end
        local banID = args[1];
        if tonumber(banID) ~= nil then
            local playerName = UnbanPlayer(banID);
            if playerName then
                print('^3[^6RW-AntiCheat^3] ^0Player ^1' .. playerName 
                .. ' ^0has been unbanned from the server by ^2CONSOLE');
                TriggerClientEvent('chatMessage', -1, '^3[^6RW-AntiCheat^3] ^0Player ^1' .. playerName 
                .. ' ^0has been unbanned from the server by ^2CONSOLE'); 
            else 
                -- Not a valid ban ID
                print('^3[^6RW-AntiCheat^3] ^1That is not a valid ban ID. No one has been unbanned!'); 
            end
        end
        return;
    end 
    if IsPlayerAceAllowed(src, "rwacbypass") then 
        if #args == 0 then 
            -- Not enough arguments
            TriggerClientEvent('chatMessage', src, '^3[^6RW-AntiCheat^3] ^1Not enough arguments...');
            return; 
        end
        local banID = args[1];
        if tonumber(banID) ~= nil then 
            -- Is a valid ban ID 
            local playerName = UnbanPlayer(banID);
            if playerName then
                TriggerClientEvent('chatMessage', -1, '^3[^6RW-AntiCheat^3] ^0Player ^1' .. playerName 
                .. ' ^0has been unbanned from the server by ^2' .. GetPlayerName(src)); 
            else 
                -- Not a valid ban ID
                TriggerClientEvent('chatMessage', src, '^3[^6RW-AntiCheat^3] ^1That is not a valid ban ID. No one has been unbanned!'); 
            end
        else 
            -- Not a valid number
            TriggerClientEvent('chatMessage', src, '^3[^6RW-AntiCheat^3] ^1That is not a valid number...'); 
        end
    end
end)
function UnbanPlayer(banID)
    local config = LoadResourceFile(GetCurrentResourceName(), "ac-bans.json")
    local cfg = json.decode(config)
    for k, v in pairs(cfg) do 
        local id = tonumber(v['ID']);
        if id == tonumber(banID) then 
            local name = k;
            cfg[k] = nil;
            SaveResourceFile(GetCurrentResourceName(), "ac-bans.json", json.encode(cfg, { indent = true }), -1)
            return name;
        end
    end
    return false;
end

RegisterCommand("ac-ban", function(source, args, raw) -- /acban <id> <reason> 
    local src = source;
    if IsPlayerAceAllowed(src, "rwacbypass") then 
        if #args < 2 then 
            -- Not valid enough num of arguments 
            TriggerClientEvent('chatMessage', source, "^5[^1RW-AntiCheat^5] ^1ERROR: You have supplied invalid amount of arguments... " ..
                "^2Proper Usage: /acban <id> <reason>");
            return;
        end
        local id = args[1]
        if GetIdentifier(args[1]) ~= nil then 
            -- Valid player supplied 
            local playerSteam = myid.steam;
            local playerLicense = myid.license;
            local playerXbl = myid.xbl;
            local playerLive = myid.live;
            local playerDiscord = myid.discord;
            local reason = table.concat(args, ' '):gsub(args[1] .. " ", "");
            AntiCheatBans(args[1], reason);
        else 
            -- Not a valid player supplied 
            TriggerClientEvent('chatMessage', source, "^5[^1RW-AntiCheat^5] ^1ERROR: There is no valid player with that ID online... " ..
                "^2Proper Usage: /acban <id> <reason>");
        end
    end
end)
-----

RegisterServerEvent("8jWpZudyvjkDXQ2RVXf9")
AddEventHandler("8jWpZudyvjkDXQ2RVXf9", function(type)
    local _type = type or "default"
    local _src = source
    local _item = item or "none"
    local _name = GetPlayerName(_src)
    _type = string.lower(_type)

    if not IsPlayerAceAllowed(_src, "rwacbypass") then
        if (_type == "invisible") then
            kickorbancheater(_src,"Tried to be Invisible", "This Player tried to Invisible",true,true)
        elseif (_type == "antiragdoll") then
            kickorbancheater(_src,"AntiRagdoll Detected", "This Player tried to activate Anti-Ragdoll",true,true)
        elseif (_type == "displayradar") then
            kickorbancheater(_src,"Radar Detected", "This Player tried to activate Radar",true,true)
        elseif (_type == "explosiveweapon") then
            kickorbancheater(_src,"Weapon Explosion Detected", "This Player tried to change bullet type",true,true)
        elseif (_type == "spectatormode") then
            kickorbancheater(_src,"Spectate Detected", "This Player tried to Spectate a Player",true,true)
        elseif (_type == "speedhack") then
            kickorbancheater(_src,"SpeedHack Detected", "This Player tried to SpeedHack",true,true)
        elseif (_type == "blacklistedweapons") then
            kickorbancheater(_src,"Weapon in Blacklist", "This Player tried to spawn a Blacklisted Weapon",true,true)
        elseif (_type == "thermalvision") then
            kickorbancheater(_src,"Thermal Camera Detected", "This Player tried to use Thermal Camera",true,true)
        elseif (_type == "nightvision") then
            kickorbancheater(_src,"Night Vision Detected", "This Player tried to use Night Vision",true,true)
        elseif (_type == "antiresourcestop") then
            kickorbancheater(_src,"Resource Stopped", "This Player tried to stop/start a Resource",true,true)
        elseif (_type == "pedchanged") then
            kickorbancheater(_src,"Ped Changed", "This Player tried to change his PED",true,true)
        elseif (_type == "freecam") then
            kickorbancheater(_src,"FreeCam Detected", "This Player tried to use Freecam (Fallout or similar)",true,true)
        elseif (_type == "infiniteammo") then
            kickorbancheater(_src,"Infinite Ammo Detected", "This Player tried to put Infinite Ammo",true,true)
        elseif (_type == "resourcestarted") then
            kickorbancheater(_src,"AntiResourceStart", "This Player tried to start a resource",true,true)
        elseif (_type == "menyoo") then
            kickorbancheater(_src,"Anti Menyoo", "This Player tried to inject Menyoo Menu",true,true)
        elseif (_type == "givearmour") then
            kickorbancheater(_src,"Anti Give Armor", "This Player tried to Give Armor",true,true)
        elseif (_type == "aimassist") then
            kickorbancheater(_src,"Aim Assist", "This Player tried Aim Assist Detected. Mode: ",false,false)
        elseif (_type == "infinitestamina") then
            kickorbancheater(_src,"Anti Infinite Stamina", "This Player tried to use Infinite Stamina",true,true)
        elseif (_type == "superjump") then
            if IsPlayerUsingSuperJump(_src) then
                kickorbancheater(_src,"Superjump Detected", "This Player tried to use Superjump",true,true)
            end
        elseif (_type == "vehicleweapons") then
            kickorbancheater(_src,"Vehicle Weapons Detected", "This Player tried to use Vehicle Weapons",true,true)
        elseif (_type == "blacklistedtask") then
            kickorbancheater(_src,"Blacklisted Task", "Tried to execute a blacklisted task.",true,true)
        elseif (_type == "blacklistedanim") then
            kickorbancheater(_src,"Blacklisted Anim", "Tried executing a blacklisted anim. This player might not be a cheater.",true,true)
        elseif (_type == "receivedpickup") then
            kickorbancheater(_src,"Pickup received", "Pickup received.",true,true)
        elseif (_type == "shotplayerwithoutbeingonhisscreen") then
            kickorbancheater(_src,"Anti Aimbot/TriggerBot", "Hit a Player Without Being in his Screen. Possible Aimbot/TriggerBot/RageBot. Distance Difference.",false,false) -- can do wrong ban
        elseif (_type == "aimbot") then
            kickorbancheater(_src,"Anti Aimbot", "Aimbot detected.",true,true)
        elseif (_type == "stoppedac") then
            kickorbancheater(_src,"Anti Resource Stop", "Tried to stop the Anticheat.",true,true)
        elseif (_type == "stoppedresource") then
            kickorbancheater(_src,"Anti Resource Stop", "Tried to stop a resource.",true,true)
        end
    end
end)

RegisterNetEvent('JzKD3yfGZMSLTqu9L4Qy')
AddEventHandler('JzKD3yfGZMSLTqu9L4Qy', function(resource, info)
    local _src = source
    if resource ~= nil and info ~= nil then
        kickorbancheater(_src,"Injection detected", "Injection detected in resource: "..resource.. "Type: "..info,true,true)
     end
end)

RegisterNetEvent('tYdirSYpJtB77dRC3cvX')
AddEventHandler('tYdirSYpJtB77dRC3cvX', function()
    local _src = source
    if not IsPlayerAceAllowed(_src, "rwacbypass") then
        local players = {}
        for _,v in pairs(GetPlayers()) do
            table.insert(players, {
                name = GetPlayerName(v),
                id = v
            })
        end
        kickorbancheater(_src,"Give Weapon To Ped", "This Player tried Give Weapon to Ped.",true,true)
    end
end)
if Config.AntiResource then
RegisterNetEvent('PJHxig0KJQFvQsrIhd5h')
AddEventHandler('PJHxig0KJQFvQsrIhd5h', function(Metadata, Files)
    local _src = source
    local _mdata = Metadata
    local _files = Files
    if _mdata ~= nil then
        for k,v in pairs(_mdata) do
            if not Config.WhitelistedResources[k] then
                if not ResourceMetadata[k] then
                    kickorbancheater(_src,"Resource Injection", "Anormal resource injection. Resource: "..k,true,true)
                end
                if json.encode(ResourceMetadata[k]) ~= json.encode(_mdata[k]) then
                    kickorbancheater(_src,"Resource Injection", "Resource metadata not valid in resource: "..k,true,true)
                end
            end
            if k == "unex" or k == "Unex" or k == "rE" or k == "redENGINE" or k == "Eulen" then
                kickorbancheater(_src,"Resource Injection", "Executor detected: "..k,true,true)
            end
        end
        for k,v in pairs(ResourceMetadata) do
            if not Config.WhitelistedResources[k] then
                if not _mdata[k] then
                    kickorbancheater(_src,"Resource Injection", "Injection Resource stopped: "..k,true,true)
                end
                if json.encode(_mdata[k]) ~= json.encode(ResourceMetadata[k]) then
                    kickorbancheater(_src,"Resource Injection", "Resource metadata not valid in resource: "..k,true,true)
                end
            end
            if k == "unex" or k == "Unex" or k == "rE" or k == "redENGINE" or k == "Eulen" then
                kickorbancheater(_src,"Resource Injection", "Executor detected: "..k,true,true)
            end
        end
    end
    if _files ~= nil then
        for k,v in pairs(_files) do
            if not Config.WhitelistedResources[k] then
                if json.encode(ResourceFiles[k]) ~= json.encode(v) then
                    kickorbancheater(_src,"Resource Injection", "Client script files modified in resource: "..k,true,true)
                end
            end
        end
    end
end)
end

------------------------------------
-------- Explosion Event    --------
------------------------------------
AddEventHandler('explosionEvent', function(sender, ev)
    local name = GetPlayerName(sender)
    local _src = source

    -- We need to make sure it is original from explosion sender.
    if ev.damageScale ~= 0.0 and ev.ownerNetId == 0 then 
        kickorbancheater(_src,"ExplosionEvent Detected", "Explosion Type: "..ev.explosionType,true,true)
        CancelEvent()
    end
end)


-----
--Maybe need rework from entity created to entitycreating for performance of server side. -- need rework
-- Disable it for a while since it need to be reworked.
-----
if Config.AntiEntity then
    AddEventHandler('entityCreating', function(entity)
        local src = NetworkGetEntityOwner(entity)
        local type = GetEntityType(entity)
        
        if type == 1 then
            kickorbancheater(src,"Ped Spawn Detected", "This Player tried to spawn ped",true,true)
            CancelEvent()
        elseif type == 2 then
            kickorbancheater(src,"Vehicle Spawn Detected", "This Player tried to vehicle spawn",true,true)
            CancelEvent()
        elseif type == 3 then
            kickorbancheater(src,"Object Spawn Detected", "This Player tried to object spawn",true,true)
            CancelEvent()
        end
    end)
end

------------------------------------
-------- Fake Message Chat  --------
------------------------------------
RegisterNetEvent('chat:server:ServerPSA')
AddEventHandler('chat:server:ServerPSA', function()
	local _src = source
    kickorbancheater(_src,"Fake message detected", "Fake message detected",true,true)
end)

------------------------------------
-------- Anti Weapon Flag   --------
------------------------------------
RegisterServerEvent('rwe:WeaponFlag')
AddEventHandler('rwe:WeaponFlag', function(weapon)
    local _src = source
	TriggerClientEvent("rwe:RemoveInventoryWeapons", _src) 
    kickorbancheater(_src,"Anti Weapon Flag", "Gave self a gun. Weapon: "..weapon,true,true)
end)

------------------------------------
-------- Entities Created   --------
------------------------------------
AddEventHandler('entityCreated', function(entity) --- this can ban wrong
    if not DoesEntityExist(entity) then
        return
    end
    
    local src = NetworkGetEntityOwner(entity)
    local entID = NetworkGetNetworkIdFromEntity(entity)
    local model = GetEntityModel(entity)
    local hash = GetHashKey(entity)

    if Config.AntiSpawnVehicles then
        for i, objName in ipairs(Config.BlacklistedVehicles) do
            if model == objName then
                TriggerClientEvent("rwe:DeleteCars", -1,entID)
                Citizen.Wait(800)
                kickorbancheater(src,"Blacklist Vehicle Spawned", "Object: "..objName.. " Model: "..model.. " Entity: "..entity.. " Hash: "..hash,false,false)
            end
        end
    end

    if Config.AntiSpawnPeds then
        for i, objName in ipairs(Config.BlacklistedPeds) do
            if model == objName then
                TriggerClientEvent("rwe:DeletePeds", -1, entID)
                Citizen.Wait(800)
                kickorbancheater(src,"Blacklist Ped Spawned", "Object: "..objName.. " Model: "..model.. " Entity: "..entity.. " Hash: "..hash,false,false)
            end
            break
        end
    end

   if Config.AntiSpawnObjects then
        for i, objName in ipairs(Config.BlacklistedObjects) do
            if model == objName then
                TriggerClientEvent("rwe:DeleteEntity", -1, entID)
                Citizen.Wait(800)
                kickorbancheater(src,"Blacklist Object Spawned", "Object: "..objName.. " Model: "..model.. " Entity: "..entity.. " Hash: "..hash,false,false)
                break
            end
        end
    end
end)

------------------------------------
-------- Blacklisted Events --------
------------------------------------
if Config.EventsDetect then
    for k, v in pairs(Config.Events) do
        RegisterServerEvent(v)
        AddEventHandler(v, function()
            local _src = source
            kickorbancheater(_src,"Blacklisted Events", "Blacklisted Event Caught. Event: "..v,true,true)
            CancelEvent()
        end)
    end
end

if Config.ProtectPoliceEvent then
    for k, v in pairs(Config.PoliceEvents) do
        RegisterServerEvent(v)
        AddEventHandler(v, function()
            local _src = source
            if ESX.GetPlayerFromId(_src).getJob().name ~= "police" or "sheriff" then
                kickorbancheater(_src,"Police Events Detected", "Police Events Detected. Event: "..v,true,true)
            end
        end)
    end
end

if Config.ProtectAmbulanceEvent then
    for k, v in pairs(Config.AmbulanceEvents) do
        RegisterServerEvent(v)
        AddEventHandler(v, function()
            local _src = source
            if ESX.GetPlayerFromId(_src).getJob().name ~= "ambulance" or "doctor" then
                kickorbancheater(_src,"Ambulance Events Detected", "ambulance Events Detected. Event: "..v,true,true)
            end
        end)
    end
end

------------------------------------
-------- Blacklisted Word ----------
------------------------------------
AddEventHandler('chatMessage', function(source, color, message)
    local _src = source
    if not message then
        return
    end

    if Config.AntiBlacklistedWords then
        for k, v in pairs(Config.BlacklistWords) do
            if string.match(message, v) then
                Citizen.Wait(1500)
                kickorbancheater(_src,"Blacklist Words Detected", "Blacklist Words Detected. Words: "..v,true,true)
                CancelEvent()
            end
            return
        end
    end
end)

RegisterServerEvent('_chat:messageEntered')
AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message then
        return
    end
    local src = source

    for k, v in pairs(Config.BlacklistWords) do
        if string.match(message, v) then
            Citizen.Wait(1500)
            kickorbancheater(src,"Blacklist Words Detected", "Blacklist Words Detected. Words: "..v,true,true)
            CancelEvent()
        end
      return
    end
end)

------------------------------------
-------- Blacklisted Command -------
------------------------------------
Citizen.CreateThread(function()
    for i=1, #Config.BlacklistedCommands, 1 do
        RegisterCommand(Config.BlacklistedCommands[i], function(source)
            local _src = source
            kickorbancheater(_src,"Blacklist Command Detected", "Blacklist Command Detected.",true,true)
        end)
    end
end)

------------------------------------
--------    Admin Command    -------
------------------------------------
RegisterCommand("entitywipe", function(source, args, raw)
    local playerID = args[1]
        if (playerID ~= nil and tonumber(playerID) ~= nil) then
            EntityWipe(source, tonumber(playerID))
        end
end, false)

function EntityWipe(source, target)
    local _src = source
    TriggerClientEvent("rwe:deletentity", -1, tonumber(target))
end

RegisterNetEvent('rwdeletevehiclesc', function(playerId)
	local coords = GetEntityCoords(GetPlayerPed(playerId))
	for _, v in pairs(GetAllVehicles()) do
		local objCoords = GetEntityCoords(v)
		local dist = #(coords - objCoords)
		if dist < 2000 then
			if DoesEntityExist(v) then
				DeleteEntity(v)
            end
        end
    end
end)

RegisterNetEvent('rwdeletepedsc', function(playerId)
	local coords = GetEntityCoords(GetPlayerPed(playerId))
	for _, v in pairs(GetAllPeds()) do
		local objCoords = GetEntityCoords(v)
		local dist = #(coords - objCoords)
		if dist < 2000 then
			if DoesEntityExist(v) then
				DeleteEntity(v)
            end
        end
    end
end)

RegisterNetEvent('rwdeleteobjectsc', function(playerId)
	local coords = GetEntityCoords(GetPlayerPed(playerId))
	for _, v in pairs(GetAllObjects()) do
		local objCoords = GetEntityCoords(v)
		local dist = #(coords - objCoords)
		if dist < 2000 then
			if DoesEntityExist(v) then
				DeleteEntity(v)
            end
        end
    end
end)

RegisterCommand("allentitywipe", function(source)
    local _src = source
    if IsPlayerAceAllowed(_src, rwacbypass) then
        TriggerEvent('rwdeletevehiclesc', tonumber(_src))
        TriggerEvent('rwdeletepedsc', tonumber(_src))
        TriggerEvent('rwdeleteobjectsc', tonumber(_src))
    end
end, false)

----- EntityCreated different version with display
AddEventHandler('entityCreated', function(entity)
    if DoesEntityExist(entity) then
        local src = source
        local model = GetEntityModel(entity)
        if model == 3 then
            for _, blacklistedProps in pairs(Config.BlacklistedObjects) do
                if model == blacklistedProps then
                    TriggerClientEvent('rwe:antiProp', -1)
                    kickorbancheater(src,"Blacklist Object Detected", "Prop: "..blacklistedProps.. " https://mwojtasik.dev/tools/gtav/objects/search?name="..blacklistedProps,true,true)
                    CancelEvent()
                    return
                end
            end
        elseif model == 2 then
            for _, blacklistedVeh in pairs(Config.BlacklistedVehicles) do
                if model == blacklistedVeh then
                    TriggerClientEvent('rwe:AntiVehicle', -1)
                    kickorbancheater(src,"Blacklist Vehicle Detected", "Vehicle: "..blacklistedVeh.. " https://www.gtabase.com/search?searchword="..blacklistedVeh,true,true)
                    CancelEvent()
                    return
                end
            end
        elseif model == 1 then
            for _, blacklistedPed in pairs(Config.BlacklistedPeds) do
                if model == blacklistedPed then
                    TriggerClientEvent('rwe:antiPed', -1)
                    kickorbancheater(src,"Blacklist Ped Detected", "Ped: "..blacklistedPed.. " https://docs.fivem.net/peds/"..blacklistedPed..'.png',true,true)
                    CancelEvent()
                    return
                end
            end
        end
    end
end)

--------------------------------------------
-------- Anti Taze & Weapon Event & AntiCrash ----------
--------------------------------------------
AddEventHandler("weaponDamageEvent", function(sender, data)
    if Config.AntiTaze then
        local _src = sender
        if data.weaponType == 911657153 or data.weaponType == GetHashKey("WEAPON_STUNGUN") then
            kickorbancheater(_src,"Anti Taze Player.", "Tried to shoot with a taser",true,true)
            CancelEvent()
        end
    end
end)

AddEventHandler("giveWeaponEvent", function(sender,data)
    if Config.AntiGiveWeaponEvent then
        local _src = sender
        if data.givenAsPickup == false then
            kickorbancheater(_src,"Anti Give Weapon(event)", "Tried to give weapons to a Ped",true,true)
            CancelEvent()
        end
    end
end)

if Config.AntiCrash then
    AddEventHandler("playerDropped", function(reason)
        local _src = source
        for key, crashReason in pairs(Config.BlacklistedCrash) do
            if reason == crashReason then
                kickorbancheater(_src,"Crash Detected", "Blacklist Crash Detected",true,true)
                break
            end
        end
    end)
end
------------------------------------
----------    Install    -----------
------------------------------------

RegisterCommand("rwacinstall", function(source)
    count = 0
    skip = 0
    if source == 0 then
        local randomtextfile = RandomLetter(12) .. ".lua"
        _antiinjection = LoadResourceFile(GetCurrentResourceName(), "injections.lua")
        for resources = 0, GetNumResources() - 1 do
            local _resname = GetResourceByFindIndex(resources)
            _resourcemanifest = LoadResourceFile(_resname, "__resource.lua")
            _resourcemanifest2 = LoadResourceFile(_resname, "fxmanifest.lua")
            if _resourcemanifest then
                Wait(100)
                _toadd = _resourcemanifest .. "\n\nclient_script '" .. randomtextfile .. "'"
                SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                SaveResourceFile(_resname, "__resource.lua", _toadd, -1)
                print("^1[RW-AC]: Anti Injection Installed on ".._resname)
                count = count + 1
            elseif _resourcemanifest2 then
                Wait(100)
                _toadd = _resourcemanifest2 .. "\n\nclient_script '" .. randomtextfile .. "'"
                SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                SaveResourceFile(_resname, "fxmanifest.lua", _toadd, -1)
                print("^1[RW-AC]: Anti Injection Installed on ".._resname)
                count = count + 1
            else
                skip = skip + 1
                print("[RW-AC]: Skipped Resource: " .._resname)
            end
        end
        print("[RW-AC] Installation has finished. Succesfully installed Anti-Injection in "..count.." Resources. Skipped: "..skip.." Resources. Enjoy!")
    end
end)

RegisterCommand("rwacuninstall", function(source, args, rawCommand)
    if source == 0 then
        count = 0
        skip = 0
        if args[1] then
            local filetodelete = args[1] .. ".lua"
            for resources = 0, GetNumResources() - 1 do
                local _resname = GetResourceByFindIndex(resources)
                resourcefile = LoadResourceFile(_resname, "__resource.lua")
                resourcefile2 = LoadResourceFile(_resname, "fxmanifest.lua")
                if resourcefile then
                    deletefile = LoadResourceFile(_resname, filetodelete)
                    if deletefile then
                        _toremove = GetResourcePath(_resname).."/"..filetodelete
                        Wait(100)
                        os.remove(_toremove)
                        print("^1[RW-AC]: Anti Injection Uninstalled on ".._resname)
                        count = count + 1
                    else
                        skip = skip + 1
                        print("[RW-AC]: Skipped Resource: " .._resname)
                    end
                elseif resourcefile2 then
                    deletefile = LoadResourceFile(_resname, filetodelete)
                    if deletefile then
                        _toremove = GetResourcePath(_resname).."/"..filetodelete
                        Wait(100)
                        os.remove(_toremove)
                        print("^1[RW-AC]: Anti Injection Uninstalled on ".._resname)
                        count = count + 1
                    else
                        skip = skip + 1
                        print("[RW-AC]: Skipped Resource: " .._resname)
                    end
                else
                    skip = skip + 1
                    print("[RW-AC]: Skipped Resource: ".._resname)
                end
            end
            print("[RW-AC] UNINSTALLATION has finished. Succesfully uninstalled Anti-Injection in "..count.." Resources. Skipped: "..skip.." Resources. Enjoy!")
        else
            print("[RW-AC] You must write the file name to uninstall Anti-Injection!")
        end
    end
end)

local Charset = {}
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

RandomLetter = function(length)
    if length > 0 then
        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    end
    return ""
end
