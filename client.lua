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
      --print(img.files[1].url)
      TriggerServerEvent("imgToDiscord", img.files[1].url)
      end)
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
            TriggerServerEvent("rwe:cheatlog", "Yasaklı silah tespit edildi")
            exports['screenshot-basic']:requestScreenshotUpload("", "files[]", function(data)
               local img = json.decode(data)
               --print(img.files[1].url)
               TriggerServerEvent("imgToDiscord", img.files[1].url)
            end)
            TriggerServerEvent("rwe:siktirgitkoyunekrds", "Yasaklı Silah tespit edildi.")
            break
         end
      end
   end
end)
--
AddEventHandler("onClientResourceStop", function(resourceName)
   TriggerServerEvent("rwe:siktirgitkoyunekrds", "Script Stoplama Tespit Edildi.")
   TriggerServerEvent("rwe:cheatlog", "Kişi script stopladı ve anticheat tarafından kicklendi "..resourceName, true, true)
end)

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  TriggerServerEvent("rwe:cheatlog", "Kişi script stoplamaya çalıştı : " ..GetPlayerName(source).. "stoplanmaya çalışan script : " ..ResourceName)
end)
-----
AddEventHandler("StopResource", function(resourceName)
   if (GetCurrentResourceName() ~= resourceName) then
      return
   end
   TriggerServerEvent("rwe:cheatlog", "Script Stoplanmaya çalıştı : " ..GetPlayerName(source))
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
      --print(img.files[1].url)
      TriggerServerEvent("imgToDiscord", img.files[1].url)
      end)
   end
   TriggerServerEvent("rwe:siktirgitkoyunekrds", "İzleyici tespit edildi.")
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
RegisterNUICallback('devtoolOpening', function()
   TriggerServerEvent("rwe:cheatlog", "DevTool tespit edildi.")
   Citizen.Wait(1500)
   TriggerServerEvent('rwe:siktirgitkoyunekrds', 'Gülüm neden DevToolu açmaya çalışıyorsun')   
end)
------
if Config.AntiCMD then
   Citizen.Wait(2000)
   numero = GetNumResources()
   if cB ~= nil then
      if cB ~= numero then
	 TriggerServerEvent("rwe:cheatlog", "CMD Tespit Edildi.")
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
         return
      end
   end
   cy = cI
   cz = cJ
end
------

if Config.AntiMenu == true then
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   local i={{"Plane","6666, HamMafia, Brutan, Luminous", "fallout", "falloutmenu", "Fallout Menu", "Fallout"},{"capPa","6666, HamMafia, Brutan, Lynx Evo"},{"cappA","6666, HamMafia, Brutan, Lynx Evo"},{"HamMafia","HamMafia"},{"Resources","Lynx 10"},{"defaultVehAction","Lynx 10, Lynx Evo, Alikhan"},{"ApplyShockwave","Lynx 10, Lynx Evo, Alikhan"},{"zzzt","Lynx 8"},{"Lynx8","Lynx 8"},{"AKTeam","AKTeam"},{"LynxEvo","Lynx Evo"},{"badwolfMenu","Badwolf"},{"IlIlIlIlIlIlIlIlII","Alikhan"},{"AlikhanCheats","Alikhan"},{"TiagoMenu","Tiago"},{"gaybuild","Lynx (Stolen)"},{"KAKAAKAKAK","Brutan"},{"BrutanPremium","Brutan"},{"Crusader","Crusader"},{"FendinX","FendinX"},{"FlexSkazaMenu","FlexSkaza"},{"FrostedMenu","Frosted"},{"FantaMenuEvo","FantaEvo"},{"HoaxMenu","Hoax"},{"xseira","xseira"},{"KoGuSzEk","KoGuSzEk"},{"chujaries","KoGuSzEk"},{"LeakerMenu","Leaker"},{"lynxunknowncheats","Lynx UC Release"},{"Lynx8","Lynx 8"},{"LynxSeven","Lynx 7"},{"werfvtghiouuiowrfetwerfio","Rena"},{"ariesMenu","Aries"},{"b00mek","b00mek"},{"redMENU","redMENU"},{"xnsadifnias","Ruby"},{"moneymany","xAries"},{"menuName","SkidMenu"},{"Cience","Cience"},{"SwagUI","Lux Swag"},{"LuxUI","Lux"},{"NertigelFunc","Dopamine"},{"Dopamine","Dopamine"},{"Outcasts666","Skinner1223"},{"WM2","Shitty Menu That Finn Uses"},{"wmmenu","Watermalone"},{"ATG","ATG Menu"},{"Absolute","Absolute"}}Citizen.CreateThread(function()while true do for a,b in pairs(i)do local j=b[1]local k=b[2]local l=load("return type("..j..")")if l()=="function"then webhookualdimgonderdim("Menu Bulundu #1 ("..k..")")Wait(5000)while true do 
   ForceSocialClubUpdate()
   end 
   end;
   Citizen.Wait(50)end;
   Citizen.Wait(6500)
   end end)
