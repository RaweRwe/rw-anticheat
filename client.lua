ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

---------------------------------------------------
--------------   OPTIMIZED LOOPS    ---------------
---------------------------------------------------

-- General Status Loop (Medium Tick: 1000ms)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local ped = PlayerPedId()
        local pid = PlayerId()
        
        -- Anti GodMode (Health Check)
        if Config.AntiGodMode then
            local health = GetEntityHealth(ped)
            if GetPlayerInvincible(pid) then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "godmode", "4") 
                SetPlayerInvincible(pid, false)
            end
            
            -- Heal check logic could go here but it's complex to sync with legit healing.
            -- Using basic max health check:
            if health > 200 then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "godmode", "2") 
            end
        end

        -- Anti Invisible
        if Config.AntiInvisible then
            local alpha = GetEntityAlpha(ped)
            if not IsEntityVisible(ped) or not IsEntityVisibleToScript(ped) or alpha <= 150 then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "invisible") 
            end
        end

        -- Anti Radar
        if Config.AntiRadar then
             -- Only check if not in vehicle (some servers enable radar in vehicle)
            if not IsRadarHidden() and not IsPedInAnyVehicle(ped, true) then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "displayradar") 
            end
        end
        
        -- Anti Spectate
        if Config.AntiSpectate and NetworkIsInSpectatorMode() then
            TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "spectatormode")
        end

        -- Anti Thermal/Night Vision
        if Config.AntiThermalVision and GetUsingseethrough() then
            TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "thermalvision") 
        end
        if Config.AntiNightVision and GetUsingnightvision() then
            TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "nightvision")
        end

        -- Anti Resource Start/Stop (Count Check)
        if Config.AntiResourceStartorStop then 
            local resCount = GetNumResources()
            if resources and resources ~= resCount then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "antiresourcestop")
            end
            resources = resCount -- Update to avoid spam loop if not banned immediately
        end
        
         -- Anti Ped Change
         if Config.AntiPedChange then
             if not _originalped then _originalped = GetEntityModel(ped) end
            if _originalped ~= GetEntityModel(ped) then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "pedchanged")
            end
        end
    end
end)

-- Fast Loop (Short Tick: 200ms or 0ms for specific checks)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local ped = PlayerPedId()
        
        -- Cleanup / enforcement
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
        SetSwimMultiplierForPlayer(PlayerId(), 1.0)
        SetPedInfiniteAmmoClip(ped, false)
        
        if Config.AntiExplosionDamage then
            SetEntityProofs(ped, false, true, true, false, false, false, false, false)
        end
        
        if Config.AntiAimAssist then
             SetPlayerTargetingMode(0)
             if GetLocalPlayerAimState() ~= 3 and not IsPedInAnyVehicle(ped, true) then
                 TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "aimassist", GetLocalPlayerAimState()) 
             end
        end
        
        -- Anti SpeedHack (Basic speed check)
        if Config.AntiSpeedHacks then
            if not IsPedInAnyVehicle(ped, true) and GetEntitySpeed(ped) > 10 and not IsPedFalling(ped) and not IsPedInParachuteFreeFall(ped) and not IsPedRagdoll(ped) then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "speedhack") 
            end
        end
        
        -- Anti SuperJump
        if Config.SuperJump and IsPedJumping(ped) then
            TriggerServerEvent('8jWpZudyvjkDXQ2RVXf9', "superjump")
        end

        -- Anti Explosive Bullets
        if Config.AntiExplosiveBullets then
            local dmgType = GetWeaponDamageType(GetSelectedPedWeapon(ped))
            if dmgType == 4 or dmgType == 5 or dmgType == 6 or dmgType == 13 then
                TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "explosiveweapon")
            end
        end
        
        -- Anti Blacklisted Weapons
        if Config.AntiBlacklistedWeapons then
             for _, weapon in ipairs(Config.BlacklistedWeapons) do
                if HasPedGotWeapon(ped, weapon, false) then
                    RemoveAllPedWeapons(ped, true)
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "blacklistedweapons") 
                    break
                end
            end
        end
        
        -- Anti Give Armor
        if Config.AntiGiveArmor and GetPedArmour(ped) > 100 then
             TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "givearmour") 
        end
    end
end)

-- Blacklisted Tasks & Anims (1000ms is enough)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if Config.AntiBlacklistedTasks then
            local ped = PlayerPedId()
            for _, task in pairs(Config.BlacklistedTasks) do
                if GetIsTaskActive(ped, task) then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "blacklistedtask", task)
                end
            end
        end
         if Config.AntiBlacklistedAnims then
             local ped = PlayerPedId()
            for _, anim in pairs(Config.BlacklistedAnims) do
                if IsEntityPlayingAnim(ped, anim[1], anim[2], 3) then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "blacklistedanim", json.encode(anim))
                    ClearPedTasksImmediately(ped)
                end
            end
        end
    end
end)


