-- BLACKLISTED THINGS

local fRPrcPtDT5lAYGZ6fCY={{"ForcefieldRadiusOps", "Luxury HG"}, {"atplayerIndex", "Luxury HG"}, {"lIIllIlIllIllI", "Luxury HG"},{"Plane","6666, HamMafia, Brutan, Luminous"},{"capPa","6666, HamMafia, Brutan, Lynx Evo"},{"cappA","6666, HamMafia, Brutan, Lynx Evo"},{"HamMafia","HamMafia"},{"Resources","Lynx 10"},{"defaultVehAction","Lynx 10, Lynx Evo, Alikhan"},{"ApplyShockwave","Lynx 10, Lynx Evo, Alikhan"},{"zzzt","Lynx 8"},{"Lynx8","Lynx 8"},{"AKTeam","AKTeam"},{"LynxEvo","Lynx Evo"},{"badwolfMenu","Badwolf"},{"IlIlIlIlIlIlIlIlII","Alikhan"},{"AlikhanCheats","Alikhan"},{"TiagoMenu","Tiago"},{"gaybuild","Lynx (Stolen)"},{"KAKAAKAKAK","Brutan"},{"BrutanPremium","Brutan"},{"Crusader","Crusader"},{"FendinX","FendinX"},{"FlexSkazaMenu","FlexSkaza"},{"FrostedMenu","Frosted"},{"FantaMenuEvo","FantaEvo"},{"HoaxMenu","Hoax"},{"xseira","xseira"},{"KoGuSzEk","KoGuSzEk"},{"chujaries","KoGuSzEk"},{"LeakerMenu","Leaker"},{"lynxunknowncheats","Lynx UC Release"},{"Lynx8","Lynx 8"},{"LynxSeven","Lynx 7"},{"werfvtghiouuiowrfetwerfio","Rena"},{"ariesMenu","Aries"},{"b00mek","b00mek"},{"redMENU","redMENU"},{"xnsadifnias","Ruby"},{"moneymany","xAries"},{"menuName","SkidMenu"},{"Cience","Cience"},{"SwagUI","Lux Swag"},{"LuxUI","Lux"},{"NertigelFunc","Dopamine"},{"Dopamine","Dopamine"},{"Outcasts666","Skinner1223"},{"WM2","Shitty Menu That Finn Uses"},{"wmmenu","Watermalone"},{"ATG","ATG Menu"},{"fuckYouCuntBag","ATG Menu"},{"Absolute","Absolute"},{"RapeAllFunc","Lynx, HamMafia, 6666, Brutan"},{"FirePlayers","Lynx, HamMafia, 6666, Brutan"},{"ExecuteLua","HamMafia"},{"TSE","Lynx"},{"GateKeep","Lux"},{"ShootPlayer","Lux"},{"InitializeIntro","Dopamine"},{"tweed","Shitty Copy Paste Weed Harvest Function"},{"GetResources","GetResources Function"},{"PreloadTextures","PreloadTextures Function"},{"CreateDirectory","Onion Executor"},{"WMGang_Wait","WaterMalone"},{"a","CreateMenu","Cience"},{"LynxEvo","CreateMenu","Lynx Evo"},{"Lynx8","CreateMenu","Lynx8"},{"e","CreateMenu","Lynx Revo (Cracked)"},{"Crusader","CreateMenu","Crusader"},{"Plane","CreateMenu","Desudo, 6666, Luminous"},{"gaybuild","CreateMenu","Lynx (Stolen)"},{"FendinX","CreateMenu","FendinX"},{"FlexSkazaMenu","CreateMenu","FlexSkaza"},{"FrostedMenu","CreateMenu","Frosted"},{"FantaMenuEvo","CreateMenu","FantaEvo"},{"LR","CreateMenu","Lynx Revolution"},{"xseira","CreateMenu","xseira"},{"KoGuSzEk","CreateMenu","KoGuSzEk"},{"LeakerMenu","CreateMenu","Leaker"},{"lynxunknowncheats","CreateMenu","Lynx UC Release"},{"LynxSeven","CreateMenu","Lynx 7"},{"werfvtghiouuiowrfetwerfio","CreateMenu","Rena"},{"ariesMenu","CreateMenu","Aries"},{"HamMafia","CreateMenu","HamMafia"},{"b00mek","CreateMenu","b00mek"},{"redMENU","CreateMenu","redMENU"},{"xnsadifnias","CreateMenu","Ruby"},{"moneymany","CreateMenu","xAries"},{"Cience","CreateMenu","Cience"},{"TiagoMenu","CreateMenu","Tiago"},{"SwagUI","CreateMenu","Lux Swag"},{"LuxUI","CreateMenu","Lux"},{"Dopamine","CreateMenu","Dopamine"},{"Outcasts666","CreateMenu","Dopamine"},{"ATG","CreateMenu","ATG Menu"},{"fuckYouCuntBag","CreateMenu","ATG Menu"},{"Absolute","CreateMenu","Absolute"},{"AlienMenu","CreateMenu","️ALIEN MENU"}}

-- NATIVE DETECTION

local sagvffvE4KxV7MtOG2Tl = Citizen.InvokeNative
local YlGu4oCbJ4Z9yuVvtWRE = GiveWeaponToPed
local invokenativecount = 0
local mAMmCkrkcME4sqcs4vJv = math.random
local rNL7KxLgWOCKR2uDomb1 = false
local Vce6hPPdk8ACYlEFH2YS = SetPedComponentVariation