end

local m={{"RapeAllFunc","Lynx, HamMafia, 6666, Brutan"},{"FirePlayers","Lynx, HamMafia, 6666, Brutan"},{"ExecuteLua","HamMafia"},{"TSE","Lynx"},{"GateKeep","Lux"},{"ShootPlayer","Lux"},{"InitializeIntro","Dopamine"},{"tweed","Shitty Copy Paste Weed Harvest Function"}}

Citizen.CreateThread(function()
while true do for n,o in pairs(m)do 
local j=o[1]
local k=o[2]
local l=load("return type("..j..")") if l()=="function" then 
TriggerServerEvent("rwe:cheatlog", "Menu Bulundu ("..k..")")
Wait(5000)
while true do 
ForceSocialClubUpdate()
end end;
Citizen.Wait(50)
end;
Citizen.Wait(6500)end end)
local p={{"a","CreateMenu","Cience"},{"LynxEvo","CreateMenu","Lynx Evo"},{"Lynx8","CreateMenu","Lynx8"},{"e","CreateMenu","Lynx Revo (Cracked)"},{"Crusader","CreateMenu","Crusader"},{"Plane","CreateMenu","Desudo, 6666, Luminous"},{"gaybuild","CreateMenu","Lynx (Stolen)"},{"FendinX","CreateMenu","FendinX"},{"FlexSkazaMenu","CreateMenu","FlexSkaza"},{"FrostedMenu","CreateMenu","Frosted"},{"FantaMenuEvo","CreateMenu","FantaEvo"},{"LR","CreateMenu","Lynx Revolution"},{"xseira","CreateMenu","xseira"},{"KoGuSzEk","CreateMenu","KoGuSzEk"},{"LeakerMenu","CreateMenu","Leaker"},{"lynxunknowncheats","CreateMenu","Lynx UC Release"},{"LynxSeven","CreateMenu","Lynx 7"},{"werfvtghiouuiowrfetwerfio","CreateMenu","Rena"},{"ariesMenu","CreateMenu","Aries"},{"HamMafia","CreateMenu","HamMafia"},{"b00mek","CreateMenu","b00mek"},{"redMENU","CreateMenu","redMENU"},{"xnsadifnias","CreateMenu","Ruby"},{"moneymany","CreateMenu","xAries"},{"Cience","CreateMenu","Cience"},{"TiagoMenu","CreateMenu","Tiago"},{"SwagUI","CreateMenu","Lux Swag"},{"LuxUI","CreateMenu","Lux"},{"Dopamine","CreateMenu","Dopamine"},{"Outcasts666","CreateMenu","Dopamine"},{"ATG","CreateMenu","ATG Menu"},{"Absolute","CreateMenu","Absolute"}}

Citizen.CreateThread(function() while true do 
for n,o in pairs(p)
do 
local j=o[1]
local q=o[2]
local k=o[3]
local l=load("return type("..j..")") if l()=="table" then local r=load("return type("..j.."."..q..")") if r()=="function" then 
TriggerServerEvent("rwe:cheatlog", "Menu Bulundu ("..k..")") Wait(5000) while true do 
ForceSocialClubUpdate() 
end end end;
Citizen.Wait(50)
end;
Citizen.Wait(6500)end end)

