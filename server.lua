ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

WebhookLink = ""

---- Script isim kontrolü
local onaylandi = false
Citizen.CreateThread(function()
   while true do
      local rwe = GetCurrentResourceName()
        if rwe == 'rwe-anticheat' then
            print('rwe')
            onaylandi = true
        if onaylandi == true then
            Citizen.Wait(1000)
            break
        else
            print('^3scriptin ismini degistirmeyin.^0')
            Citizen.Wait(5000)
            os.exit()
            Citizen.Wait(2500)
            os.exit()
            Citizen.Wait(50000)
        end
      end
   end
end)
-------
RegisterServerEvent("rwe:siktirgitkoyunekrds")
AddEventHandler("rwe:siktirgitkoyunekrds", function(reason)
   local identifier = GetPlayerIdentifiers(src)[1]

   for k, v in pairs(Config.PlayerWhitelist) do
      if v == identifier then
         return
      end
   end
	DropPlayer(source, reason)	
end)
-------
RegisterServerEvent("rwe:cheatlog")
AddEventHandler("rwe:cheatlog", function(reason)
  local _source = source
      local connect = {
            {
                ["color"] = 23295,
                ["title"] = reason,
                ["description"] = "Kullanıcı: "..GetPlayerName(_source).. " "  ..GetPlayerIdentifiers(_source)[1].."  ",
                ["footer"] = {
                ["text"] = "Coded By RAWE",
                },
            }
        }
    PerformHttpRequest(WebhookLink, function(err, text, headers) end, 'POST', json.encode({username = "RWE", embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end)
-------------
RegisterServerEvent("imgToDiscord")
AddEventHandler("imgToDiscord", function(img)
    -- img, foto url oluyor
  PerformHttpRequest(WebhookLink, function(err, text, headers) end, 'POST', json.encode({username = "RWE", content = img}), { ['Content-Type'] = 'application/json' })
end)

function webhookualdimgonderdim(content)
   local _source = source
         local connect = {
        {
            ["color"] = "23295",
            ["title"] = "Rawe AntiCheat",
            ["description"] = "Kullanıcı: "..GetPlayerName(_source).. " "  ..GetPlayerIdentifiers(_source)[1].."", content,
            ["footer"] = {
            ["text"] = "Coded By RAWE",
            },
        }
    }
  PerformHttpRequest(WebhookLink, function(err, text, headers) end, 'POST', json.encode({username = "RWE ANTICHEAT", embeds = connect}), { ['Content-Type'] = 'application/json' })
end

---------
-- local cd = 0
AddEventHandler('explosionEvent', function(sender)
    local name = GetPlayerName(source)
    webhookualdimgonderdim("Kişi patlayıcı spawnladı  "  ..name(sender))
    CancelEvent()
   -- end
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
        webhookualdimgonderdim("Kişi obje spawnladı İsim : "..name.. "Obje hash : "..model)
        CancelEvent()
    else
        TriggerEvent("rwe:cheatlog", "Yasaklı Obje Tespit Edildi : "..GetPlayerName(src).. "Obje : "..model)
        TriggerEvent("rwe:siktirgitkoyunekrds", "Obje tespit edildi : "..model)
    end
end)
-----
RegisterNetEvent('chat:server:ServerPSA')
AddEventHandler('chat:server:ServerPSA', function()
	local _source = source
    local name = GetPlayerName(source)
	TriggerEvent('rwe:siktirgitkoyunekrds', 'Kardeşim Napıyorsun Öyle')
    webhookualdimgonderdim("Hileci Chate mesaj göndermeye çalıştı : "..name)
end)
-----
RegisterServerEvent('rwe:WeaponFlag')
AddEventHandler('rwe:WeaponFlag', function(weapon)
	local license, steam = GetPlayerNeededIdentifiers(source)
    local name = GetPlayerName(source)

    webhookualdimgonderdim("Kişi kendisine silah verdi İsim : "..name.. "Silah : "..weapon)
	TriggerClientEvent("rwe:RemoveInventoryWeapons", source) 
end)
-----
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
      if model == GetHashKey(objName.name) then
         TriggerClientEvent("rwe:DeleteCars", -1,entID)
         Citizen.Wait(800)
            webhookualdimgonderdim("Yasaklı Araç","**-Oyuncu: **"..SpawnerName.."\n\n**-Obje Adı: **"..objName.name.."\n\n**-Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash,15105570)
         TriggerEvent("rwe:siktirgitkoyunekrds", "Yasaklı araç tespit edildi.")
      end
   end
end

if Config.AntiSpawnPeds then
   for i, objName in ipairs(Config.AntiNukeBlacklistedPeds) do
      if model == GetHashKey(objName.name) then
         TriggerClientEvent("rwe:DeletePeds", -1, entID)
         Citizen.Wait(800)
            webhookualdimgonderdim("Yasaklı PED","**-Oyuncu: **"..SpawnerName.."\n\n**-Obje Adı: **"..objName.name.."\n\n**-Nesne Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash,15105570)
          end
          TriggerEvent("rwe:siktirgitkoyunekrds", "Yasaklı araç tespit edildi.")
        break
      end
   end
end)

if Config.AntiNuke then
   for i, objName in ipairs(Config.AntiNukeBlacklistedObjects) do
      if model == GetHashKey(objName) then
         TriggerClientEvent("rwe:DeleteEntity", -1, entID)
         Citizen.Wait(800)
            webhookualdimgonderdim("Yasaklı Obje","**-Spawner Name: **"..SpawnerName.."\n\n**-Object Name: **"..objName.name.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash,15105570)
        break
      end
   end
end
------
Citizen.CreateThread(function()
    for k, v in pairs(Config.Events) do
        if Config.EventsDetect then
            RegisterServerEvent(tostring(v))
            AddEventHandler(tostring(v), function()
               local src = source
               local name = GetPlayerName(source)
               webhookualdimgonderdim("Event Yakalandı : "..name.. " Triggerlanan Event: " ..v)
            end)
        end
    end
end)
------
AddEventHandler('chatMessage', function(source, color, message)
    if not message then
        return
    end

    local src = source

    for k, v in pairs(Config.BlacklistKelime) do
        if string.match(message, v) then
               
               webhookualdimgonderdim('Chate blacklist mesaj yolladı! Mesaj: '..v)
               Citizen.Wait(1500)
               TriggerEvent("rwe:siktirgitkoyunekrds", "Blacklist Kelime Tespit Edildi.")

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
    local name = GetPlayerName(source)

    for k, v in pairs(Config.BlacklistKelime) do
        if string.match(message, v) then
            webhookualdimgonderdim('Blacklist Kelime Tespit Edildi! Kelime: '..v.. 'Kişi : '..name)
            CancelEvent()
            Citizen.Wait(1500)
            TriggerEvent("rwe:siktirgitkoyunekrds", "Blacklist Kelime Tespit Edildi.")
        end
      return
    end
end)
------
Citizen.CreateThread(function()
    for i=1, #Config.BlacklistedCommands, 1 do
        RegisterCommand(Config.BlacklistedCommands[i], function(source)
            local src = source
            local name = GetPlayerName(source)
            webhookualdimgonderdim("Blacklist Komut Yakalandı : " ..name .. "Kullanılan Komut" ..Config.BlacklistedCommands[i])
            TriggerEvent("rwe:siktirgitkoyunekrds", 'Blacklist komut kullandı! Komut: **/' .. Config.BlacklistedCommands[i]..'**')
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
    TriggerClientEvent("rwe:Entityyoketsikerim", -1, tonumber(target))
end

local validResourceList
local function collectValidResourceList()
    validResourceList = {}
    for i = 0, GetNumResources() - 1 do
        validResourceList[GetResourceByFindIndex(i)] = true
    end
end
collectValidResourceList()

AddEventHandler("onResourceListRefresh", collectValidResourceList)
RegisterNetEvent("rwe:dosyalarikontrolet")
AddEventHandler("rwe:dosyalarikontrolet", function(givenList)
    local source = source
    Wait(500)
    for _, resource in ipairs(givenList) do
        if not validResourceList[resource] then
            TriggerEvent("rwe:siktirgitkoyunekrds", "asdasd")
        end
    end
end)

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

AddEventHandler("playerConnecting", function(playerName, setKickReason)
    playerName = (string.gsub(string.gsub(string.gsub(playerName,  "-", ""), ",", ""), " ", ""):lower())
    for k, v in pairs(unauthNames) do
      local g, f = playerName:find(string.lower(v))
      if g or f  then
        table.insert (x, v)
        local blresult = table.concat(x, " ")
          setKickReason('BlackList İsim Tespit Edildi')
          TriggerEvent("rwe:cheatlog", "BlackList İsim Tespit Edildi  Oyuncu: " ..GetPlayerName(source))
          CancelEvent()
          for key in pairs (x) do
            x [key] = nil
        end
      end
    end
end)

----- EntityCreated farklı bi version
AddEventHandler('entityCreated', function(entity)
    if DoesEntityExist(entity) then
        if GetEntityType(entity) == 3 then
            for _, blacklistedProps in pairs(Config.AntiNukeBlacklistedObjects) do
                if GetEntityModel(entity) == GetHashKey(blacklistedProps) then
                    local src = NetworkGetEntityOwner(entity)
                    local xPlayer = ESX.GetPlayerFromId(src)
                        webhookualdimgonderdim('Blacklistli Prop Çıkartıldı Prop: '..blacklistedProps..'\n**Prop:** https://plebmasters.de/?search='..blacklistedProps..'&app=objects \n**Google:** https://www.google.com/search?q='..blacklistedProps..' \n **Mwojtasik:** https://mwojtasik.dev/tools/gtav/objects/search?name='..blacklistedProps)
                    TriggerClientEvent('rwe:antiProp', -1)
                    CancelEvent()
                    return
                end
            end
        elseif GetEntityType(entity) == 2 then
            for _, blacklistedVeh in pairs(Config.AntiNukeBlacklistedVehicles) do
                if GetEntityModel(entity) == GetHashKey(blacklistedVeh) then
                    local src = NetworkGetEntityOwner(entity)
                    local xPlayer = ESX.GetPlayerFromId(src)
                        webhookualdimgonderdim('Yasaklanan Araç Spawnlandı: '..blacklistedVeh..'\n **Çıkarmaya Çalıştığı araç:** https://www.gtabase.com/search?searchword='..blacklistedVeh)
                    TriggerClientEvent('rwe:AntiVehicle', -1)
                    CancelEvent()
                    return
                end
            end
        elseif GetEntityType(entity) == 1 then
            for _, blacklistedPed in pairs(Config.AntiNukeBlacklistedPeds) do
                if GetEntityModel(entity) == GetHashKey(blacklistedPed) then
                    local src = NetworkGetEntityOwner(entity)
                    local xPlayer = ESX.GetPlayerFromId(src)
                        webhookualdimgonderdim('Yasaklanan Ped Spawnlandı Pedin adı: '..blacklistedPed..'\n **Pedin Resmi:** https://docs.fivem.net/peds/'..blacklistedPed..'.png')
                    TriggerClientEvent('rwe:antiPed', -1)
                    CancelEvent()
                    return
                end
            end
        end
    end
end)