Citizen.InvokeNative = function(native, args1, args2, ...)
    invokenativecount = invokenativecount +1
    if native == -4679285206957010997 then
        TriggerServerEvent('tYdirSYpJtB77dRC3cvX', args1)
        return YlGu4oCbJ4Z9yuVvtWRE(native, args1, args2)
    end
    if native == 0xCE07B9F7817AADA3 then
        sendwebhooktodc("SetPlayerWeaponDamageModifier function triggered. (Possible Weapon Modifier Cheats)")
    end
    if native == 0x867654CBC7606F2C then
        sendwebhooktodc("ShootSingleBulletBetweenCoords function triggered. (Possible Aimbot)")
    end
    if native == 0x96A05E4FB321B1BA then
        sendwebhooktodc("SetPedShootsAtCoord function triggered. (Possible Aimbot)")
    end
    if native == 0x44A8FCB8ED227738 then
        sendwebhooktodc("GetWorldPositionOfEntityBone function triggered. (Possible Aimbot)")
    end
    if args1 == "[<font color='#FFCD00'>Fallout Menu</font>~s~]" then
        sendwebhooktodc("Fallout Menu (100% Accurate)")
    end
    if native == 0xBF0FD6E56C964FCB then
        sendwebhooktodc("GiveWeaponToPed function triggered.")
    end
    if native == 0xC5F68BE9613E2D18 then
        sendwebhooktodc("ApplyForceToEntity function triggered. (Possible Magneto or Troll Cheats)")
    end
    if native == 0xE3AD2BDBAEE269AC then
        sendwebhooktodc("AddExplosion function triggered.")
    end
    if native == 0x11FE353CF9733E6F then
        sendwebhooktodc("RequestScaleformMovie function triggered.")
    end
    if native == 0x57FFF03E423A4C0B then
        sendwebhooktodc("SetSuperJumpThisFrame function triggered.")
    end
    if native == 0xA352C1B864CAFD33 then
        sendwebhooktodc("RestorePlayerStamina function triggered.")
    end
    if native == 0xFBA08C503DD5FA58 then
        sendwebhooktodc("CreatePickup function triggered.")
    end
    if native == 0x6B9BBD38AB0796DF then
        if IsEntityAPed(args1) then
            sendwebhooktodc("AttachEntityToEntity (PED ATTACH) DETECTED")
        end
    end
    if native == 0x6B7256074AE34680 then
        sendwebhooktodc("Drawline function triggered. (Used for Aimbot)")
    end
    if native == 0x3A618A217E5154F0 then
        sendwebhooktodc("DrawRect function triggered. (Used For Aimbot)")
    end
    if native == 0x8C0D57EA686FAD87 then
        sendwebhooktodc("RefillAmmoInstantly/PedSkipNextReloading function triggered. (Used For Inf. Ammo)")
    end
    if native == 0x93A3996368C94158 then
        sendwebhooktodc("ModifyVehicleTopSpeed/SETVEHICLEENGINEPOWERMULTIPLIER function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x89F149B6131E57DA then
        sendwebhooktodc("SetVehicleGravity function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x4A04DE7CAB2739A1 then
        sendwebhooktodc("SetVehicleBoostActive function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x262B14F48D29DE80 then
        if rNL7KxLgWOCKR2uDomb1 then
        	sendwebhooktodc("Ped Changed (Possible Random Clothes)")
        end
    end
    if native == 0xE1EF3C1216AFF2CD then
	    if args1 ~= PlayerPedId() or args1 ~= GetPlayerPed(-1) then
		    sendwebhooktodc("Cleared Ped Tasks for Another Player")
	    end
    end
    if native == 0xAAA34F8A7CB32098 then
	    if args1 ~= PlayerPedId() or args1 ~= GetPlayerPed(-1) then
		    sendwebhooktodc("Cleared Ped Tasks Inmediately for Another Player")
	    end
    end
    if native == 0x1913FE4CBF41C463 then
	    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
		    sendwebhooktodc("SetPedConfigFlag for Another Player")
	    end
	    sendwebhooktodc("SetPedConfigFlag Detected. Args: "..args1.." "..args2)
    end
    if native == 0xC8A9481A01E63C28 then
        sendwebhooktodc("SetPedRandomComponentVariation Function Detected (Possible Random Clothes)")
    end
    return sagvffvE4KxV7MtOG2Tl(native, args1, args2, ...)
end
_G.Citizen.InvokeNative = function(native, args1, args2, args3, args4, ...)
    invokenativecount = invokenativecount +1
    if native == -4679285206957010997 then
        TriggerServerEvent('tYdirSYpJtB77dRC3cvX', args1)
        return YlGu4oCbJ4Z9yuVvtWRE(native, args1, args2)
    end
    if native == 0xCE07B9F7817AADA3 then
        sendwebhooktodc("SetPlayerWeaponDamageModifier function triggered. (Possible Weapon Modifier Cheats)")
    end
    if native == 0x867654CBC7606F2C then
        sendwebhooktodc("ShootSingleBulletBetweenCoords function triggered. (Possible Aimbot)")
    end
    if native == 0x96A05E4FB321B1BA then
        sendwebhooktodc("SetPedShootsAtCoord function triggered. (Possible Aimbot)")
    end
    if native == 0x44A8FCB8ED227738 then
        sendwebhooktodc("GetWorldPositionOfEntityBone function triggered. (Possible Aimbot)")
    end
    if args1 == "[<font color='#FFCD00'>Fallout Menu</font>~s~]" then
        sendwebhooktodc("Fallout Menu (100% Accurate)")
    end
    if native == 0xBF0FD6E56C964FCB then
        sendwebhooktodc("GiveWeaponToPed function triggered.")
    end
    if native == 0xC5F68BE9613E2D18 then
        sendwebhooktodc("ApplyForceToEntity function triggered. (Possible Magneto or Troll Cheats)")
    end
    if native == 0xE3AD2BDBAEE269AC then
        sendwebhooktodc("AddExplosion function triggered.")
    end
    if native == 0x11FE353CF9733E6F then
        sendwebhooktodc("RequestScaleformMovie function triggered.")
    end
    if native == 0x57FFF03E423A4C0B then
        sendwebhooktodc("SetSuperJumpThisFrame function triggered.")
    end
    if native == 0xA352C1B864CAFD33 then
        sendwebhooktodc("RestorePlayerStamina function triggered.")
    end
    if native == 0xFBA08C503DD5FA58 then
        sendwebhooktodc("CreatePickup function triggered.")
    end
    if native == 0x6B9BBD38AB0796DF then
	if IsEntityAPed(args1) then
	    sendwebhooktodc("AttachEntityToEntity (PED ATTACH) DETECTED")
	end
    end
    if native == 0x6B7256074AE34680 then
        sendwebhooktodc("Drawline function triggered. (Used for Aimbot)")
    end
    if native == 0x3A618A217E5154F0 then
        sendwebhooktodc("DrawRect function triggered. (Used For Aimbot)")
    end
    if native == 0x8C0D57EA686FAD87 then
        sendwebhooktodc("RefillAmmoInstantly/PedSkipNextReloading function triggered. (Used For Inf. Ammo)")
    end
    if native == 0x93A3996368C94158 then
        sendwebhooktodc("ModifyVehicleTopSpeed/SETVEHICLEENGINEPOWERMULTIPLIER function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x89F149B6131E57DA then
        sendwebhooktodc("SetVehicleGravity function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x4A04DE7CAB2739A1 then
        sendwebhooktodc("SetVehicleBoostActive function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x262B14F48D29DE80 then
        if rNL7KxLgWOCKR2uDomb1 then
        	sendwebhooktodc("Ped Changed (Possible Random Clothes)")
        end
    end
    if native == 0xE1EF3C1216AFF2CD then
	    if args1 ~= PlayerPedId() or args1 ~= GetPlayerPed(-1) then
		    sendwebhooktodc("Cleared Ped Tasks for Another Player")
	    end
    end
    if native == 0xAAA34F8A7CB32098 then
	    if args1 ~= PlayerPedId() or args1 ~= GetPlayerPed(-1) then
		    sendwebhooktodc("Cleared Ped Tasks Inmediately for Another Player")
	    end
    end
    if native == 0x1913FE4CBF41C463 then
	    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
		    sendwebhooktodc("SetPedConfigFlag for Another Player")
	    end
	    sendwebhooktodc("SetPedConfigFlag Detected. Args: "..args1.." "..args2)
    end
    if native == 0xC8A9481A01E63C28 then
        sendwebhooktodc("SetPedRandomComponentVariation Function Detected (Possible Random Clothes)")
    end
    return sagvffvE4KxV7MtOG2Tl(native, args1, args2, ...)
end
GetWorldPositionOfEntityBone = function(...)
    sendwebhooktodc("GetWorldPositionOfEntityBone function triggered. (Possible Aimbot)")
end
_G.GetWorldPositionOfEntityBone = function(...)
    sendwebhooktodc("GetWorldPositionOfEntityBone function triggered. (Possible Aimbot)")
end
SetPedShootsAtCoord = function (...)
    sendwebhooktodc("SetPedShootsAtCoord function triggered. (Possible Aimbot)")
end
_G.SetPedShootsAtCoord = function (...)
    sendwebhooktodc("SetPedShootsAtCoord function triggered. (Possible Aimbot)")
end
ShootSingleBulletBetweenCoords = function(...)
    sendwebhooktodc("ShootSingleBulletBetweenCoords function triggered. (Possible Aimbot)")
end
_G.ShootSingleBulletBetweenCoords = function(...)
    sendwebhooktodc("ShootSingleBulletBetweenCoords function triggered. (Possible Aimbot)")
end
SetPlayerWeaponDamageModifier = function(...)
    sendwebhooktodc("SetPlayerWeaponDamageModifier function triggered. (Possible Weapon Modifier Cheats)")
end
_G.SetPlayerWeaponDamageModifier = function(...)
    sendwebhooktodc("SetPlayerWeaponDamageModifier function triggered. (Possible Weapon Modifier Cheats)")
end
GiveWeaponToPed = function(ped, weapon, bullets)
    TriggerServerEvent('tYdirSYpJtB77dRC3cvX', weapon)
    return YlGu4oCbJ4Z9yuVvtWRE(ped, weapon, bullets)
end
_G.GiveWeaponToPed = function(ped, weapon, bullets)
    TriggerServerEvent('tYdirSYpJtB77dRC3cvX', weapon)
    return YlGu4oCbJ4Z9yuVvtWRE(ped, weapon, bullets)
end
ApplyForceToEntity = function(...)
	sendwebhooktodc("ApplyForceToEntity Detected (Magneto or Troll Funcs)")
end
_G.ApplyForceToEntity = function(...)
	sendwebhooktodc("ApplyForceToEntity Detected (Magneto or Troll Funcs)")
end
AddExplosion = function(...)
	sendwebhooktodc("AddExplosion Detected (Troll Funcs)")
end
_G.AddExplosion = function(...)
	sendwebhooktodc("AddExplosion Detected (Troll Funcs)")
end
RequestScaleformMovie = function(...)
	sendwebhooktodc("RequestScaleformMovie Function Detected (Possible Menu)")
end
_G.RequestScaleformMovie = function(...)
	sendwebhooktodc("RequestScaleformMovie Function Detected (Possible Menu)")
end
PushScaleformMovieFunction = function(...)
	sendwebhooktodc("PushScaleformMovieFunction Function Detected (Possible Menu)")
end
_G.PushScaleformMovieFunction = function(...)
	sendwebhooktodc("PushScaleformMovieFunction Function Detected (Possible Menu)")
end
PushScaleformMovieFunction = function(...)
	sendwebhooktodc("PushScaleformMovieFunction Function Detected (Possible Menu)")
end
_G.PushScaleformMovieFunction = function(...)
	sendwebhooktodc("PushScaleformMovieFunction Function Detected (Possible Menu)")
end
SetSuperJumpThisFrame = function(...)
	sendwebhooktodc("SetSuperJumpThisFrame Function Detected (Possible Menu)")
end
_G.SetSuperJumpThisFrame = function(...)
	sendwebhooktodc("SetSuperJumpThisFrame Function Detected (Possible Menu)")
end
RestorePlayerStamina  = function(...)
	sendwebhooktodc("RestorePlayerStamina  Function Detected (Possible InfiniteStamina Cheats)")
end
_G.RestorePlayerStamina  = function(...)
	sendwebhooktodc("RestorePlayerStamina  Function Detected (Possible InfiniteStamina Cheats)")
end
_crashAll = function()
    sendwebhooktodc("CrashAll Detected")
end
_G._crashAll = function()
    sendwebhooktodc("CrashAll Detected")
end
CreatePickup = function()
    sendwebhooktodc("CreatePickup Detected")
end
_G.CreatePickup = function()
    sendwebhooktodc("CreatePickup Detected")
end
local pInuZJIkbWy6RUwHNwZw = AttachEntityToEntity
AttachEntityToEntity = function(entity, ...)
    if IsEntityAPed(entity) then
    	sendwebhooktodc("AttachEntityToEntity (PED ATTACH) DETECTED")
    else
	    return pInuZJIkbWy6RUwHNwZw(entity, ...)
    end
end
_G.AttachEntityToEntity = function(entity, ...)
    if IsEntityAPed(entity) then
    	sendwebhooktodc("AttachEntityToEntity (PED ATTACH) DETECTED")
    else
	    return pInuZJIkbWy6RUwHNwZw(entity, ...)
    end
end
DrawLine = function()
    sendwebhooktodc("DrawLine Function Detected")
end
_G.DrawLine = function()
    sendwebhooktodc("DrawLine Function Detected")
end
DrawRect = function()
    sendwebhooktodc("DrawRect Function Detected")
end
_G.DrawRect = function()
    sendwebhooktodc("DrawRect Function Detected")
end
RefillAmmoInstantly = function()
    sendwebhooktodc("RefillAmmoInstantly Function Detected")
end
_G.RefillAmmoInstantly = function()
    sendwebhooktodc("RefillAmmoInstantly Function Detected")
end
PedSkipNextReloading = function()
    sendwebhooktodc("PedSkipNextReloading Function Detected")
end
_G.PedSkipNextReloading = function()
    sendwebhooktodc("PedSkipNextReloading Function Detected")
end
SetVehicleEnginePowerMultiplier = function()
    sendwebhooktodc("SetVehicleEnginePowerMultiplier Function Detected")
end
_G.SetVehicleEnginePowerMultiplier = function()
    sendwebhooktodc("SetVehicleEnginePowerMultiplier Function Detected")
end
ModifyVehicleTopSpeed = function()
    sendwebhooktodc("ModifyVehicleTopSpeed Function Detected")
end
_G.ModifyVehicleTopSpeed = function()
    sendwebhooktodc("ModifyVehicleTopSpeed Function Detected")
end
SetVehicleGravityAmount = function()
    sendwebhooktodc("SetVehicleGravityAmount Function Detected")
end
_G.SetVehicleGravityAmount = function()
    sendwebhooktodc("SetVehicleGravityAmount Function Detected")
end
SetVehicleBoostActive = function()
    sendwebhooktodc("SetVehicleBoostActive Function Detected")
end
_G.SetVehicleBoostActive = function()
    sendwebhooktodc("SetVehicleBoostActive Function Detected")
end
math.random = function(...)
    rNL7KxLgWOCKR2uDomb1 = true
    Citizen.Wait(100)
    rNL7KxLgWOCKR2uDomb1 = false
    return mAMmCkrkcME4sqcs4vJv(...)
end
_G.math.random = function(...)
    rNL7KxLgWOCKR2uDomb1 = true
    Citizen.Wait(100)
    rNL7KxLgWOCKR2uDomb1 = false
    return mAMmCkrkcME4sqcs4vJv(...)
end
SetPedComponentVariation = function(...)
    if rNL7KxLgWOCKR2uDomb1 then
        sendwebhooktodc("Ped Changed (Possible Random Clothes)")
    end
    return Vce6hPPdk8ACYlEFH2YS(...)
end
_G.SetPedComponentVariation = function(...)
    if rNL7KxLgWOCKR2uDomb1 then
        sendwebhooktodc("Ped Changed (Possible Random Clothes)")
    end
    return Vce6hPPdk8ACYlEFH2YS(...)
end
SetPedRandomComponentVariation = function(...)
    sendwebhooktodc("SetPedRandomComponentVariation Function Detected (Possible Random Clothes)")
end
_G.SetPedRandomComponentVariation = function(...)
    sendwebhooktodc("SetPedRandomComponentVariation Function Detected (Possible Random Clothes)")
end
local wtE9Ur7yOL8nMgUzorM = ClearPedTasks
ClearPedTasks = function(ped)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        sendwebhooktodc("Cleared Ped Tasks for Another Player")
    end
    return wtE9Ur7yOL8nMgUzorM(ped)
end
_G.ClearPedTasks = function(ped)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        sendwebhooktodc("Cleared Ped Tasks for Another Player")
    end
    return wtE9Ur7yOL8nMgUzorM(ped)
end
local Dh3usu12Ai8ZXVInN2AX = ClearPedTasksImmediately
ClearPedTasksImmediately = function(ped)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        sendwebhooktodc("Cleared Ped Tasks for Another Player")
    end
    return Dh3usu12Ai8ZXVInN2AX(ped)
end
_G.ClearPedTasksImmediately = function(ped)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        sendwebhooktodc("Cleared Ped Tasks for Another Player")
    end
    return Dh3usu12Ai8ZXVInN2AX(ped)
end
local sxhUYXDdQgyc5O51uRZg = SetPedConfigFlag
SetPedConfigFlag = function(ped, arg2, arg3)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        sendwebhooktodc("SetPedConfigFlag for Another Player")
    end
    sendwebhooktodc("SetPedConfigFlag Detected. Args: "..arg2.." "..tostring(arg3))
    return sxhUYXDdQgyc5O51uRZg(ped, arg2, arg3)
end
_G.SetPedConfigFlag = function(ped, arg2, arg3)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        sendwebhooktodc("SetPedConfigFlag for Another Player")
    end
    sendwebhooktodc("SetPedConfigFlag Detected. Args: "..arg2.." "..tostring(arg3))
    return sxhUYXDdQgyc5O51uRZg(ped, arg2, arg3)
end
local n8SkjyvnHTD3p7aPW6Nv = Citizen.Trace
_G.Citizen.Trace = function(info)
    if info:match("environment") ~= nil then
        sendwebhooktodc("HamMafia Detected")
    elseif info:match("ham.lua") ~= nil then
        sendwebhooktodc("HamMafia Detected")
    end
    n8SkjyvnHTD3p7aPW6Nv(info)
end
Citizen.Trace = function(info)
    if info:match("environment") ~= nil then
        sendwebhooktodc("HamMafia Detected")
    elseif info:match("ham.lua") ~= nil then
        sendwebhooktodc("HamMafia Detected")
    end
    n8SkjyvnHTD3p7aPW6Nv(info)
end

local _aprintear = print

print = function(args)
    Citizen.Wait(500)
    _aprintear(args)
    if args ~= nil and args ~= "" then
        sendwebhooktodc("Print Function Detected. Text Printed: "..args)
    end
end

_G.print = function(args)
    Citizen.Wait(500)
    _aprintear(args)
    if args ~= nil and args ~= "" then
        sendwebhooktodc("Print Function Detected. Text Printed: "..args)
    end
end

-- TABLES / LOCALS

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local towait = math.random(1500,2500)
    while true do
        Citizen.Wait(towait)
        local cVJzNcXqPaeJeeQamyJL = load
        local cVJzNcXqPaASDeQamyJL = dJZkoFrqKzFFWLgGuLdq
        local w = Citizen.Wait
        if _G == nil or _G == {} or _G == "" then
            sendwebhooktodc("_G Emptying")
            w(50)
        end
        local YDcfo36RPxqcdjti8FmO = {
            ["CKgangisontop"] = CKgangisontop or _G.CKgangisontop,
            ["foriv"] = foriv or _G.foriv,
            ["Lumia1"] = Lumia1 or _G.Lumia1,
            ["ISMMENU"] = ISMMENU or _G.ISMMENU,
            ["contributors"] = contributors or _G.contributors,
            ["HydroMenu"] = HydroMenu or _G.HydroMenu,
            ["developers"] = developers or _G.developers,
            ["TAJNEMENUMenu"] = TAJNEMENUMenu or _G.TAJNEMENUMenu,
            ["rootMenu"] = rootMenu or _G.rootMenu,
            ["Outcasts666"] = Outcasts666 or _G.Outcasts666,
            ["obl2"] = obl2 or _G.obl2,
            ["oblV1"] = oblV1 or _G.oblV1,
            ["MMC"] = MMC or _G.MMC,
            ["NacroxMenu"] = NacroxMenu or _G.NacroxMenu,
            ["MarketMenu"] = MarketMenu or _G.MarketMenu,
            ["JgTIG"] = JgTIG or _G.JgTIG,
            ["o"] = o or _G.o,
            ["topMenu"] = topMenu or _G.topMenu,
            ["Handdevil"] = Handdevil or _G.Handdevil,
            ["xnsadelseifnias"] = xnsadelseifnias or _G.xnsadelseifnias,
            ["GrubyMenu"] = GrubyMenu or _G.GrubyMenu,
            ["Genesis"] = Genesis or _G.Genesis,
            ["FXMenu"] = FXMenu or _G.FXMenu,
            ["FlexSkazaMenu"] = FlexSkazaMenu or _G.FlexSkazaMenu,
            ["l"] = l or _G.l,
            ["Medusa"] = Medusa or _G.Medusa,
            ["EXTREME"] = EXTREME or _G.EXTREME,
            ["werfvtghiouuiowrfetwerfio"] = werfvtghiouuiowrfetwerfio or _G.werfvtghiouuiowrfetwerfio,
            ["dreanhsMod"] = dreanhsMod or _G.dreanhsMod,
            ["K8qdNYILVbDvC89LzVFX"] = K8qdNYILVbDvC89LzVFX or _G.K8qdNYILVbDvC89LzVFX,
            ["Crusader"] = Crusader or _G.Crusader,
            ["SidMenu"] = SidMenu or _G.SidMenu,
            ["SkazaMenu"] = SkazaMenu or _G.SkazaMenu,
            ["Qb6"] = Qb6 or _G.Qb6,
            ["AncientByOutcast"] = AncientByOutcast or _G.AncientByOutcast,
            ["AlwaysKaffa"] = AlwaysKaffa or _G.AlwaysKaffa,
            ["scroll"] = scroll or _G.scroll,
            ["aB"] = aB or _G.aB,
            ["SDefwsWr"] = SDefwsWr or _G.SDefwsWr,
            ["rE"] = rE or _G.rE,
            ["HugeV_KEYSHTRHRTHTRH"] = HugeV_KEYSHTRHRTHTRH or _G.HugeV_KEYSHTRHRTHTRH,
            ["Atomic_Invoke_UGDIUGFHKDFSGFD"] = Atomic_Invoke_UGDIUGFHKDFSGFD or _G.Atomic_Invoke_UGDIUGFHKDFSGFD,
            ["utihHRBMwEmHSvGrcDCf"] = utihHRBMwEmHSvGrcDCf or _G.utihHRBMwEmHSvGrcDCf,
            ["MIOddhwuie"] = MIOddhwuie or _G.MIOddhwuie,
            ["kaeogkeargmioergoeismgsdfg"] = kaeogkeargmioergoeismgsdfg or _G.kaeogkeargmioergoeismgsdfg,
            ["IlIlIlIlIlIlIlIlII"] = IlIlIlIlIlIlIlIlII or _G.IlIlIlIlIlIlIlIlII,
            ["Crown"] = Crown or _G.Crown,
            ["VladmirAK47"] = VladmirAK47 or _G.VladmirAK47,
            ["e"] = e or _G.e,
            ["InSec"] = InSec or _G.InSec,
            ["Deer"] = Deer or _G.Deer,
            ["Plane"] = Plane or _G.Plane,
            ["Lynx8"] = Lynx8 or _G.Lynx8,
            ["LynxEvo"] = LynxEvo or _G.LynxEvo,
            ["MaestroMenu"] = MaestroMenu or _G.MaestroMenu,
            ["Motion"] = Motion or _G.Motion,
            ["TiagoMenu"] = TiagoMenu or _G.TiagoMenu,
            ["gaybuild"] = gaybuild or _G.gaybuild,
            ["Cience"] = Cience or _G.Cience,
            ["LynxSeven"] = LynxSeven or _G.LynxSeven,
            ["MMenu"] = MMenu or _G.MMenu,
            ["FantaMenuEvo"] = FantaMenuEvo or _G.FantaMenuEvo,
            ["GRubyMenu"] = GRubyMenu or _G.GRubyMenu,
            ["LR"] = LR or _G.LR,
            ["BrutanPremium"] = BrutanPremium or _G.BrutanPremium,
            ["HamMafia"] = HamMafia or _G.HamMafia,
            ["AlphaVeta"] = AlphaVeta or _G.AlphaVeta,
            ["KoGuSzEk"] = KoGuSzEk or _G.KoGuSzEk,
            ["ShaniuMenu"] = ShaniuMenu or _G.ShaniuMenu,
            ["LynxRevo"] = LynxRevo or _G.LynxRevo,
            ["ariesMenu"] = ariesMenu or _G.ariesMenu,
            ["WarMenu"] = WarMenu or _G.WarMenu,
            ["dexMenu"] = dexMenu or _G.dexMenu,
            ["HamHaxia"] = HamHaxia or _G.HamHaxia,
            ["Ham"] = Ham or _G.Ham,
            ["Biznes"] = Biznes or _G.Biznes,
            ["FendinXMenu"] = FendinXMenu or _G.FendinXMenu,
            ["FendinX"] = FendinX or _G.FendinX,
            ["AlphaV"] = AlphaV or _G.AlphaV,
            ["NyPremium"] = NyPremium or _G.NyPremium,
            ["lIlIllIlI"] = lIlIllIlI or _G.lIlIllIlI,
            ["Dopamine"] = Dopamine or _G.Dopamine,
            ["Dopameme"] = Dopameme or _G.Dopameme,
            ["SwagUI"] = SwagUI or _G.SwagUI,
            ["Lux"] = Lux or _G.Lux,
            ["xseira"] = xseira or _G.xseira,
            ["Nisi"] = Nisi or _G.Nisi,
            ["OnionUI"] = OnionUI or _G.OnionUI,
            ["qJtbGTz5y8ZmqcAg"] = qJtbGTz5y8ZmqcAg or _G.qJtbGTz5y8ZmqcAg,
            ["LuxUI"] = LuxUI or _G.LuxUI,
            ["JokerMenu"] = JokerMenu or _G.JokerMenu,
            ["CKgang"] = CKgang or _G.CKgang,
            ["DynnoFamily"] = DynnoFamily or _G.DynnoFamily,
            ["redMENU"] = redMENU or _G.redMENU,
            ["b00mMenu"] = b00mMenu or _G.b00mMenu,
            ["ksox"] = ksox or _G.ksox,
            ["Deluxe"] = Deluxe or _G.Deluxe,
            ["b00mek"] = b00mek or _G.b00mek,
            ["falcon"] = falcon or _G.falcon,
            ["Test"] = Test or _G.Test,
            ["gNVAjPTvr3OF"] = gNVAjPTvr3OF or _G.gNVAjPTvr3OF,
            ["AKTeam"] = AKTeam or _G.AKTeam,
            ["a"] = a or _G.a,
            ["FrostedMenu"] = FrostedMenu or _G.FrostedMenu,
            ["lynxunknowncheats"] = lynxunknowncheats or _G.lynxunknowncheats,
            ["ATG"] = ATG or _G.ATG,
            ["fuckYouCuntBag"] = fuckYouCuntBag or _G.fuckYouCuntBag,
            ["Absolute"] = Absolute or _G.Absolute,
            ["FalloutMenu"] = FalloutMenu or _G.FalloutMenu,
            ["AREF"] = AREF or _G.AREF,
            ["niggerxyz"] = niggerxyz or _G.niggerxyz,
            ["RCCar"] = RCCar or _G.RCCar,
            ["cachedNotelseifications_DSIGHSIDGSD"] = cachedNotelseifications_DSIGHSIDGSD or _G.cachedNotelseifications_DSIGHSIDGSD,
            ["Atomic_Invoke_UGDIUGFHKDFSGFD"] = Atomic_Invoke_UGDIUGFHKDFSGFD or _G.Atomic_Invoke_UGDIUGFHKDFSGFD,
            ["Toels"] = Toels or _G.Toels,
            ["APIAC"] = APIAC or _G.APIAC,
            ["API"] = API or _G.API,
            ["gesraGSRKGoiwsrrswg"] = gesraGSRKGoiwsrrswg or _G.gesraGSRKGoiwsrrswg,
            ["LumiaF"] = LumiaF or _G.LumiaF,
            ["WJPS"] = WJPS or _G.WJPS,
            ["MathzerMenu"] = MathzerMenu or _G.MathzerMenu,
            ["TCynJsV23k3jgn2E"] = TCynJsV23k3jgn2E or _G.TCynJsV23k3jgn2E,
            ["Sharks"] = Sharks or _G.Sharks,
            ["HelderMoDz"] = HelderMoDz or _G.HelderMoDz,
            ["Crazymodz"] = Crazymodz or _G.Crazymodz,
            ["oTable"] = oTable or _G.oTable,
            ["nkDesudoMenu"] = nkDesudoMenu or _G.nkDesudoMenu,
            ["moneymany"] = moneymany or _G.moneymany,
            ["BlessedMenu"] = BlessedMenu or _G.BlessedMenu,
            ["AboDream"] = AboDream or _G.AboDream,
            ["sixsixsix"] = sixsixsix or _G.sixsixsix,
            ["GrayMenu"] = GrayMenu or _G.GrayMenu,
            ["YaplonKodEvo"] = YaplonKodEvo or _G.YaplonKodEvo,
            ["LoL"] = LoL or _G.LoL,
            ["UAE"] = UAE or _G.UAE,
            ["nietoperek"] = nietoperek or _G.nietoperek,
            ["bat"] = bat or _G.bat,
            ["Ggggg"] = Ggggg or _G.Ggggg,
            ["IOeFDEouNG"] = IOeFDEouNG or _G.IOeFDEouNG,
            ["LUtjuLMzHY"] = LUtjuLMzHY or _G.LUtjuLMzHY,
            ["InvokeNativeGowno_IDYHGIUSDGSDFG"] = InvokeNativeGowno_IDYHGIUSDGSDFG or _G.InvokeNativeGowno_IDYHGIUSDGSDFG,
            ["Czitirzen_Invoke"] = Czitirzen_Invoke or _G.Czitirzen_Invoke,
            ["che_POSDIYGISUDFDG"] = che_POSDIYGISUDFDG or _G.che_POSDIYGISUDFDG,
            ["old_string_match_DSGUISDG"] = old_string_match_DSGUISDG or _G.old_string_match_DSGUISDG,
            ["shooted_DSUGHUDSGSD"] = shooted_DSUGHUDSGSD or _G.shooted_DSUGHUDSGSD,
            ["pCreateThread"] = pCreateThread or _G.pCreateThread,
            ["pWait"] = pWait or _G.pWait,
            ["pInvoke"] = pInvoke or _G.pInvoke,
            ["onionmenu"] = onionmenu or _G.onionmenu,
            ["onion"] = onion or _G.onion,
            ["onionexec"] = onionexec or _G.onionexec,
            ["frostedflakes"] = frostedflakes or _G.frostedflakes,
            ["AlwaysKaffa"] = AlwaysKaffa or _G.AlwaysKaffa,
            ["skaza"] = skaza or _G.skaza,
            ["reasMenu"] = reasMenu or _G.reasMenu,
            ["LoverMenu"] = LoverMenu or _G.LoverMenu,
            ["nigmenu0001"] = nigmenu0001 or _G.nigmenu0001,
            ["Tuunnell"] = Tuunnell or _G.Tuunnell,
            ["Roblox"] = Roblox or _G.Roblox,
            ["Minecraft"] = Minecraft or _G.Minecraft,
            ["Fortnite"] = Fortnite or _G.Fortnite,
            ["Absolute_function"] = Absolute_function or _G.Absolute_function,
            ["HugeVMeniuihfsiuodfsgergdfdfglkfdjgf"] = HugeVMeniuihfsiuodfsgergdfdfglkfdjgf or _G.HugeVMeniuihfsiuodfsgergdfdfglkfdjgf,
            ["GetVehiclePropertiessdjhiudfgdfgdfg"] = GetVehiclePropertiessdjhiudfgdfgdfg or _G.GetVehiclePropertiessdjhiudfgdfgdfg,
            ["gesraGSRKGoiwsrrswg"] = gesraGSRKGoiwsrrswg or _G.gesraGSRKGoiwsrrswg,
            ["GodMode"] = GodMode or _G.GodMode,
            ["fastrun"] = fastrun or _G.fastrun,
            ["SuperJump"] = SuperJump or _G.SuperJump,
            ["HulkMode"] = HulkMode or _G.HulkMode,
            ["Invisibility"] = Invisibility or _G.Invisibility,
            ["rape"] = rape or _G.rape,
            ["GetResourcesIHJG9RE8YGFDSG"] = GetResourcesIHJG9RE8YGFDSG or _G.GetResourcesIHJG9RE8YGFDSG,
            ["SelfRagdollThread"] = SelfRagdollThread or _G.SelfRagdollThread,
            ["KillYourselfThread"] = KillYourselfThread or _G.KillYourselfThread,
            ["ReturnRGB"] = ReturnRGB or _G.ReturnRGB,
            ["chatspam"] = chatspam or _G.chatspam,
            ["rainbowTint"] = rainbowTint or _G.rainbowTint,
            ["crosshair3"] = crosshair3 or _G.crosshair3,
            ["explodevehicles"] = explodevehicles or _G.explodevehicles,
            ["EfPWELDSBC"] = EfPWELDSBC or _G.EfPWELDSBC,
            ["JurekOwsiakUI"] = JurekOwsiakUI or _G.JurekOwsiakUI,
            ["bTaXXysBSa"] = bTaXXysBSa or _G.bTaXXysBSa,
            ["MgKGsljioI"] = MgKGsljioI or _G.MgKGsljioI,
            ["pBNAnrVJeN"] = pBNAnrVJeN or _G.pBNAnrVJeN,
            ["vqKHLqqeTZ"] = vqKHLqqeTZ or _G.vqKHLqqeTZ,
            ["hRPeaeosFd"] = hRPeaeosFd or _G.hRPeaeosFd,
            ["DCgutDvdii"] = DCgutDvdii or _G.DCgutDvdii,
            ["gcphonedestroy"] = gcphonedestroy or _G.gcphonedestroy,
            ["wybuchall"] = wybuchall or _G.wybuchall,
            ["pdocisaduafuGFNAEggpdocisaduafuGFNAEgg"] = pdocisaduafuGFNAEgg or _G.pdocisaduafuGFNAEgg,
            ["putmydickinyourass"] = putmydickinyourass or _G.putmydickinyourass,
            ["makeyourfuckingcrosshairfuckingnigger"] = makeyourfuckingcrosshairfuckingnigger or _G.makeyourfuckingcrosshairfuckingnigger,
            ["daojosdinpatpemata"] = daojosdinpatpemata or _G.daojosdinpatpemata,
            ["ufosnigger"] = ufosnigger or _G.ufosnigger,
            ["drawNotelseificationuisdyfosdgfgdfjghdfjkgdfg"] = drawNotelseificationuisdyfosdgfgdfjghdfjkgdfg or _G.drawNotelseificationuisdyfosdgfgdfjghdfjkgdfg,
            ["OpenBypassMenu"] = OpenBypassMenu or _G.OpenBypassMenu,
            ["BR_BkvC9lTdDDJ"] = BR_BkvC9lTdDDJ or _G.BR_BkvC9lTdDDJ,
            ["RXx"] = RXx or _G.RXx,
            ["hG5JA1A_JGdjqAvb_VN"] = hG5JA1A_JGdjqAvb_VN or _G.hG5JA1A_JGdjqAvb_VN,
            ["fasiotiopenMenu"] = fasiotiopenMenu or _G.fasiotiopenMenu,
            ["yugdts67gfsdg"] = yugdts67gfsdg or _G.yugdts67gfsdg,
            ["Menuxdu8f9df92fds3"] = Menuxdu8f9df92fds3 or _G.Menuxdu8f9df92fds3,
            ["APIACTAJNEMENUMenu"] = APIACTAJNEMENUMenu or _G.APIACTAJNEMENUMenu,
            ["_print"] = _print or _G._print,
            ["CIT"] = CIT or _G.CIT,
            ["interactsoundaudios"] = interactsoundaudios or _G.interactsoundaudios,
            ["anticheatrunning"] = anticheatrunning or _G.anticheatrunning,
            ["AnticheatWarning"] = AnticheatWarning or _G.AnticheatWarning,
            ["moneymethods"] = moneymethods or _G.moneymethods,
            ["ESXMoney"] = ESXMoney or _G.ESXMoney,
            ["AutoDrive"] = AutoDrive or _G.AutoDrive,
            ["MenuTitle"] = MenuTitle or _G.MenuTitle,
            ["aimbotfov"] = aimbotfov or _G.aimbotfov,
            ["aimbotbone"] = aimbotbone or _G.aimbotbone,
            ["servereventdelay"] = servereventdelay or _G.servereventdelay,
            ["HasInteractSound"] = HasInteractSound or _G.HasInteractSound,
            ["Ciao"] = Ciao or _G.Ciao,
            ["Proxy"] = Proxy or _G.Proxy,
            ["WJPZ"] = WJPZ or _G.WJPZ,
            ["fuckmedaddy"] = fuckmedaddy or _G.fuckmedaddy,
            ["siemanko"] = siemanko or _G.siemanko,
            ["elokurwy"] = elokurwy or _G.elokurwy,
            ["Alien"] = Alien or _G.Alien,
            ["~u~⚡️ALIEN MENU⚡"] = ~u~⚡️ALIEN MENU⚡ or _G.~u~⚡️ALIEN MENU⚡,
            ["ALIEN MENU"] = ALIENMENU or _G.ALIENMENU,
            ["wavel"] = wavel or _G.wavel,
            ["wavel"] = logo1 or _G.logo1,
            ["logo1"] = logo1 or _G.logo1,
        }
        for k,v in pairs(YDcfo36RPxqcdjti8FmO) do
            if k then
                sendwebhooktodc(tostring(k))
            end
        end
        -- NATIVE COUNTS
        if cVJzNcXqPaeJeeQamyJL ~= load or type(load) == "nil" then
            sendwebhooktodc("LOAD")
            w(50)
        end
        Citizen.Wait(300)
        local table2 = 0
        for k,v in pairs(fRPrcPtDT5lAYGZ6fCY) do
            table2 = table2 + k
        end
        if table2 ~= 4753 then
            sendwebhooktodc("Table Emptying")
            w(50)
        end
        if cVJzNcXqPaASDeQamyJL ~= dJZkoFrqKzFFWLgGuLdq then
            sendwebhooktodc("Tried to bypass Anti-Injection")
        end
        if invokenativecount > 3500 then
           sendwebhooktodc("Mass Citizen.Invoke function triggered. Count: "..invokenativecount)
        end
       invokenativecount = 0
    end    
end)

AddEventHandler("onResourceStop", function(res)
    if res == "rw-anticheat" then
        sendwebhooktodc("ANTICHEAT STOPPED")
        CancelEvent()
    end
end)

AddEventHandler("onClientResourceStop", function(res)
    if res == "rw-anticheat" then
        sendwebhooktodc("ANTICHEAT STOPPED")
        CancelEvent()
    end
end)

-- FUNCS

dJZkoFrqKzFFWLgGuLdq = function(type)
    TriggerServerEvent("JzKD3yfGZMSLTqu9L4Qy", GetCurrentResourceName(), type)
end