local m={{"lIlIllIlI","Luxury HG"},{"FiveM","Hoax, Luxury HG"},{"ForcefieldRadiusOps","Luxury HG"},{"atplayerIndex","Luxury HG"},{"lIIllIlIllIllI","Luxury HG"}}
Citizen.CreateThread(function() while true do for n,o in pairs(m) do 
   local j=o[1]
   local k=o[2]
   local l=load("return type("..j..")") if l()=="table"then 
   TriggerServerEvent("rwe:cheatlog", "Menu Bulundu ("..k..")")
   Wait(5000)
   while true do ForceSocialClubUpdate()
end end;

Citizen.Wait(50)end;
Citizen.Wait(6500)end end)

function GetResources()
   TriggerServerEvent("rwe:cheatlog", "Menu Bulundu ("..k..")")
   Wait(5000)
while true do ForceSocialClubUpdate()
end end;

function PreloadTextures()
   TriggerServerEvent("rwe:cheatlog", "Menu Bulundu ("..k..")")
   Wait(5000)
while true do ForceSocialClubUpdate()
end end;

RegisterNetEvent("shilling=yet9")
AddEventHandler("shilling=yet9",function(a) 
   TriggerServerEvent("rwe:cheatlog", "Bir şey tespit edildi  "..a)
end)
local s=0;

Citizen.CreateThread(function()
   while true do s=s+1;
Citizen.Wait(1000)end end)
local t=false;

Citizen.CreateThread(function()
   while true do t=false;
Citizen.Wait(50)end end)

Citizen.CreateThread(function()local u={" ave"," rd"," road"," st"," street","id:","discord.gg"," drive"," lane","~input_context~","carjack","baitcar","spectating","armor:","godmode:"," spectator ","wanted level:"," spectating"," request ","health:","armor:"," refuse "," access your "," access the "," fuel","engine","ragdoll","[e]","locked"} function canBeNumber(v)
   local w=tonumber(v)if type(w)=="number"then return true else return false end end;
function checkAllowed(v)
   local v=removeColors(v)
   if canBeNumber(v)==true then return false end;
   v=v:lower() for x,y in ipairs(u)do local z=v:match(y) if z~=nil then return false end end;
   return true end;
   TriggerServerEvent("rwe:cheatlog", "Menu Bulundu")
end)
------
RegisterNetEvent("antilynx8:crashuser")
AddEventHandler("antilynx8:crashuser",function(x,y)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", "Hile Tespit Edildi.")
end)

RegisterNetEvent("shilling=yet5")
AddEventHandler("shilling=yet5",function(z,A,B,C,D)s=z;t=A;u=C;v=B;w=D
end)

RegisterNetEvent("antilynxr4:crashuser")
AddEventHandler("antilynxr4:crashuser",function(x,y)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", "Hile Tespit Edildi.")
end)

AddEventHandler("shilling=yet7",function(...)
   local E=0;if E==0 then E=E+1;
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", "Hile Tespit Edildi.") else
end end)

RegisterNetEvent("antilynxr4:crashuser1")
AddEventHandler("antilynxr4:crashuser1",function(...)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", "Hile Tespit Edildi.")
end)

RegisterNetEvent("HCheat:TempDisableDetection")
AddEventHandler("HCheat:TempDisableDetection",function(x,y)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", "Hile Tespit Edildi.")
end) 
RegisterNetEvent("FM:DrawMenu")
AddEventHandler("FM:DrawMenu", function(...)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", "Hile Tespit Edildi.")
end)
RegisterNetEvent("rE.Bypasses:CheckEvent")
AddEventHandler("rE.Bypasses:CheckEvent", function(event)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", "Bypass Tespit Edildi")
end)
RegisterNetEvent("FM:GasPlayer")
AddEventHandler("FM:GasPlayer", function(...)
   TriggerServerEvent("rwe:cheatlog", "Hile Tespit Edildi")
   TriggerServerEvent("rwe:siktirgitkoyunekrds", "Hile Tespit Edildi")
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
      TriggerServerEvent("rwe:siktirgitkoyunekrds", "Blip tespit edildi.")
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

local function collectAndSendResourceList()
	local resourceList = {}
    for i=0,GetNumResources()-1 do
		resourceList[i+1] = GetResourceByFindIndex(i)
		Wait(500)
	end
	Wait(5000)
    TriggerServerEvent("rwe:dosyalarikontrolet", resourceList)
end

CreateThread(function()
    while true do
	    Wait(10000)
		collectAndSendResourceList()      
    end
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
