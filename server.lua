ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local ResourceMetadata = {}
local ResourceFiles = {}

-- Version Control

Citizen.CreateThread(function()
  Citizen.Wait(1000)
    VersionControl = function(err, result, headers)
        if result then
            local data = json.decode(result)
            if data.version ~= Config.Version then
                print("\n")
                print("^2[RW-AntiCheat] ^0New version finded: ".. data.version .." Updates: \n".. data.updates .. "\n")
                print("https://github.com/RaweRwe/rw-anticheat\n")
            end
            if data.version == Config.Version then
                print("\n")
                print("^2[RW-AntiCheat] ^0You using latest version: ".. data.version)
            end
        end
    end
  PerformHttpRequest("https://raw.githubusercontent.com/RaweRwe/rw-anticheat-version/main/anticheat.json", VersionControl, "GET")
end)

-------
RegisterServerEvent("rwe:kickcheater")
AddEventHandler("rwe:kickcheater", function(reason)
    local _src = source
    local identifier = GetPlayerIdentifiers(_src)[1]

    DropPlayer(_src, "[RW-AC] "..reason)		
end)

kickdetectedcheater = function(reason, servertarget) -- kick func
    if not IsPlayerAceAllowed(servertarget, "rwacbypass") then
        local target
        local reason    = reason

        if tostring(source) == "" then
            target = tonumber(servertarget)
        else
            target = source
        end

        DropPlayer(target, "[RW-AC] " ..reason)
    end
end
-------
RegisterServerEvent("rwe:cheatlog")
AddEventHandler("rwe:cheatlog", function(reason)
  local src = source
      local connect = {
            {
                ["color"] = 23295,
                ["title"] = reason,
                ["description"] = "Player: "..GetPlayerName(src).. " "  ..GetPlayerIdentifiers(src)[1].."  ",
                ["footer"] = {
                ["text"] = "github.com/RaweRwe/rw-anticheat",
                },
            }
        }
    PerformHttpRequest(Config.WebhookDiscord, function(err, text, headers) end, 'POST', json.encode({username = "RW-AC", embeds = connect, avatar_url = "https://e7.pngegg.com/pngimages/163/941/png-clipart-computer-icons-x-mark-old-letters-angle-logo.png"}), { ['Content-Type'] = 'application/json' })
end)

---------------------------
-------- BAN BOOGERS ------
--------------------------- 
function cookiebanlistregenerator()
	local o = LoadResourceFile(GetCurrentResourceName(), "cookie-bans.json")
	if not o or o == "" then
		SaveResourceFile(GetCurrentResourceName(), "cookie-bans.json", "[]", -1)
		print("^"..math.random(1, 9).."^3Warning! ^0Your ^1cookie-bans.json ^0is missing, Regenerating your ^1cookie-bans.json ^0file!")
	else
		local p = json.decode(o)
		if not p then
			SaveResourceFile(GetCurrentResourceName(), "cookie-bans.json", "[]", -1)
			p = {}
			print("^"..math.random(1, 9).."^3Warning! ^0Your ^1cookie-bans.json ^0is corrupted, Regenerating your ^1cookie-bans.json ^0file!")
		end
	end
end

function CookieBans(source,reason)
    local config = LoadResourceFile(GetCurrentResourceName(), "cookie-bans.json")
    local data = json.decode(config)
	local _src = source

    if config == nil then
        cookiebanlistregenerator()
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
    SaveResourceFile(GetCurrentResourceName(), "cookie-bans.json", json.encode(data, { indent = true }), -1)
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
    local config = LoadResourceFile(GetCurrentResourceName(), "cookie-bans.json")
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

function sendcookies(source,content,info,c,d)
    local _source = source
    local sname = GetPlayerName(source)
    --Identifiers
    local steam = "unknown"
	local discord = "unknown"
	local license = "unknown"
	local live = "unknown"
	local xbl = "unknown"

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
            ["text"] = "github.com/RaweRwe/rw-anticheat",
            },
        }
    }
    PerformHttpRequest(Config.WebhookDiscord, function(err, text, headers) end, 'POST', json.encode({username = "RW-AC", embeds = discordinfo}), { ['Content-Type'] = 'application/json' })
    
    if d then
        CookieBans(source,content)
    end

    if c then
        DropPlayer(source, "Kicked : "..Config.DropMsg)
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
    local config = LoadResourceFile(GetCurrentResourceName(), "cookie-bans.json")
    local data = json.decode(config)

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
-----

