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
if Config.AntiSpectates then
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
end
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

if Config.BasicEnable then
    local _evhandler = AddEventHandler
    Citizen.CreateThread(function()
        resources = GetNumResources()
        local _onresstarting = "onResourceStarting"
        local _onresstart = "onResourceStart"
        local _onclresstart = "onClientResourceStart"
        Citizen.Wait(30000)
        local _originalped = GetEntityModel(PlayerPedId())
        DisplayRadar(false)
        _evhandler(_onresstarting, function(res)
            if res ~= GetCurrentResourceName() then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "resourcestarted", res) 
            end
        end)
        _evhandler(_onresstart, function(res)
            if res ~= GetCurrentResourceName() then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "resourcestarted", res) 
            end
        end)
        _evhandler(_onclresstart, function(res)
            if res ~= GetCurrentResourceName() then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "resourcestarted", res) 
            end
        end)
        while true do
            Citizen.Wait(0)
            local _ped = PlayerPedId()
            local _pid = PlayerId()
            local _Wait = Citizen.Wait
            SetRunSprintMultiplierForPlayer(_pid, 1.0)
            SetSwimMultiplierForPlayer(_pid, 1.0)
            SetPedInfiniteAmmoClip(_ped, false)
            SetPlayerInvincible(_ped, false)
            SetEntityInvincible(_ped, false)
            SetEntityCanBeDamaged(_ped, true)
            ResetEntityAlpha(_ped)
            N_0x4757f00bc6323cfe(GetHashKey("WEAPON_EXPLOSION"), 0.0)
            if Config.AntiExplosionDamage then
                SetEntityProofs(_ped, false, true, true, false, false, false, false, false)
            end
            _Wait(100)
            if Config.AntiAimAssist then
                SetPlayerTargetingMode(0)
            end
            _Wait(300)
            if Config.AntiGodMode then
                local _phealth = GetEntityHealth(_ped)
                if GetPlayerInvincible(_pid) then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "godmode", "4") 
                    SetPlayerInvincible(_pid, false)
                end
                SetEntityHealth(_ped,  _phealth - 2)
                _Wait(10)
                if not IsPlayerDead(_pid) then
                    if GetEntityHealth(_ped) == _phealth and GetEntityHealth(_ped) ~= 0 then
                        TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "godmode", "1") --
                    elseif GetEntityHealth(_ped) == _phealth - 2 then
                        SetEntityHealth(_ped, GetEntityHealth(_ped) + 2)
                    end
                end
                _Wait(100)
                if GetEntityHealth(_ped) > 200 then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "godmode", "2") 
                end
                _Wait(100)
                local _val, _bulletproof, _fireproof , _explosionproof , _collisionproof , _meleeproof, _steamproof, _p7, _drownProof = GetEntityProofs(_ped)
                if _bulletproof == 1 or _collisionproof == 1 or _meleeproof == 1 or _steamproof == 1 or _drownProof == 1 then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "godmode", "3")
                end
                _Wait(300)
            end
            if Config.AntiInfiniteStamina then
                if GetEntitySpeed(_ped) > 7 and not IsPedInAnyVehicle(_ped, true) and not IsPedFalling(_ped) and not IsPedInParachuteFreeFall(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsPedRagdoll(_ped) then
                    local _staminalevel = GetPlayerSprintStaminaRemaining(_pid)
                    if tonumber(_staminalevel) == tonumber(0.0) then
                        TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "infinitestamina") 
                    end
                end
            end
            if Config.AntiRagdoll then
                if not CanPedRagdoll(_ped) and not IsPedInAnyVehicle(_ped, true) and not IsEntityDead(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsPedJacking(_ped) then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "antiragdoll") 
                end
                _Wait(300)
            end
            if Config.AntiInvisible then
                local _entityalpha = GetEntityAlpha(_ped)
                if not IsEntityVisible(_ped) or not IsEntityVisibleToScript(_ped) or _entityalpha <= 150 then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "invisible") 
                end
                _Wait(300)
            end
            if Config.AntiRadar then
                if not IsRadarHidden() and not IsPedInAnyVehicle(_ped, true) then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "displayradar") 
                end
                _Wait(300)
            end
            if Config.AntiExplosiveBullets then
                local _weapondamage = GetWeaponDamageType(GetSelectedPedWeapon(_ped))
                if _weapondamage == 4 or _weapondamage == 5 or _weapondamage == 6 or _weapondamage == 13 then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "explosiveweapon")
                end
                _Wait(300)
            end
            if Config.AntiSpectate then
                if NetworkIsInSpectatorMode() then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "spectatormode")
                end
                _Wait(300)
            end
            if Config.AntiSpeedHacks then
                if not IsPedInAnyVehicle(_ped, true) and GetEntitySpeed(_ped) > 10 and not IsPedFalling(_ped) and not IsPedInParachuteFreeFall(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsPedRagdoll(_ped) then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "speedhack") 
                end
                _Wait(300)
            end
            if Config.AntiBlacklistedWeapons then
                for _,_weapon in ipairs(Config.BlacklistedWeapons) do
                    if HasPedGotWeapon(_ped, GetHashKey(_weapon), false) then
                        RemoveAllPedWeapons(_ped, true)
                        TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "blacklistedweapons") 
                    end
                    _Wait(1)
                end
                _Wait(300)
            end
            if Config.AntiThermalVision then
                if GetUsingseethrough() then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "thermalvision") 
                end
                _Wait(300)
            end
            if Config.AntiNightVision then
                if GetUsingnightvision() then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "nightvision")
                end
                _Wait(300)
            end
            if Config.AntiResourceStartorStop then 
                local _nres = GetNumResources()
                if resources -1 ~= _nres -1 or resources ~= _nres then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "antiresourcestop")
                end
                _Wait(300)
            end
            if Config.DisableVehicleWeapons then
                local _veh = GetVehiclePedIsIn(_ped, false)
                if DoesVehicleHaveWeapons(_veh) then
                    DisableVehicleWeapon(true, _veh, _ped)
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "vehicleweapons")
                end
            end
            if Config.AntiPedChange then
                if _originalped ~= GetEntityModel(_ped) then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "pedchanged")
                end
                _Wait(300)
            end
            if Config.AntiFreeCam then
                local camcoords = (GetEntityCoords(_ped) - GetFinalRenderedCamCoord())
                if (camcoords.x > 9) or (camcoords.y > 9) or (camcoords.z > 9) or (camcoords.x < -9) or (camcoords.y < -9) or (camcoords.z < -9) then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "freecam") 
                end
                _Wait(300)
            end
            if Config.AntiMenyoo then
                if IsPlayerCamControlDisabled() ~= false then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "menyoo") 
                end
                _Wait(300)
            end
            if Config.AntiGiveArmor then
                local _armor = GetPedArmour(_ped)
                if _armor > 100 then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "givearmour") 
                end
                _Wait(300)
            end
            if Config.AntiAimAssist then
                local _aimassiststatus = GetLocalPlayerAimState()
                if _aimassiststatus ~= 3 and not IsPedInAnyVehicle(_ped, true) then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "aimassist", _aimassiststatus) 
                end
                _Wait(300)
            end
            if Config.SuperJump then
               _Wait(810)
                if IsPedJumping(PlayerPedId()) then
                    TriggerServerEvent('8jWpZudyvjkDXQ2RVXf9', "superjump")
                end
            end
        end
    end)
end

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
