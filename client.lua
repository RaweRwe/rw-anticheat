ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local resources

if Config.AntiBlacklistedKey then
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- if this do crash change 0 to 1000
        local _src = source
        for k, v in pairs(Config.BlacklistedKeys) do
            if IsControlJustReleased(0, v) then
                kickorbancheater(_src,"Blacklist Key Detected", "Blacklist Key Detected",true,true)
            end
        end
    end
end)
end

Citizen.CreateThread(function()
    while true do
        local _src = source
        Citizen.Wait(30000)
        for _, theWeapon in ipairs(Config.BlacklistedWeapons) do
            Wait(1)
            if HasPedGotWeapon(PlayerPedId(),theWeapon,false) == 1 then
                RemoveAllPedWeapons(PlayerPedId(),false)
                kickorbancheater(_src,"Blacklist Weapon Detected", "Blacklist Weapon Detected",true,true)
            break
            end
        end
    end
end)
--
AddEventHandler("onClientResourceStop", function(resourceName)
    local _src = source
    kickorbancheater(_src,"Stop Resource Detected", "This Player tried to stop resource: "..resourceName,true,true)
end)

AddEventHandler('onResourceStop', function(resourceName)
    local _src = source
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    kickorbancheater(_src,"Stop Resource Detected", "This Player tried to stop resource: "..resourceName,true,true)
end)

-----
RegisterNetEvent("rwe:DeleteEntity")
AddEventHandler('rwe:DeleteEntity', function(Entity)
    local object = NetworkGetEntityFromNetworkId(Entity)
        if DoesEntityExist(object) then
            DeleteObject(object)
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
        local _stopdetect = RW_AC
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
                    if HasPedGotWeapon(_ped, _weapon, false) then
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
                if not IsPedInAnyVehicle(_ped) or IsPedInAnyTaxi(_ped) or IsPedInAnyPoliceVehicle(_ped) or IsPedOnAnyBike(_ped) or IsPedInAnyBoat(_ped) or IsPedInAnyHeli(_ped) or IsPedInAnyPlane(_ped) then
                    local camcoords = (GetEntityCoords(_ped) - GetFinalRenderedCamCoord())
                    if (camcoords.x > 9) or (camcoords.y > 9) or (camcoords.z > 9) or (camcoords.x < -9) or (camcoords.y < -9) or (camcoords.z < -9) then
                        TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "freecam") 
                    end
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
            if Config.AntiBlacklistedTasks then
                for _,task in pairs(Config.BlacklistedTasks) do
                    if GetIsTaskActive(_ped, task) then
                        TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "blacklistedtask", task)
                    end
                end
                _Wait(100)
            end
            if Config.AntiBlacklistedAnims then
                for _,anim in pairs(Config.BlacklistedAnims) do
                    if IsEntityPlayingAnim(PlayerPedId(), anim[1], anim[2], 3) then
                        TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "blacklistedanim", json.encode(anim))
                        ClearPedTasksImmediately(_ped)
                        ClearPedTasks(_ped)
                        ClearPedSecondaryTask(_ped)
                    end
                end
                _Wait(100)
            end
        end
    end)
end

------
Citizen.CreateThread(function()
    while Config.AntiCHNG do
        Citizen.Wait(2000)
        local _src = source
        local cI = GetVehiclePedIsUsing(PlayerPedId())
        local cJ = GetEntityModel(cI)
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            if cI == cy and cJ ~= cz and cz ~= nil and cz ~= 0 then
                DeleteVehicle(cI)
                kickorbancheater(_src,"Cheat Engine Detected", "Cheat Engine Detected",true,true)
                return
            end
        end
    cy = cI
    cz = cJ
    end
end)

------
RegisterNetEvent("antilynx8:crashuser")
AddEventHandler("antilynx8:crashuser",function(x,y)
    local _src = source
    kickorbancheater(_src,"Hack Detected", "Hack Detected",true,true)
end)

RegisterNetEvent("shilling=yet5")
AddEventHandler("shilling=yet5",function(z,A,B,C,D)s=z;t=A;u=C;v=B;w=D
    local _src = source
    kickorbancheater(_src,"Hack Detected", "Hack Detected",true,true)
end)

RegisterNetEvent("antilynxr4:crashuser")
AddEventHandler("antilynxr4:crashuser",function(x,y)
    local _src = source
    kickorbancheater(_src,"Hack Detected", "Hack Detected",true,true)
end)

