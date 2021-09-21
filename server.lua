ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local WebhookLink = "" -- discord webhook

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
RegisterServerEvent("rwe:siktirgitkoyunekrds")
AddEventHandler("rwe:siktirgitkoyunekrds", function(reason)
    local _src = source
    local identifier = GetPlayerIdentifiers(_src)[1]

    DropPlayer(_src, "[RW-AC] "..reason)		
end)

siktimbelani = function(reason, servertarget) -- kick func
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
    PerformHttpRequest(WebhookLink, function(err, text, headers) end, 'POST', json.encode({username = "RW-AC", embeds = connect, avatar_url = "https://e7.pngegg.com/pngimages/163/941/png-clipart-computer-icons-x-mark-old-letters-angle-logo.png"}), { ['Content-Type'] = 'application/json' })
end)
-------------

function webhookualdimgonderdim(content)
   local _source = source
         local connect = {
        {
            ["color"] = "23295",
            ["title"] = "Rawe AntiCheat",
            ["description"] = "Player: "..GetPlayerName(_source).. " "  ..GetPlayerIdentifiers(_source)[1].."", content,
            ["footer"] = {
            ["text"] = "github.com/RaweRwe/rw-anticheat",
            },
        }
    }
  PerformHttpRequest(WebhookLink, function(err, text, headers) end, 'POST', json.encode({username = "RW-AC", embeds = connect}), { ['Content-Type'] = 'application/json' })
end

-----

RegisterServerEvent("8jWpZudyvjkDXQ2RVXf9")
AddEventHandler("8jWpZudyvjkDXQ2RVXf9", function(type)
    local _type = type or "default"
    local _src = source
    local isim = GetPlayerName(_src)
    _type = string.lower(_type)

    if not IsPlayerAceAllowed(_src, "rwacbypass") then
        if (_type == "invisible") then
            webhookualdimgonderdim("Tried to be Invisible " ..isim)
            siktimbelani("Invisible Player Detected", _src)
        elseif (_type == "antiragdoll") then
            webhookualdimgonderdim("Tried to activate Anti-Ragdoll " ..isim)
            siktimbelani("AntiRagdoll Detected", _src)
        elseif (_type == "displayradar") then
            webhookualdimgonderdim("Tried to activate Radar " ..isim)
            siktimbelani("Radar Detected", _src)
        elseif (_type == "explosiveweapon") then
            webhookualdimgonderdim("Tried to change bullet type " ..isim)
            siktimbelani("Weapon Explosion Detected", _src)
        elseif (_type == "spectatormode") then
            webhookualdimgonderdim("Tried to Spectate a Player " ..isim)
            siktimbelani("Spectate Detected", _src)
        elseif (_type == "speedhack") then
            webhookualdimgonderdim("Tried to SpeedHack " ..isim)
            siktimbelani("SpeedHack Detected", _src)
        elseif (_type == "blacklistedweapons") then
            webhookualdimgonderdim("Tried to spawn a Blacklisted Weapon " ..isim)
            siktimbelani("Weapon in Blacklist Detected", _src)
        elseif (_type == "thermalvision") then
            webhookualdimgonderdim("Tried to use Thermal Camera " ..isim)
            siktimbelani("Thermal Camera Detected", _src)
        elseif (_type == "nightvision") then
            webhookualdimgonderdim("Tried to use Night Vision " ..isim)
            siktimbelani("Night Vision Detected", _src)
        elseif (_type == "antiresourcestop") then
            webhookualdimgonderdim("Tried to stop/start a Resource " ..isim)
            siktimbelani("Resource Stopped", _src)
        elseif (_type == "pedchanged") then
            webhookualdimgonderdim("Tried to change his PED " ..isim)
            siktimbelani("Ped Changed", _src)
        elseif (_type == "freecam") then
            webhookualdimgonderdim("Tried to use Freecam (Fallout or similar) " ..isim)
            siktimbelani("FreeCam Detected", _src)
        elseif (_type == "infiniteammo") then
            webhookualdimgonderdim("Tried to put Infinite Ammo")
            siktimbelani("Infinite Ammo Detected", _src)
        elseif (_type == "resourcestarted") then
            webhookualdimgonderdim("Tried to start a resource "..isim)
            siktimbelani("AntiResourceStart", _src)
        elseif (_type == "menyoo") then
            webhookualdimgonderdim("Tried to inject Menyoo Menu " ..isim)
            siktimbelani("Anti Menyoo", _src)
        elseif (_type == "givearmour") then
            webhookualdimgonderdim("Tried to Give Armor " ..isim)
            siktimbelani("Anti Give Armor", _src)
        elseif (_type == "aimassist") then
            webhookualdimgonderdim("Aim Assist Detected. Mode: "..isim)
        elseif (_type == "infinitestamina") then
            webhookualdimgonderdim("Tried to use Infinite Stamina " ..isim)
            siktimbelani("Anti Infinite Stamina", _src)
        elseif (_type == "superjump") then
            if IsPlayerUsingSuperJump(_src) then
                webhookualdimgonderdim("Superjump Detected "..isim)
                siktimbelani("Superjump Detected", _src)
            end
        elseif (_type == "vehicleweapons") then
            webhookualdimgonderdim("Vehicle Weapons Detected: "..isim)
            siktimbelani("Vehicle Weapons Detected", _src)
        end
    end
end)