RegisterServerEvent("8jWpZudyvjkDXQ2RVXf9")
AddEventHandler("8jWpZudyvjkDXQ2RVXf9", function(type)
    local _type = type or "default"
    local _src = source
    local _name = GetPlayerName(_src)
    _type = string.lower(_type)

    if not IsPlayerAceAllowed(_src, "rwacbypass") then
        if (_type == "invisible") then
            sendcookies(_src,"Tried to be Invisible", "This Player tried to Invisible",true,true)
        elseif (_type == "antiragdoll") then
            sendcookies(_src,"AntiRagdoll Detected", "This Player tried to activate Anti-Ragdoll",true,true)
        elseif (_type == "displayradar") then
            sendcookies(_src,"Radar Detected", "This Player tried to activate Radar",true,true)
        elseif (_type == "explosiveweapon") then
            sendcookies(_src,"Weapon Explosion Detected", "This Player tried to change bullet type",true,true)
        elseif (_type == "spectatormode") then
            sendcookies(_src,"Spectate Detected", "This Player tried to Spectate a Player",true,true)
        elseif (_type == "speedhack") then
            sendcookies(_src,"SpeedHack Detected", "This Player tried to SpeedHack",true,true)
        elseif (_type == "blacklistedweapons") then
            sendcookies(_src,"Weapon in Blacklist", "This Player tried to spawn a Blacklisted Weapon",true,true)
        elseif (_type == "thermalvision") then
            sendcookies(_src,"Thermal Camera Detected", "This Player tried to use Thermal Camera",true,true)
        elseif (_type == "nightvision") then
            sendcookies(_src,"Night Vision Detected", "This Player tried to use Night Vision",true,true)
        elseif (_type == "antiresourcestop") then
            sendcookies(_src,"Resource Stopped", "This Player tried to stop/start a Resource",true,true)
        elseif (_type == "pedchanged") then
            sendcookies(_src,"Ped Changed", "This Player tried to change his PED",true,true)
        elseif (_type == "freecam") then
            sendcookies(_src,"FreeCam Detected", "This Player tried to use Freecam (Fallout or similar)",true,true)
        elseif (_type == "infiniteammo") then
            sendcookies(_src,"Infinite Ammo Detected", "This Player tried to put Infinite Ammo",true,true)
        elseif (_type == "resourcestarted") then
            sendcookies(_src,"AntiResourceStart", "This Player tried to start a resource",true,true)
        elseif (_type == "menyoo") then
            sendcookies(_src,"Anti Menyoo", "This Player tried to inject Menyoo Menu",true,true)
        elseif (_type == "givearmour") then
            sendcookies(_src,"Anti Give Armor", "This Player tried to Give Armor",true,true)
        elseif (_type == "aimassist") then
            sendcookies(_src,"Aim Assist", "This Player tried Aim Assist Detected. Mode: ",true,true)
        elseif (_type == "infinitestamina") then
            sendcookies(_src,"Anti Infinite Stamina", "This Player tried to use Infinite Stamina",true,true)
        elseif (_type == "superjump") then
            if IsPlayerUsingSuperJump(_src) then
                sendcookies(_src,"Superjump Detected", "This Player tried to use Superjump",true,true)
            end
        elseif (_type == "vehicleweapons") then
            sendcookies(_src,"Vehicle Weapons Detected", "This Player tried to use Vehicle Weapons",true,true)
        end
    end
end)

RegisterNetEvent('JzKD3yfGZMSLTqu9L4Qy')
AddEventHandler('JzKD3yfGZMSLTqu9L4Qy', function(resource, info)
    local _src = source
    if resource ~= nil and info ~= nil then
        sendwebhooktodc("Injection detected in resource: "..resource.. " Type: "..info)
        kickdetectedcheater("Injection detected", _src)
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
        kickdetectedcheater("Why u cheating ?", _src)
    end
end)
RegisterNetEvent('PJHxig0KJQFvQsrIhd5h')
AddEventHandler('PJHxig0KJQFvQsrIhd5h', function(Metadata, Files)
    local _src = source
    local _mdata = Metadata
    local _files = Files
    if _mdata ~= nil then
        for k,v in pairs(_mdata) do
            if not Config.WhitelistedResources[k] then
                if not ResourceMetadata[k] then
                    sendwebhooktodc("Anormal resource injection. Resource: "..k)
                    kickdetectedcheater("Resource Injection", _src)
                end
                if json.encode(ResourceMetadata[k]) ~= json.encode(_mdata[k]) then
                    sendwebhooktodc("Resource metadata not valid in resource: "..k)
                    kickdetectedcheater("Resource Injection", _src)
                end
            end
            if k == "unex" or k == "Unex" or k == "rE" or k == "redENGINE" or k == "Eulen" then
                sendwebhooktodc("Executor detected: "..k)
                kickdetectedcheater("Resource Injection", _src)
            end
        end
        for k,v in pairs(ResourceMetadata) do
            if not Config.WhitelistedResources[k] then
                if not _mdata[k] then
                    sendwebhooktodc("Injection Resource stopped: "..k)
                    kickdetectedcheater("Resource Injection", _src)
                end
                if json.encode(_mdata[k]) ~= json.encode(ResourceMetadata[k]) then
                    sendwebhooktodc("Resource metadata not valid in resource: "..k)
                    kickdetectedcheater("Resource Injection", _src)
                end
            end
            if k == "unex" or k == "Unex" or k == "rE" or k == "redENGINE" or k == "Eulen" then
                sendwebhooktodc("Executor detected: "..k)
                kickdetectedcheater("Resource Injection", _src)
            end
        end
    end
    if _files ~= nil then
        for k,v in pairs(_files) do
            if not Config.WhitelistedResources[k] then
                if json.encode(ResourceFiles[k]) ~= json.encode(v) then
                    sendwebhooktodc("Client script files modified in resource: "..k)
                    kickdetectedcheater("Resource Injection", _src)
                end
            end
        end
    end
end)

