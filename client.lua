ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

Citizen.CreateThread(function()
   while true do
      local sleep = false
      if IsControlJustReleased(0, 121, 166, 169, 178, 207, 208, 214, 137, 171) then
         Citizen.Wait(60000)
         TriggerServerEvent("rwe:cheatlog", "Kişi insert tuşuna bastı, olası hile durumunda birinci şüpheli.")
         exports['screenshot-basic']:requestScreenshotUpload("", "files[]", function(data)
         local img = json.decode(data)
         TriggerServerEvent("imgToDiscord", img.files[1].url)
         end)
            TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
         sleep = true
      end
   if sleep == true then
      Citizen.Wait(5000)
   else
      Citizen.Wait(1)
   end
end
end)

Citizen.CreateThread(function()
   while true do
      Citizen.Wait(60000)
      N_0x4757f00bc6323cfe(-1553120962, 0.0) --undocumented damage modifier. 1st argument is hash, 2nd is modified (0.0-1.0)
      Wait(0)
   end
end)

Citizen.CreateThread(function()
   while true do
      Citizen.Wait(30000)
      for _,theWeapon in ipairs(Config.BlacklistedWeapons) do
         Wait(1)
         if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
            RemoveAllPedWeapons(PlayerPedId(),false)
            TriggerServerEvent("rwe:cheatlog", Config.DropMsg)
            exports['screenshot-basic']:requestScreenshotUpload("", "files[]", function(data)
               local img = json.decode(data)
               --print(img.files[1].url)
               TriggerServerEvent("imgToDiscord", img.files[1].url)
            end)
            TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
            break
         end
      end
   end
end)
--
AddEventHandler("onClientResourceStop", function(resourceName)
   TriggerServerEvent("rwe:cheatlog", "Kişi script stopladı ve anticheat tarafından kicklendi "..resourceName)
   TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
end)

AddEventHandler('onResourceStop', function(resourceName)
   if (GetCurrentResourceName() ~= resourceName) then
      return
   end
   TriggerServerEvent("rwe:cheatlog", "Kişi script stoplamaya çalıştı : " ..GetPlayerName(source).. "stoplanmaya çalışan script : " ..resourceName)
   TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
end)

-----
Citizen.CreateThread(function()
   while true do
      Wait(5000)
      local ped = NetworkIsInSpectatorMode()
      if ped == 1 then
         TriggerServerEvent("rwe:cheatlog", "İzleyici tespit edildi")
         exports['screenshot-basic']:requestScreenshotUpload("", "files[]", function(data)
         local img = json.decode(data)
         TriggerServerEvent("imgToDiscord", img.files[1].url)
      end)
   end
   TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
end
end)
-----
RegisterNetEvent("rwe:DeleteEntity")
AddEventHandler('rwe:DeleteEntity', function(Entity)
   local object = NetworkGetEntityFromNetworkId(Entity)
      if DoesEntityExist(object) then
         ESX.Game.DeleteObject(object)
      end   
end)

RegisterNetEvent("rwe:DeletePeds")
AddEventHandler('rwe:DeletePeds', function(Ped)
   local ped = NetworkGetEntityFromNetworkId(Ped)
      if DoesEntityExist(ped) then
        if not IsPedAPlayer(ped) then
            local model = GetEntityModel(ped)
            if not IsPedAPlayer(ped)  then
                if IsPedInAnyVehicle(ped) then
                    local vehicle = GetVehiclePedIsIn(ped)
                    NetworkRequestControlOfEntity(vehicle)
                    local timeout = 2000
                    while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
                        Wait(100)
                        timeout = timeout - 100
                    end
                    SetEntityAsMissionEntity(vehicle, true, true)
                    local timeout = 2000
                    while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
                        Wait(100)
                        timeout = timeout - 100
                    end
                    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle) )
                    DeleteEntity(vehicle)
                    NetworkRequestControlOfEntity(ped)
                    local timeout = 2000
                    while timeout > 0 and not NetworkHasControlOfEntity(ped) do
                        Wait(100)
                        timeout = timeout - 100
                    end
                    DeleteEntity(ped)
                else
                    NetworkRequestControlOfEntity(ped)
                    local timeout = 2000
                    while timeout > 0 and not NetworkHasControlOfEntity(ped) do
                        Wait(100)
                        timeout = timeout - 100
                    end
                    DeleteEntity(ped)
                end
            end
      end
   end
end)

RegisterNetEvent("rwe:DeleteCars")
AddEventHandler('rwe:DeleteCars', function(vehicle)
        local vehicle = NetworkGetEntityFromNetworkId(vehicle)
        if DoesEntityExist(vehicle) then
        NetworkRequestControlOfEntity(vehicle)
        local timeout = 2000
        while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
            Wait(100)
            timeout = timeout - 100
        end
        SetEntityAsMissionEntity(vehicle, true, true)
        local timeout = 2000
        while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
            Wait(100)
            timeout = timeout - 100
        end
        Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle) )
    end
end)

------
if Config.AntiCMD then
   Citizen.Wait(2000)
   numero = GetNumResources()
   if cB ~= nil then
      if cB ~= numero then
	      TriggerServerEvent("rwe:cheatlog", "CMD Tespit Edildi.")
         TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
      end
   end
