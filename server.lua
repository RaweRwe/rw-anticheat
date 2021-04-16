ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

WebhookLink = ""

local name = GetPlayerName(source)

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
   local src = source
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
   webhookualdimgonderdim("Kişi patlayıcı spawnladı  "  ..name(sender))
      CancelEvent()
   -- end
end)
-----
AddEventHandler('entityCreating', function(entity)
  local src = NetworkGetEntityOwner(entity)
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
	TriggerEvent('rwe:siktirgitkoyunekrds', 'Kardeşim Napıyorsun Öyle')
   webhookualdimgonderdim("Hileci Chate mesaj göndermeye çalıştı : "..name)
end)
-----
RegisterServerEvent('rwe:WeaponFlag')
AddEventHandler('rwe:WeaponFlag', function(weapon)
	local license, steam = GetPlayerNeededIdentifiers(source)

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
               webhookualdimgonderdim("Event Yakalandı : "..name.. " Triggerlanan Event: **YAKINDA** ")
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