------------------------------------
-------- Explosion Event    --------
------------------------------------
AddEventHandler('explosionEvent', function(sender, ev)
    local name = GetPlayerName(sender)

    -- We need to make sure it is original from explosion sender.
    if ev.damageScale ~= 0.0 and ev.ownerNetId == 0 then 
        sendwebhooktodc("ExplosionEvent Detected".." Sender: "..name.." Explosion Type: "..ev.explosionType)
        TriggerEvent("rwe:kickcheater", Config.DropMsg)
        CancelEvent()
    end
end)


-----
--Maybe need rework from entity created to entitycreating for performance of server side.
-----
AddEventHandler('entityCreating', function(entity)
  local src = NetworkGetEntityOwner(entity)
  local name = GetPlayerName(source)
  local id = src
  local model = GetEntityModel(entity)
  local whitelisted = false
  local type = GetEntityType(entity)
    if type == 1 then
    elseif type == 2 then
    elseif type == 3 then
        sendwebhooktodc("Object Spawned Object hash: "..model)
        -- TriggerEvent("rwe:cheatlog", "Yasaklı Obje Tespit Edildi : "..GetPlayerName(src).. "Obje : "..model)
        CancelEvent()
    else
        TriggerEvent("rwe:kickcheater", Config.DropMsg)
    end
end)

------------------------------------
-------- Fake Message Chat  --------
------------------------------------
RegisterNetEvent('chat:server:ServerPSA')
AddEventHandler('chat:server:ServerPSA', function()
	local _source = source
    local name = GetPlayerName(_source)
	TriggerEvent('rwe:kickcheater', Config.DropMsg)
    sendwebhooktodc("Fake message detected".." Player: "..name)
end)

------------------------------------
-------- Anti Weapon Flag   --------
------------------------------------
RegisterServerEvent('rwe:WeaponFlag')
AddEventHandler('rwe:WeaponFlag', function(weapon)
    local src = source
    local name = GetPlayerName(src)

    sendwebhooktodc("Gave self a gun. Weapon: "..weapon.." Player: "..name)
	TriggerClientEvent("rwe:RemoveInventoryWeapons", src) 
    TriggerEvent("rwe:kickcheater", Config.DropMsg)
end)