AddEventHandler("shilling=yet7",function(...)
    local E=0;if E==0 then E=E+1;
    local _src = source
    kickorbancheater(_src,"Hack Detected", "Hack Detected",true,true) else
end end)

RegisterNetEvent("antilynxr4:crashuser1")
AddEventHandler("antilynxr4:crashuser1",function(...)
    local _src = source
    kickorbancheater(_src,"Hack Detected", "Hack Detected",true,true)
end)

RegisterNetEvent("HCheat:TempDisableDetection")
AddEventHandler("HCheat:TempDisableDetection",function(x,y)
    local _src = source
    kickorbancheater(_src,"Hack Detected", "Hack Detected",true,true)
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
    local _src = source
    
    local amountB = GetNumberOfActiveBlips()
    local roz = amountB - amountA
    if roz >= 40 and amountA > 0 and not whitelisted and amountA > 160 then
        policzone = policzone + 1
        kickorbancheater(_src,"Hack Detected", "Hack Detected",true,true)
        if policzone >= 5 then
            amountA = amountB
            policzone = 0
        end
    else
        amountA = amountB
    end
end
-----
RegisterNetEvent("rwe:deletentity")
AddEventHandler("rwe:deletentity", function(id)
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
	for _, blacklistedPed in pairs(Config.BlacklistedPeds) do
		if GetEntityModel(model) == blacklistedPed then
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
   for _, blacklistedProp in pairs(Config.BlacklistedObjects) do
      if GetEntityModel(model) == blacklistedProp then
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
	for _, blacklistedVeh in pairs(Config.BlacklistedVehicles) do
		if GetEntityModel(model) == blacklistedVeh then
			return true
		end
	end
	return false
end

RegisterNetEvent('rwe:antiProp')
AddEventHandler('rwe:antiProp', function()
    local ped = PlayerPedId()
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

-----

arabadanatladi = load
amipatladi = type

Citizen.CreateThread(function()
    local kesulan = load
    local _src = source
        if amipatladi(kesulan) == "function" and arabadanatladi == kesulan then
            while true do
                Citizen.Wait(3000)
                if kesulan ~= load then
                    kickorbancheater(_src,"Bypass Detected", "Bypass Detected",true,true)
                end
                if amipatladi(kesulan("return debug")) ~= "function" then
                    kickorbancheater(_src,"Bypass Detected", "Bypass Detected",true,true)
                end
                if arabadanatladi("return debug")() == nil then
                    kickorbancheater(_src,"Bypass Detected", "Bypass Detected",true,true)
                end
                if amipatladi(load) == "nil" then
                    kickorbancheater(_src,"Bypass Detected", "Bypass Detected",true,true)                        
                end
            end
        else
            kickorbancheater(_src,"Bypass Detected", "Bypass Detected",true,true)
        end
end)

------

Citizen.CreateThread(function()
    if Config.AntiVDM then
        if IsInVehicle and GetPedInVehicleSeat(GetVehiclePedIsIn(Ped, 0), -1) == PlayerPedId() then
            local Vehicle = GetVehiclePedIsIn(Ped, 0)
            local _Wait = Citizen.Wait
            local _src = source
            if GetPlayerVehicleDamageModifier(PlayerId()) > 1.0 then
                kickorbancheater(_src,"Vehicle UltraSpeed Detected", "Vehicle UltraSpeed Detected",true,true)
                _Wait(100000)
            end
            if GetVehicleGravityAmount(Vehicle) > 30.0 then
                kickorbancheater(_src,"Vehicle UltraSpeed Detected", "Vehicle UltraSpeed Detected",true,true)
                _Wait(100000)
            end
            if GetVehicleCheatPowerIncrease(Vehicle) > 10.0 then
                kickorbancheater(_src,"Vehicle UltraSpeed Detected", "Vehicle UltraSpeed Detected",true,true)
                _Wait(100000)
            end
            if GetVehicleTopSpeedModifier(Vehicle) > 200.0 then
                kickorbancheater(_src,"Vehicle UltraSpeed Detected", "Vehicle UltraSpeed Detected",true,true)
                _Wait(100000)
            end
            if GetPlayerVehicleDefenseModifier(Vehicle) > 10.0 then
                kickorbancheater(_src,"Vehicle UltraSpeed Detected", "Vehicle UltraSpeed Detected",true,true)
                _Wait(100000)
            end
        end
    end
end)

-- AntiMenu

local funsionesAComprobar = {
    { "TriggerCustomEvent" },
    { "GetResources" },
    { "IsResourceInstalled" },
    { "ShootPlayer" },
    { "FirePlayer" },
    { "MaxOut" },
    { "Clean2" },
    { "TSE" },
    { "TesticleFunction" },
    { "rape" },
    { "ShowInfo" },
    { "checkValidVehicleExtras" },
    { "vrpdestroy" },
    { "esxdestroyv2" },
    { "ch" },
    { "Oscillate" },
    { "GetAllPeds" },
    { "forcetick" },
    { "ApplyShockwave" },
    { "GetCoordsInfrontOfEntityWithDistance" },
    { "TeleporterinoPlayer" },
    { "GetCamDirFromScreenCenter" },
    { "DrawText3D2" },
    { "WorldToScreenRel" },
    { "DoesVehicleHaveExtras" },
    { "nukeserver" },
    { "SpawnWeaponMenu" },
    { "esxdestroyv3" },
    { "hweed" },
    { "tweed" },
    { "sweed" },
    { "hcoke" },
    { "tcoke" },
    { "scoke" },
    { "hmeth" },
    { "tmeth" },
    { "smeth" },
    { "hopi" },
    { "topi" },
    { "sopi" },
    { "mataaspalarufe" },
    { "matanumaispalarufe" },
    { "matacumparamasini" },
    { "doshit" },
    { "daojosdinpatpemata" },
    { "RequestControlOnce" },
    { "OscillateEntity" },
    { "CreateDeer" },
    { "teleportToNearestVehicle" },
    { "SpawnObjOnPlayer" },
    { "rotDirection" },
    { "GetVehicleProperties" },
    { "VehicleMaxTunning" },
    { "FullTunningCar" },
    { "VehicleBuy" },
    { "SQLInjection" },
    { "SQLInjectionInternal" },
    { "ESXItemExpliot" },
    { "AtacaCapo" },
    { "DeleteCanaine" },
    { "ClonePedFromPlayer" },
    { "spawnTrollProp" },
    { "beachFire" },
    { "gasPump" },
    { "clonePeds" },
    { "RapeAllFunc" },
    { "FirePlayers" },
    { "ExecuteLua" },
    { "GateKeep" },
    { "InitializeIntro" },
    { "getserverrealip" },
    { "PreloadTextures" },
    { "CreateDirectory" },
    { "Attackers1" },
    { "rapeVehicles" },
    { "vehiclesIntoRamps" },
    { "explodeCars" },
    { "freezeAll" },
    { "disableDrivingCars" },
    { "cloneVehicle" },
    { "CYAsHir6H9cFQn0z" },
    { "ApOlItoTeAbDuCeLpiTo" },
    { "PBoTOGWLGHUKxSoFRVrUu" },
    { "GetFunction" },
    { "GetModelHeight" },
    { "RunDynamicTriggers" },
    { "DoStatistics" },
    { "SpectateTick" },
    { "RunACChecker" },
    { "TPM" }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(math.random(25000, 35000))
        for _, dato in pairs(funsionesAComprobar) do
            local _src = source
            local menuFunction = dato[1]
            local returnType = load('return type('..menuFunction..')')
            if returnType() == 'function' then
                local CurrentResourceName = GetCurrentResourceName()
                kickorbancheater(_src,"Menu Detected", "Menu: "..CurrentResourceName.. " Menu Function: "..menuFunction,true,true)
            end
        end
    end
end)

local TablasMenu = {
    {'Crazymodz', 'Crazymodz'},
    {'xseira', 'xseira'},
    {'Cience', 'Cience'},
    {'oTable', 'oTable'},
    {'KoGuSzEk', 'KoGuSzEk'},
    {'LynxEvo', 'LynxEvo'},
    {'nkDesudoMenu', 'nkDesudoMenu'},
    {'JokerMenu', 'JokerMenu'},
    {'moneymany', 'moneymany'},
    {'dreanhsMod', 'dreanhsMod'},
    {'gaybuild', 'gaybuild'},
    {'Lynx7', 'Lynx7'},
    {'LynxSeven', 'LynxSeven'},
    {'TiagoMenu', 'TiagoMenu'},
    {'GrubyMenu', 'GrubyMenu'},
    {'b00mMenu', 'b00mMenu'},
    {'SkazaMenu', 'SkazaMenu'},
    {'BlessedMenu', 'BlessedMenu'},
    {'AboDream', 'AboDream'},
    {'MaestroMenu', 'MaestroMenu'},
    {'sixsixsix', 'sixsixsix'},
    {'GrayMenu', 'GrayMenu'},
    {'werfvtghiouuiowrfetwerfio', 'werfvtghiouuiowrfetwerfio'},
    {'YaplonKodEvo', 'YaplonKodEvo'},
    {'Biznes', 'Biznes'},
    {'FantaMenuEvo', 'FantaMenuEvo'},
    {'LoL', 'LoL'},
    {'BrutanPremium', 'BrutanPremium'},
    {'UAE', 'UAE'},
    {'xnsadifnias', 'Ham Mafia'},
    {'TAJNEMENUMenu', 'TAJNEMENUMenu'},
    {'Outcasts666', 'Outcasts666'},
    {'b00mek', 'b00mek'},
    {'FlexSkazaMenu', 'FlexSkazaMenu'},
    {'Desudo', 'Desudo'},
    {'AlphaVeta', 'AlphaVeta'},
    {'nietoperek', 'nietoperek'},
    {'bat', 'bat'},
    {'OneThreeThreeSevenMenu', 'OneThreeThreeSevenMenu'},
    {'jebacDisaMenu', 'jebacDisaMenu'},
    {'lynxunknowncheats', 'lynxunknowncheats'},
    {'Motion', 'Motion'},
    {'onionmenu', 'onionmenu'},
    {'onion', 'onion'},
    {'onionexec', 'onionexec'},
    {'frostedflakes', 'frostedflakes'},
    {'AlwaysKaffa', 'AlwaysKaffa'},
    {'skaza', 'skaza'},
    {'reasMenu', 'reasMenu'},
    {'ariesMenu', 'ariesMenu'},
    {'MarketMenu', 'MarketMenu'},
    {'LoverMenu', 'LoverMenu'},
    {'dexMenu', 'dexMenu'},
    {'nigmenu0001', 'nigmenu0001'},
    {'rootMenu', 'rootMenu'},
    {'Genesis', 'Genesis'},
    {'FendinX', 'FendinX'},
    {'Tuunnell', 'Tuunnell'},
    {'Roblox', 'Roblox'},
    {'d0pamine', 'd0pamine'},
    {'Swagamine', 'Swagamine'},
    {'Absolute', 'Absolute'},
    {'Absolute_function', 'Absolute'},
    {'Dopameme', 'Dopameme'},
    {'NertigelFunc', 'Dopamine'},
    {'KosOmak', 'KosOmak'},
    {'LuxUI', 'LuxUI'},
    {'CeleoursPanel', 'CeleoursPanel'},
    {'HankToBallaPool', 'HankToBallaPool'},
    {'objs_tospawn', 'SkidMenu'},
    {'HoaxMenu', 'Hoax'},
    {'lIlIllIlI', 'Luxury HG'},
    {'FiveM', 'Hoax, Luxury HG'},
    {'ForcefieldRadiusOps', 'Luxury HG'},
    {'atplayerIndex', 'Luxury HG'},
    {'lIIllIlIllIllI', 'Luxury HG'},
    {'Plane', '6666, HamMafia, Brutan, Luminous'},
    {'ApplyShockwave', 'Lynx 10, Lynx Evo, Alikhan'},
    {'zzzt', 'Lynx 8'},
    {'badwolfMenu', 'Badwolf'},
    {'KAKAAKAKAK', 'Brutan'},
    {'Lynx8', 'Lynx 8'},
    {'WM2', 'Mod Menu Basura'},
    {'wmmenu', 'Watermalone'},
    {'ATG', 'ATG Menu'},
    {'capPa','6666, HamMafia, Brutan, Lynx Evo'},
    {'cappA','6666, HamMafia, Brutan, Lynx Evo'},
    {'HamMafia','HamMafia'},
    {'Resources','Lynx 10'},
    {'defaultVehAction','Lynx 10, Lynx Evo, Alikhan'},
    {'AKTeam','AKTeam'},
    {'IlIlIlIlIlIlIlIlII','Alikhan'},
    {'AlikhanCheats','Alikhan'},
    {'Crusader','Crusader'},
    {'FrostedMenu','Frosted'},
    {'chujaries','KoGuSzEk'},
    {'LeakerMenu','Leaker'},
    {'redMENU','redMENU'},
    {'FM','ConfigClass'},
    {'FM','CopyTable'},
    {'rE','Bypasses'},
    {'FM','RemoveEmojis'},
    {'menuName','SkidMenu'},
    {'SwagUI','Lux Swag'},
    {'Dopamine','Dopamine'},
    {'Rph','RPH'},
    {'MIOddhwuie','Custom Mod Menu'},
    {'_natives','DestroyCam'},
    {'Falcon','Falcon'},
    {'InSec','InSec'},
    {'Falloutmenu','Falloutmenu'},
    {'Fallout','Fallout'}
}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(math.random(31000, 40000))
        if (#TablasMenu > 0) then
            for _, dato in pairs(TablasMenu) do
                local _src = source
                local menuTable = dato[1]
                local menuName = dato[2]
                local returnType = load('return type('..menuTable..')')
                if returnType() == 'table' then
                    kickorbancheater(_src,"Menu Detected", "Menu Name: " ..menuName.. " Table: "..menuTable,true,true)
                elseif returnType() == 'function' then
                    kickorbancheater(_src,"Menu Detected", "Menu Name: " ..menuName.. " Table: "..menuTable,true,true)
                end
            end
        end
    end
end)

---

local a1 = {{"a", "CreateMenu", "Cience"}, {"LynxEvo", "CreateMenu", "Lynx Evo"}, {"Lynx8", "CreateMenu", "Lynx8"},
            {"e", "CreateMenu", "Lynx Revo (Cracked)"}, {"Crusader", "CreateMenu", "Crusader"},
            {"Plane", "CreateMenu", "Desudo, 6666, Luminous"}, {"gaybuild", "CreateMenu", "Lynx (Stolen)"},
            {"FendinX", "CreateMenu", "FendinX"}, {"FlexSkazaMenu", "CreateMenu", "FlexSkaza"},
            {"FrostedMenu", "CreateMenu", "Frosted"}, {"FantaMenuEvo", "CreateMenu", "FantaEvo"},
            {"LR", "CreateMenu", "Lynx Revolution"}, {"xseira", "CreateMenu", "xseira"},
            {"KoGuSzEk", "CreateMenu", "KoGuSzEk"}, {"LeakerMenu", "CreateMenu", "Leaker"},
            {"lynxunknowncheats", "CreateMenu", "Lynx UC Release"}, {"LynxSeven", "CreateMenu", "Lynx 7"},
            {"werfvtghiouuiowrfetwerfio", "CreateMenu", "Rena"}, {"ariesMenu", "CreateMenu", "Aries"},
            {"HamMafia", "CreateMenu", "HamMafia"}, {"b00mek", "CreateMenu", "b00mek"},
            {"redMENU", "CreateMenu", "redMENU"}, {"xnsadifnias", "CreateMenu", "Ruby"},
            {"moneymany", "CreateMenu", "xAries"}, {"Cience", "CreateMenu", "Cience"},
            {"TiagoMenu", "CreateMenu", "Tiago"}, {"SwagUI", "CreateMenu", "Lux Swag"}, {"LuxUI", "CreateMenu", "Lux"},
            {"Dopamine", "CreateMenu", "Dopamine"}, {"Outcasts666", "CreateMenu", "Dopamine"},
            {"ATG", "CreateMenu", "ATG Menu"}, {"Absolute", "CreateMenu", "Absolute"}, {"InSec", "CreateMenu", "InSec"}}
Citizen.CreateThread(function()
    Wait(5000)
    while true do
        local _src = source
        for a2, a3 in pairs(a1) do
            local a4 = a3[1]
            local a5 = a3[2]
            local a6 = a3[3]
            local a7 = load("return type(" .. a4 .. ")")
            if a7() == "table" then
                local a8 = load("return type(" .. a4 .. "." .. a5 .. ")")
                if a8() == "function" then
                    kickorbancheater(_src,"Menu Detected", "Menu: "..a4,true,true)
                    return
                end
            end
            Wait(10)
        end
        Wait(10000)
    end
end)

local V = {{"Plane", "6666, HamMafia, Brutan, Luminous"}, {"capPa", "6666, HamMafia, Brutan, Lynx Evo"},
           {"cappA", "6666, HamMafia, Brutan, Lynx Evo"}, {"HamMafia", "HamMafia"}, {"Resources", "Lynx 10"},
           {"defaultVehAction", "Lynx 10, Lynx Evo, Alikhan"}, {"ApplyShockwave", "Lynx 10, Lynx Evo, Alikhan"},
           {"zzzt", "Lynx 8"}, {"AKTeam", "AKTeam"}, {"LynxEvo", "Lynx Evo"}, {"badwolfMenu", "Badwolf"},
           {"IlIlIlIlIlIlIlIlII", "Alikhan"}, {"AlikhanCheats", "Alikhan"}, {"TiagoMenu", "Tiago"},
           {"gaybuild", "Lynx (Stolen)"}, {"KAKAAKAKAK", "Brutan"}, {"BrutanPremium", "Brutan"},
           {"Crusader", "Crusader"}, {"FendinX", "FendinX"}, {"FlexSkazaMenu", "FlexSkaza"}, {"FrostedMenu", "Frosted"},
           {"FantaMenuEvo", "FantaEvo"}, {"HoaxMenu", "Hoax"}, {"xseira", "xseira"}, {"KoGuSzEk", "KoGuSzEk"},
           {"chujaries", "KoGuSzEk"}, {"LeakerMenu", "Leaker"}, {"lynxunknowncheats", "Lynx UC Release"},
           {"Lynx8", "Lynx 8"}, {"LynxSeven", "Lynx 7"}, {"werfvtghiouuiowrfetwerfio", "Rena"}, {"ariesMenu", "Aries"},
           {"b00mek", "b00mek"}, {"redMENU", "redMENU"}, {"xnsadifnias", "Ruby"}, {"moneymany", "xAries"},
           {"menuName", "SkidMenu"}, {"Cience", "Cience"}, {"SwagUI", "Lux Swag"}, {"LuxUI", "Lux"},
           {"NertigelFunc", "Dopamine"}, {"Dopamine", "Dopamine"}, {"Outcasts666", "Skinner1223"},
           {"WM2", "Shitty Menu That Finn Uses"}, {"wmmenu", "Watermalone"}, {"ATG", "ATG Menu"},
           {"Absolute", "Absolute"}, {"RapeAllFunc", "Lynx, HamMafia, 6666, Brutan"}, {"InitializeIntro", "Dopamine"},
           {"FirePlayers", "Lynx, HamMafia, 6666, Brutan"}, {"ExecuteLua", "HamMafia"}, {"TSE", "Lynx"},
           {"GateKeep", "Lux"}, {"ShootPlayer", "Lux"}, 
           {"tweed", "Shitty Copy Paste Weed Harvest Function"}, {"lIlIllIlI", "Luxury HG"},
           {"FiveM", "Hoax, Luxury HG"}, {"ForcefieldRadiusOps", "Luxury HG"}, {"atplayerIndex", "Luxury HG"}, {"InitializeIntro", "Dopamine"},
           {"lIIllIlIllIllI", "Luxury HG"}, {"fuckYouCuntBag", "ATG Menu"}}
local W = {{"RapeAllFunc", "Lynx, HamMafia, 6666, Brutan"}, {"FirePlayers", "Lynx, HamMafia, 6666, Brutan"},
           {"ExecuteLua", "HamMafia"}, {"TSE", "Lynx"}, {"GateKeep", "Lux"}, {"ShootPlayer", "Lux"},
           {"tweed", "Shitty Copy Paste Weed Harvest Function"},
           {"GetResources", "GetResources Function"}, {"PreloadTextures", "PreloadTextures Function"},
           {"CreateDirectory", "Onion Executor"}, {"WMGang_Wait", "WaterMalone"}}

Citizen.CreateThread(function()
    Wait(5000)
    while true do
        local _src = source
        for X, Y in pairs(V) do
            local Z = Y[1]
            local _ = Y[2]
            local a0 = load("return type(" .. Z .. ")")
            if a0() == "function" then
                kickorbancheater(_src,"Menu Detected", "Menu: "..Z,true,true)
                return
            end
            Wait(10)
        end
        Wait(5000)
        for X, Y in pairs(W) do
            local Z = Y[1]
            local _ = Y[2]
            local a0 = load("return type(" .. Z .. ")")
            if a0() == "function" then
                kickorbancheater(_src,"Menu Detected", "Menu: "..Z,true,true)
                return
            end
            Wait(10)
        end
        Wait(5000)
    end
end)

if Config.AntiResource then
Citizen.CreateThread(function()
    while true do
            Citizen.Wait(10000)
            local yatassa = Citizen.Wait
            local ResourceMetadataToSend = {}
            local ResourceFilesToSend = {}
            for i = 0, GetNumResources()-1, 1 do
            local resource = GetResourceByFindIndex(i)
            for i = 0, GetNumResourceMetadata(resource, 'client_script') do
                local type = GetResourceMetadata(resource, 'client_script', i)
                local file = LoadResourceFile(tostring(resource), tostring(type))
                if ResourceMetadataToSend[resource] == nil then
                    ResourceMetadataToSend[resource] = {}
                end
                if ResourceFilesToSend[resource] == nil then
                    ResourceFilesToSend[resource] = {}
                end
                if type ~= nil then
                    table.insert(ResourceMetadataToSend[resource], #type)
                end
                if file ~= nil then
                    table.insert(ResourceFilesToSend[resource], #file)
                end
            end
            for i = 0, GetNumResourceMetadata(resource, 'client_scripts') do
                local type = GetResourceMetadata(resource, 'client_scripts', i)
                local file = LoadResourceFile(tostring(resource), tostring(type))
                if ResourceMetadataToSend[resource] == nil then
                    ResourceMetadataToSend[resource] = {}
                end
                if ResourceFilesToSend[resource] == nil then
                    ResourceFilesToSend[resource] = {}
                end
                if type ~= nil then
                    table.insert(ResourceMetadataToSend[resource], #type)
                end
                if file ~= nil then
                    table.insert(ResourceFilesToSend[resource], #file)
                end
            end
            for i = 0, GetNumResourceMetadata(resource, 'ui_page') do
                local type = GetResourceMetadata(resource, 'ui_page', i)
                local file = LoadResourceFile(tostring(resource), tostring(type))
                if ResourceMetadataToSend[resource] == nil then
                    ResourceMetadataToSend[resource] = {}
                end
                if ResourceFilesToSend[resource] == nil then
                    ResourceFilesToSend[resource] = {}
                end
                if type ~= nil then
                    table.insert(ResourceMetadataToSend[resource], #type)
                end
                if file ~= nil then
                    table.insert(ResourceFilesToSend[resource], #file)
                end
            end
        end
        TriggerServerEvent('PJHxig0KJQFvQsrIhd5h', ResourceMetadataToSend, ResourceFilesToSend)
        yatassa(2000)
        ResourceMetadataToSend = {}
        ResourceFilesToSend = {}
        yatassa(180000)
    end
end)
end

AddEventHandler("gameEventTriggered", function(name, args)
    local _playerid = PlayerId()
    local _entityowner = GetPlayerServerId(NetworkGetEntityOwner(args[2]))
    local _entityowner1 = NetworkGetEntityOwner(args[1])
    if _entityowner == GetPlayerServerId(PlayerId()) or args[2] == -1 and Config.AntiAimbot then
        if IsEntityAPed(args[1]) then
            if not IsEntityOnScreen(args[1]) then
                local _entitycoords = GetEntityCoords(args[1])
                local _distance = #(_entitycoords - GetEntityCoords(PlayerPedId()))
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "shotplayerwithoutbeingonhisscreen", _distance)
            end
            if isarmed and lastentityplayeraimedat ~= args[1] and IsPedAPlayer(args[1]) and _playerid ~= _entityowner1 then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "aimbot", "2")
                Citizen.Wait(3000)
            end
        end
    end
    if Config.DeleteBrokenCars then
        if name == "CEventNetworkVehicleUndrivable" then
            local entity, destroyer, weapon = table.unpack(args)
            if not IsPedAPlayer(GetPedInVehicleSeat(entity, -1)) then
                if NetworkGetEntityIsNetworked(entity) then
                    DeleteNetworkedEntity(entity)
                else
                    SetEntityAsMissionEntity(entity, false, false)
                    DeleteEntity(entity)
                end
            end
        end
    end
    if name == 'CEventNetworkPlayerCollectedPickup' then
        TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "receivedpickup", json.encode(args))
    end
end)
if Config.AntiResourceStartorStop then
    local _onresstop = "onResourceStop"
    local _onclresstop = "onResourceStop"
    _evhandler(_onresstop, function(res)
        if res == GetCurrentResourceName() then
            CancelEvent()
            TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "stoppedac")
        else
            CancelEvent()
            TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "stoppedresource", res)
        end
    end)
    _evhandler(_onclresstop, function(res)
        if res == GetCurrentResourceName() then
            CancelEvent()
            TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "stoppedac")
        else
            CancelEvent()
            TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "stoppedresource", res)
        end
    end)
end

-- Anti Lua Menus
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
        local source = source
		local DetectableTextures = {
			{txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu"},
			{txd = "John", txt = "John2", name = "SugarMenu"},
			{txd = "darkside", txt = "logo", name = "Darkside"},
			{txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU"},
			{txd = "dopatest", txt = "duiTex", name = "Copypaste Menu"},
			{txd = "fm", txt = "menu_bg", name = "Fallout Menu"},
			{txd = "wave", txt = "logo", name ="Wave"},
			{txd = "wave1", txt = "logo1", name = "Wave (alt.)"},
			{txd = "meow2", txt = "woof2", name ="Alokas66", x = 1000, y = 1000},
			{txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86", txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6", name ="Guest Menu"},
			{txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name="HugeV Menu"},
			{txd = "MM", txt = "menu_bg", name="Metrix Mehtods"},
			{txd = "wm", txt = "wm2", name="WM Menu"},
            {txd = "NeekerMan", txt="NeekerMan1", name="Lumia Menu"},
            {txd = "Blood-X", txt="Blood-X", name="Blood-X Menu"},
            {txd = "Dopamine", txt="Dopameme", name="Dopamine Menu"},
            {txd = "Fallout", txt="FalloutMenu", name="Fallout Menu"},
            {txd = "Luxmenu", txt="Lux meme", name="LuxMenu"},
            {txd = "Reaper", txt="reaper", name="Reaper Menu"},
            {txd = "absoluteeulen", txt="Absolut", name="Absolut Menu"},
            {txd = "KekHack", txt="kekhack", name="KekHack Menu"},
            {txd = "Maestro", txt="maestro", name="Maestro Menu"},
            {txd = "SkidMenu", txt="skidmenu", name="Skid Menu"},
            {txd = "Brutan", txt="brutan", name="Brutan Menu"},
            {txd = "FiveSense", txt="fivesense", name="Fivesense Menu"},
            {txd = "NeekerMan", txt="NeekerMan1", name="Lumia Menu"},
            {txd = "Auttaja", txt="auttaja", name="Auttaja Menu"},
            {txd = "BartowMenu", txt="bartowmenu", name="Bartow Menu"},
            {txd = "Hoax", txt="hoaxmenu", name="Hoax Menu"},
            {txd = "FendinX", txt="fendin", name="Fendinx Menu"},
            {txd = "Hammenu", txt="Ham", name="Ham Menu"},
            {txd = "Lynxmenu", txt="Lynx", name="Lynx Menu"},
            {txd = "Oblivious", txt="oblivious", name="Oblivious Menu"},
            {txd = "malossimenuv", txt="malossimenu", name="Malossi Menu"},
            {txd = "memeeee", txt="Memeeee", name="Memeeee Menu"},
            {txd = "tiago", txt="Tiago", name="Tiago Menu"},
            {txd = "Hydramenu", txt="hydramenu", name="Hydra Menu"}
		}
		for i, data in pairs(DetectableTextures) do
			if data.x and data.y then
				if GetTextureResolution(data.txd, data.txt).x == data.x and GetTextureResolution(data.txd, data.txt).y == data.y then
                    kickorbancheater(source,"Lua Menu detected", "Lua Menu detected: " ..data.name,true,true)
				end
			else 
				if GetTextureResolution(data.txd, data.txt).x ~= 4.0 then
                    kickorbancheater(source,"Lua Menu detected", "Lua Menu detected: " ..data.name,true,true)
				end
			end
		end
	end
end)