RegisterNetEvent('JzKD3yfGZMSLTqu9L4Qy')
AddEventHandler('JzKD3yfGZMSLTqu9L4Qy', function(resource, info)
    local _src = source
    if resource ~= nil and info ~= nil then
        webhookualdimgonderdim("Injection detected in resource: "..resource.. " Type: "..info)
        siktimbelani("Injection detected", _src)
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
        siktimbelani("Why u cheating ?", _src)
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
                    webhookualdimgonderdim("Anormal resource injection. Resource: "..k)
                    siktimbelani("Resource Injection", _src)
                end
                if json.encode(ResourceMetadata[k]) ~= json.encode(_mdata[k]) then
                    webhookualdimgonderdim("Resource metadata not valid in resource: "..k)
                    siktimbelani("Resource Injection", _src)
                end
            end
            if k == "unex" or k == "Unex" or k == "rE" or k == "redENGINE" or k == "Eulen" then
                webhookualdimgonderdim("Executor detected: "..k)
                siktimbelani("Resource Injection", _src)
            end
        end
        for k,v in pairs(ResourceMetadata) do
            if not Config.WhitelistedResources[k] then
                if not _mdata[k] then
                    webhookualdimgonderdim("Injection Resource stopped: "..k)
                    siktimbelani("Resource Injection", _src)
                end
                if json.encode(_mdata[k]) ~= json.encode(ResourceMetadata[k]) then
                    webhookualdimgonderdim("Resource metadata not valid in resource: "..k)
                    siktimbelani("Resource Injection", _src)
                end
            end
            if k == "unex" or k == "Unex" or k == "rE" or k == "redENGINE" or k == "Eulen" then
                webhookualdimgonderdim("Executor detected: "..k)
                siktimbelani("Resource Injection", _src)
            end
        end
    end
    if _files ~= nil then
        for k,v in pairs(_files) do
            if not Config.WhitelistedResources[k] then
                if json.encode(ResourceFiles[k]) ~= json.encode(v) then
                    webhookualdimgonderdim("Client script files modified in resource: "..k)
                    siktimbelani("Resource Injection", _src)
                end
            end
        end
    end
end)
---------
AddEventHandler('explosionEvent', function(sender)
    local name = GetPlayerName(sender)
    webhookualdimgonderdim("Kişi patlayıcı spawnladı  "..name)
    TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
    CancelEvent()
end)
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
        -- webhookualdimgonderdim("Kişi obje spawnladı İsim : "..name.. "Obje hash : "..model)
        TriggerEvent("rwe:cheatlog", "Yasaklı Obje Tespit Edildi : "..GetPlayerName(src).. "Obje : "..model)
        CancelEvent()
    else
        TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
    end
end)
-----
RegisterNetEvent('chat:server:ServerPSA')
AddEventHandler('chat:server:ServerPSA', function()
	local _source = source
    local name = GetPlayerName(_source)
	TriggerEvent('rwe:siktirgitkoyunekrds', 'Kardeşim Napıyorsun Öyle')
    webhookualdimgonderdim("Hileci Chate mesaj göndermeye çalıştı : "..name)
end)
-----
RegisterServerEvent('rwe:WeaponFlag')
AddEventHandler('rwe:WeaponFlag', function(weapon)
    local src = source
	-- local license, steam = GetPlayerNeededIdentifiers(src)
    local name = GetPlayerName(src)

    webhookualdimgonderdim("Kişi kendisine silah verdi İsim : "..name.. "Silah : "..weapon)
	TriggerClientEvent("rwe:RemoveInventoryWeapons", src) 
    TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
end)