------------------------------------
-------- Entities Created   --------
------------------------------------
AddEventHandler('entityCreated', function(entity)
    local entity = entity
    if not DoesEntityExist(entity) then
        return
    end
    
    local src = NetworkGetEntityOwner(entity)
    local entID = NetworkGetNetworkIdFromEntity(entity)
    local model = GetEntityModel(entity)
    local hash = GetHashKey(entity)
    local SpawnerName = GetPlayerName(src)

    if Config.AntiSpawnVehicles then
        for i, objName in ipairs(Config.AntiNukeBlacklistedVehicles) do
            if model == objName then
                TriggerClientEvent("rwe:DeleteCars", -1,entID)
                Citizen.Wait(800)
                    sendwebhooktodc("Blacklist Vehicle Spawned, **-Player: **"..SpawnerName.."\n\n**-Object Name: **"..objName.."\n\n**-Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash)
                    TriggerEvent("rwe:kickcheater", Config.DropMsg)
            end
        end
    end

    if Config.AntiSpawnPeds then
        for i, objName in ipairs(Config.AntiNukeBlacklistedPeds) do
            if model == objName then
                TriggerClientEvent("rwe:DeletePeds", -1, entID)
                Citizen.Wait(800)
                sendwebhooktodc("BlacklistPed **-Player: **"..SpawnerName.."\n\n**-Object Name: **"..objName.."\n\n**-Nesne Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash)
                TriggerEvent("rwe:kickcheater", Config.DropMsg)
            end
            break
        end
    end

   if Config.AntiNuke then
        for i, objName in ipairs(Config.AntiNukeBlacklistedObjects) do
            if model == objName then
                TriggerClientEvent("rwe:DeleteEntity", -1, entID)
                Citizen.Wait(800)
                sendwebhooktodc("Blacklist Object Spawned, **-Spawner Name: **"..SpawnerName.."\n\n**-Object Name: **"..objName.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash)
                TriggerEvent("rwe:kickcheater", Config.DropMsg)
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
            CancelEvent()
            sendwebhooktodc("Blacklisted Event Caught. Event: " ..v.." Player: "..GetPlayerName(source))
            TriggerEvent("rwe:kickcheater", Config.DropMsg)
        end)
    end
end


------------------------------------
-------- Blacklisted Word ----------
------------------------------------
AddEventHandler('chatMessage', function(source, color, message)
    if not message then
        return
    end

    for k, v in pairs(Config.BlacklistWords) do
        if string.match(message, v) then
            sendwebhooktodc('Blacklist Words Detected! Words: '..v)
            Citizen.Wait(1500)
            TriggerEvent("rwe:kickcheater", Config.DropMsg)
            CancelEvent()
        end
        return
    end
end)

RegisterServerEvent('_chat:messageEntered')
AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message then
        return
    end
    local src = source
    local name = GetPlayerName(src)

    for k, v in pairs(Config.BlacklistWords) do
        if string.match(message, v) then
            sendwebhooktodc('BlacklistWords Detected! Words: '..v.." Player: "..name)
            CancelEvent()
            Citizen.Wait(1500)
            TriggerEvent("rwe:kickcheater", Config.DropMsg)
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
            local name = GetPlayerName(source)
            sendwebhooktodc("Blacklist Command Detected. Command: " ..Config.BlacklistedCommands[i].." Player: "..name)
            TriggerEvent("rwe:kickcheater", Config.DropMsg)
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
    if IsPlayerAceAllowed(_src, "rwacbypass") then
        TriggerClientEvent("rwe:deletentity", -1, tonumber(target))
    end
end

------------------------------------
--------    BlackList Name / Player   ------
------------------------------------
local x = {}

AddEventHandler("playerConnecting", function(playerName)
    playerName = (string.gsub(string.gsub(string.gsub(playerName,  "-", ""), ",", ""), " ", ""):lower())
    for k, v in pairs(Config.BlacklistName) do
        local g, f = playerName:find(string.lower(v))
            if g or f  then
                table.insert (x, v)
                local blresult = table.concat(x, " ")
                sendwebhooktodc('Blacklist Name Detected!')
                TriggerEvent("rwe:kickcheater", Config.DropMsg)
                CancelEvent()
            for key in pairs (x) do
                x [key] = nil
            end
        end
    end

    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]

    for k, v in pairs(Config.BlacklistPlayer) do
        if v == identifier then
            sendwebhooktodc('Blacklisted Player Tried to Join!')
            TriggerEvent("rwe:kickcheater", Config.DropMsg)
            CancelEvent()
        end
    end
end)

----- EntityCreated different version with display
AddEventHandler('entityCreated', function(entity)
    if DoesEntityExist(entity) then
        local model = GetEntityModel(entity)
        if model == 3 then
            for _, blacklistedProps in pairs(Config.AntiNukeBlacklistedObjects) do
                if model == blacklistedProps then
                    sendwebhooktodc('Blacklist Object Detected! Player: ' ..src.. 'Prop: '..blacklistedProps..'\n**Prop:** https://plebmasters.de/?search='..blacklistedProps..'&app=objects \n **Mwojtasik:** https://mwojtasik.dev/tools/gtav/objects/search?name='..blacklistedProps)
                    TriggerClientEvent('rwe:antiProp', -1)
                    TriggerEvent("rwe:kickcheater", Config.DropMsg)
                    CancelEvent()
                    return
                end
            end
        elseif model == 2 then
            for _, blacklistedVeh in pairs(Config.AntiNukeBlacklistedVehicles) do
                if model == blacklistedVeh then
                    sendwebhooktodc('Blacklist Vehicle Detected: '..blacklistedVeh..'\n **Vehicle: ** https://www.gtabase.com/search?searchword='..blacklistedVeh)
                    TriggerClientEvent('rwe:AntiVehicle', -1)
                    TriggerEvent("rwe:kickcheater", Config.DropMsg)
                    CancelEvent()
                    return
                end
            end
        elseif model == 1 then
            for _, blacklistedPed in pairs(Config.AntiNukeBlacklistedPeds) do
                if model == blacklistedPed then
                    sendwebhooktodc('Blacklist Ped Detected: '..blacklistedPed..'\n **Ped:** https://docs.fivem.net/peds/'..blacklistedPed..'.png')
                    TriggerClientEvent('rwe:antiPed', -1)
                    TriggerEvent("rwe:kickcheater", Config.DropMsg)
                    CancelEvent()
                    return
                end
            end
        end
    end
end)

------------------------------------
--------    Install Injections.lua    -------
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