-- Anti Noclip (Client Side) - Runs every 1s
if Config.AntiNoclip then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped, false) and not IsPedFalling(ped) and not IsPedRagdoll(ped) then
                local pos = GetEntityCoords(ped)
                Citizen.Wait(1000)
                local newPos = GetEntityCoords(ped)
                local dist = #(pos - newPos)
                if dist > 25.0 and not IsPedInParachuteFreeFall(ped) and not IsEntityDead(ped) then
                     TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "noclip", "Dist: " .. math.ceil(dist))
                end
            end
        end
    end)
end

-- Anti Silent Aim & Aimbot (Frame Loop)
-- Optimized: Only checks when shooting
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if Config.AntiSilentAim and IsPedShooting(ped) then
            local _, hitEntity = GetEntityPlayerIsFreeAimingAt(PlayerId())
            if not hitEntity or hitEntity == 0 then
                local found, coords = GetPedLastWeaponImpactCoord(ped)
                if found then
                    local camRot = GetGameplayCamRot(2)
                    local camHeading = (-camRot.z) * 0.0174533
                    local camPitch = camRot.x * 0.0174533
                    local camVec = vector3(-math.sin(camHeading) * math.cos(camPitch), math.cos(camHeading) * math.cos(camPitch), math.sin(camPitch))
                    local headPos = GetPedBoneCoords(ped, 31086, 0.0, 0.0, 0.0)
                    local hitVec = coords - headPos
                    local dist = #(hitVec)
                    hitVec = hitVec / dist
                    local angle = math.acos(dot(camVec, hitVec)) * 57.2958
                    if angle > (Config.MaxFOV or 30.0) and dist > 5.0 then
                        TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "silentaim", "Angle: " .. math.floor(angle))
                    end
                end
            end
        end
    end
end)

function dot(v1, v2)
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
end

-- Events Setup
local _evhandler = AddEventHandler
_evhandler("onClientResourceStop", function(resourceName)
    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "stoppedresource", resourceName)
end)

_evhandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "stoppedac")
end)

-- Heartbeat
if Config.Heartbeat then
    RegisterNetEvent("rwe:HeartbeatCheck")
    AddEventHandler("rwe:HeartbeatCheck", function(token)
        Config.SecurityToken = token
        TriggerServerEvent("rwe:HeartbeatReturn", token)
    end)
end

-- Screenshot
RegisterNetEvent("fuckyourself")
AddEventHandler("fuckyourself", function()
    local webhook = Config.OCRWebhook ~= "" and Config.OCRWebhook or Config.WebhookDiscord
    exports["screenshot-basic"]:requestScreenshotUpload(webhook, "files[]", function() end)
end)

-- Anti Damage Modifier
if Config.AntiDamageModifier then
    AddEventHandler('gameEventTriggered', function(event, args)
        if event == "CEventNetworkEntityDamage" then
            local victim, attacker, damage, weapon = table.unpack(args)
            if attacker == PlayerPedId() and IsEntityAPed(victim) then
                local weaponGroup = GetWeapontypeGroup(weapon)
                if weaponGroup ~= 416676503 and damage > 400 then 
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "damagemodifier", "Damage: " .. damage)
                end
            end
        end
    end)
end

-- Cleaned up Anti-Menu (Lua)
-- Keeping the loop simpler and slower
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
    {txd = "Hydramenu", txt="hydramenu", name="Hydra Menu"},
    {txd = "dopamine", txt="Swagamine", name="Dopamine"},
    {txd = "HydroMenu", txt="HydroMenuHeader", name="Hydro Menu"},
    {txd = "HydroMenu", txt="HydroMenuLogo", name="Hydro Menu"},
    {txd = "HydroMenu", txt="https://i.ibb.co/0GhPPL7/Hydro-New-Header.png", name="Hydro Menu"},
    {txd = "test", txt="Terror Menu", name="Terror Menu"},
    {txd = "lynxmenu", txt="lynxmenu", name="Lynx Menu"},
    {txd = "Maestro 2.3", txt="Maestro 2.3", name="Maestro Menu"},
    {txd = "ALIEN MENU", txt="ALIEN MENU", name="Alien Menu"},
    {txd = "~u~⚡️ALIEN MENU⚡️", txt="~u~⚡️ALIEN MENU⚡️", name="Alien Menu"}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- Check every 5 seconds is enough
        for i, data in pairs(DetectableTextures) do
            if data.x and data.y then
                if GetTextureResolution(data.txd, data.txt).x == data.x and GetTextureResolution(data.txd, data.txt).y == data.y then
                    TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "menyoo", "Lua Menu: " .. data.name)
                end
            else 
                if GetTextureResolution(data.txd, data.txt).x ~= 4.0 then
                     TriggerServerEvent("8jWpZudyvjkDXQ2RVXf9", "menyoo", "Lua Menu: " .. data.name)
                end
            end
             Citizen.Wait(10) -- Tiny wait to prevent frame drop during huge list check
        end
    end
end)