-----Entities Detection
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
                    webhookualdimgonderdim("Blacklist Vehicle Spawned, **-Player: **"..SpawnerName.."\n\n**-Object Name: **"..objName.."\n\n**-Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash)
                    TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
            end
        end
    end

    if Config.AntiSpawnPeds then
        for i, objName in ipairs(Config.AntiNukeBlacklistedPeds) do
            if model == objName then
                TriggerClientEvent("rwe:DeletePeds", -1, entID)
                Citizen.Wait(800)
                webhookualdimgonderdim("BlacklistPed **-Player: **"..SpawnerName.."\n\n**-Object Name: **"..objName.."\n\n**-Nesne Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash)
                TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
            end
            break
        end
    end

   if Config.AntiNuke then
        for i, objName in ipairs(Config.AntiNukeBlacklistedObjects) do
            if model == objName then
                TriggerClientEvent("rwe:DeleteEntity", -1, entID)
                Citizen.Wait(800)
                webhookualdimgonderdim("Blacklist Object Spawned, **-Spawner Name: **"..SpawnerName.."\n\n**-Object Name: **"..objName.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash)
                TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
                break
            end
        end
    end
end)


------
Citizen.CreateThread(function()
    for k, v in pairs(Config.Events) do
        if Config.EventsDetect then
            RegisterServerEvent(tostring(v))
            AddEventHandler(tostring(v), function()
               local src = source
               local name = GetPlayerName(src)
               webhookualdimgonderdim("Event Yakalandı : "..name.. " Triggerlanan Event: " ..v)
               TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
            end)
        end
    end
end)
------
AddEventHandler('chatMessage', function(source, color, message)
    if not message then
        return
    end

    for k, v in pairs(Config.BlacklistWords) do
        if string.match(message, v) then
            webhookualdimgonderdim('BlacklistWords Detected! Words: '..v)
            Citizen.Wait(1500)
            TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
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
            webhookualdimgonderdim('BlacklistWords Detected! Words: '..v.. 'Name : '..name)
            CancelEvent()
            Citizen.Wait(1500)
            TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
        end
      return
    end
end)
------
Citizen.CreateThread(function()
    for i=1, #Config.BlacklistedCommands, 1 do
        RegisterCommand(Config.BlacklistedCommands[i], function(source)
            local src = source
            local name = GetPlayerName(src)
            webhookualdimgonderdim("Blacklist Komut Yakalandı : " ..name .. "Kullanılan Komut" ..Config.BlacklistedCommands[i])
            TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
         end)
    end
end)
-----
RegisterCommand("entitywipe", function(source, args, raw)
    local playerID = args[1]
        if (playerID ~= nil and tonumber(playerID) ~= nil) then
            EntityWipe(source, tonumber(playerID))
        end
end, false)

function EntityWipe(source, target)
    local _src = source
    if IsPlayerAceAllowed(_src, "rwacbypass") then
        TriggerClientEvent("rwe:Entityyoketsikerim", -1, tonumber(target))
    end
end

----- BlackList Name 
local unauthNames = {
    "administrator", "admin", "adm1n", "adm!n", "admln", "moderator", "owner", "nigger", "n1gger", "moderator", "eulencheats", "lynxmenu", "atgmenu", "hacker", "bastard", "hamhaxia", "333gang", "n1gger", "n1ga", "nigga", "n1gga", "nigg3r",
    "nig3r", "shagged", "4dm1n", "4dmin", "m0d3r4t0r", "n199er", "n1993r", "rustchance.com", "rustchance", "hellcase.com", "hellcase", "youtube.com", "youtu.be", "youtube", "twitch.tv", "twitch", "anticheat.gg", "anticheat", "fucking", "ψ", 
    "@", "&", "{", "}", ";", "ϟ", "♕", "Æ", "Œ", "‰", "™", "š", "œ", "Ÿ", "µ", "ß",
    "±", "¦", "»", "«", "¼", "½", "¾", "¬", "¿", "Ñ", "®", "©", "²", "·", "•", "°", "þ", "ベ", "ル", "ろ", "ぬ", "ふ", "う", "え", "お", "や", "ゆ", "よ", "わ", "ほ", "へ", "た", "て", "い", "す", "か", "ん", "な", "に", "ら", "ぜ", "む",
    "ち", "と", "し", "は", "き", "く", "ま", "の", "り", "れ", "け", "む", "つ", "さ", "そ", "ひ", "こ", "み", "も", "ね", "る", "め", "ロ", "ヌ", "フ", "ア", "ウ", "エ", "オ", "ヤ", "ユ", "ヨ", "ワ", "ホ", "ヘ", "タ", "テ", "イ", "ス", "カ", "ン",
    "ナ", "ニ", "ラ", "セ", "ム", "チ", "ト", "シ", "ハ", "キ", "ク", "マ", "ノ", "リ", "レ", "ケ", "ム", "ツ", "サ", "ソ", "ヒ", "コ", "ミ", "モ", "ネ", "ル", "メ", "✪", "Ä", "ƒ", "Ã", "¢", "?", "†", "€", "웃", "и", "】", "【", "j4p.pl", "ֆ", "ȶ",
    "你", "好", "爱", "幸", "福", "猫", "狗", "微", "笑", "中", "安", "東", "尼", "杰", "诶", "西", "开", "陈", "瑞", "华", "馬", "塞", "洛", "ダ", "仇", "觉", "感", "衣", "德", "曼", "L͙", "a͙", "l͙", "ľ̶̚͝", "Ḩ̷̤͚̤͑͂̎̎͆", "a̸̢͉̠͎͒͌͐̑̇", "♚", "я", "Ʒ", "Ӂ̴", "Ƹ̴", "≋",
    "chocohax", "civilgamers.com", "civilgamers", "csgoempire.com", "csgoempire", "g4skins.com", "g4skins", "gameodds.gg", "duckfuck.com", "crysishosting.com", "crysishosting", "key-drop.com", "key-drop.pl", "skinhub.com", "skinhub", "`", "¤", "¡",
    "casedrop.eu", "casedrop", "cs.money", "rustypot.com", "ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â", "✈", "⛧", "☭", "☣", "✠", "dkb.xss.ht", "( . )( . )", "⚆", "╮", "╭", "rampage.lt", "?", "xcasecsgo.com", "xcasecsgo", "csgocases.com",
    "csgocases", "K9GrillzUK.co.uk", "moat.gg", "princevidz.com", "princevidz", "pvpro.com", "Pvpro", "ez.krimes.ro", "loot.farm", "arma3fisherslife.net", "arma3fisherslife", "egamers.io", "ifn.gg", "key-drop", "sups.gg", "tradeit.gg",
    "§", "csgotraders.net", "csgotraders", "Σ", "Ξ", "hurtfun.com", "hurtfun", "gamekit.com", "¥", "t.tv", "yandex.ru", "yandex", "csgofly.com", "csgofly", "pornhub.com", "pornhub", "一", "", "Ｊ", "◢", "◤", "⋡", "℟", "ᴮ", "ᴼ", "ᴛᴇᴀᴍ",
    "cs.deals", "twat", "ESX", "ESX_TEAM", "ESXTEAM"}
local x = {}

AddEventHandler("playerConnecting", function(playerName)
    playerName = (string.gsub(string.gsub(string.gsub(playerName,  "-", ""), ",", ""), " ", ""):lower())
    for k, v in pairs(unauthNames) do
      local g, f = playerName:find(string.lower(v))
      if g or f  then
        table.insert (x, v)
        local blresult = table.concat(x, " ")
            TriggerEvent("rwe:cheatlog", "BlacklistName Detected! Player: " ..GetPlayerName(source))
            TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
            CancelEvent()
            for key in pairs (x) do
                x [key] = nil
            end
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
                    webhookualdimgonderdim('BlacklistObject Detected! Player: ' ..src.. 'Prop: '..blacklistedProps..'\n**Prop:** https://plebmasters.de/?search='..blacklistedProps..'&app=objects \n **Mwojtasik:** https://mwojtasik.dev/tools/gtav/objects/search?name='..blacklistedProps)
                    TriggerClientEvent('rwe:antiProp', -1)
                    TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
                    CancelEvent()
                    return
                end
            end
        elseif model == 2 then
            for _, blacklistedVeh in pairs(Config.AntiNukeBlacklistedVehicles) do
                if model == blacklistedVeh then
                    webhookualdimgonderdim('Spawned Blacklist Vehicle: '..blacklistedVeh..'\n **Vehicle: ** https://www.gtabase.com/search?searchword='..blacklistedVeh)
                    TriggerClientEvent('rwe:AntiVehicle', -1)
                    TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
                    CancelEvent()
                    return
                end
            end
        elseif model == 1 then
            for _, blacklistedPed in pairs(Config.AntiNukeBlacklistedPeds) do
                if model == blacklistedPed then
                    webhookualdimgonderdim('Yasaklanan Ped Spawnlandı Pedin adı: '..blacklistedPed..'\n **Pedin Resmi:** https://docs.fivem.net/peds/'..blacklistedPed..'.png')
                    TriggerClientEvent('rwe:antiPed', -1)
                    TriggerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
                    CancelEvent()
                    return
                end
            end
        end
    end
end)