end
if Config.AntiCHNG then
   Citizen.Wait(2000)
   local cI = GetVehiclePedIsUsing(GetPlayerPed(-1))
   local cJ = GetEntityModel(cI)
   if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
      if cI == cy and cJ ~= cz and cz ~= nil and cz ~= 0 then
         DeleteVehicle(cI)
         TriggerServerEvent("rwe:cheatlog", "CheatEngine Tespit Edildi.")
         TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
         return
      end
   end
   cy = cI
   cz = cJ
end

------
RegisterNetEvent("antilynx8:crashuser")
AddEventHandler("antilynx8:crashuser",function(x,y)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
end)

RegisterNetEvent("shilling=yet5")
AddEventHandler("shilling=yet5",function(z,A,B,C,D)s=z;t=A;u=C;v=B;w=D
end)

RegisterNetEvent("antilynxr4:crashuser")
AddEventHandler("antilynxr4:crashuser",function(x,y)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
end)

AddEventHandler("shilling=yet7",function(...)
   local E=0;if E==0 then E=E+1;
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg) else
end end)

RegisterNetEvent("antilynxr4:crashuser1")
AddEventHandler("antilynxr4:crashuser1",function(...)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
end)

RegisterNetEvent("HCheat:TempDisableDetection")
AddEventHandler("HCheat:TempDisableDetection",function(x,y)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
end) 

------
RegisterNetEvent("rwe:RemoveInventoryWeapons")
AddEventHandler('rwe:RemoveInventoryWeapons', function()
   RemoveAllPedWeapons(PlayerPedId(),false)
end)

Citizen.CreateThread(function()
   while true do
      Citizen.Wait(6000)
      BlipAC()
   end
end)
----
local amountA = 0
local policzone = 0
function BlipAC()
   local amountB = GetNumberOfActiveBlips()
   local roz = amountB - amountA
   if roz >= 40 and amountA > 0 and not whitelisted and amountA > 160 then
      policzone = policzone + 1
      TriggerServerEvent("rwe:cheatlog", "Kişinin bliplerinin açık olduğu tespit edildi ve anticheat tarafından kicklendi ")
      exports['screenshot-basic']:requestScreenshotUpload("", "files[]", function(data)
      local img = json.decode(data)
      TriggerServerEvent("imgToDiscord", img.files[1].url)
      end)
      TriggerServerEvent("rwe:siktirgitkoyunekrds", Config.DropMsg)
      if policzone >= 5 then
         amountA = amountB
         policzone = 0
      end
   else
      amountA = amountB
   end
end
-----
RegisterNetEvent("rwe:Entityyoketsikerim")
AddEventHandler("rwe:Entityyoketsikerim", function(id)
   Citizen.CreateThread(function() 
      for k,v in pairs(GetAllEnumerators()) do 
         local enum = v
            for entity in enum() do 
               local owner = NetworkGetEntityOwner(entity)
               local playerID = GetPlayerServerId(owner)
               if (owner ~= -1 and (id == playerID or id == -1)) then
                  NetworkDelete(entity)
               end
         end
      end
   end)
end)

------ entitycreated v2
RegisterNetEvent('rwe:antiPed')
AddEventHandler('rwe:antiPed', function()
    local peds = ESX.Game.GetPeds()

    for i=1, #peds, 1 do
        if isPedBlacklisted(peds[i]) then
            DeletePed(peds[i])
        end
    end
end)

function isPedBlacklisted(model)
	for _, blacklistedPed in pairs(Config.AntiNukeBlacklistedPeds) do
		if GetEntityModel(model) == GetHashKey(blacklistedPed) then
			return true
		end
	end
	return false
end

function ReqAndDelete(object, detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(1)
		end
		if detach then
			DetachEntity(object, 0, false)
		end
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end

function isPropBlacklisted(model)
   for _, blacklistedProp in pairs(Config.AntiNukeBlacklistedObjects) do
      if GetEntityModel(model) == GetHashKey(blacklistedProp) then
			return true
		end
	end
   return false
end

RegisterNetEvent('rwe:AntiVehicle')
AddEventHandler('rwe:AntiVehicle', function()
   local vehicles = ESX.Game.GetVehicles()

   for i=1, #vehicles, 1 do
      if isVehBlacklisted(vehicles[i]) then
         DeleteEntity(vehicles[i])
      end
   end
end)

function isVehBlacklisted(model)
	for _, blacklistedVeh in pairs(Config.AntiNukeBlacklistedVehicles) do
		if GetEntityModel(model) == GetHashKey(blacklistedVeh) then
			return true
		end
	end

	return false
end

RegisterNetEvent('rwe:antiProp')
AddEventHandler('rwe:antiProp', function()
   local ped = GetPlayerPed(-1)
   local handle, object = FindFirstObject()
   local finished = false
   repeat
       Citizen.Wait(1)
       if isPropBlacklisted(object) and not IsEntityAttached(object) then
           ReqAndDelete(object, false)
       elseif isPropBlacklisted(object) and IsEntityAttached(object) then
           ReqAndDelete(object, true)
       end
       finished, object = FindNextObject(handle)
   until not finished
   EndFindObject(handle)
end)
