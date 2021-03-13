vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","mo-pepperspray")

cCallback = {
    TriggerServerCallback = function(self, name, args, cb)
        TriggerServerEvent("mo-pepperspray:TriggerServerCallback", name, args)
        while self[name] == nil do
            Wait(1)
        end
        cb(self[name])
    end
}
RegisterNetEvent("mo-pepperspray:RecieveServerCallback")
AddEventHandler("mo-pepperspray:RecieveServerCallback", function(name, data)
    cCallback[name] = data
end)

function Keypress()
    for k,v in pairs(cfg.keys) do
        if not IsControlPressed(0, v) then
            return false
        end
    end
    return true
end

function getPeppered()
    exports['mythic_notify']:DoLongHudText("error", cfg.msgs.peppered)
    ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", cfg.pepperspray.camerashake)
    SetTimecycleModifier("hud_def_desat_Trevor")
    local dict
    local anim
    if IsPedSprinting(PlayerPedId()) then
        dict = cfg.animations.peppered.sprintdict
        anim = cfg.animations.peppered.sprintanim
    else
        dict = cfg.animations.peppered.dict
        anim = cfg.animations.peppered.anim
    end

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
    Wait(cfg.pepperspray.duration)
    ClearPedSecondaryTask(PlayerPedId())
    SetTimecycleModifier("")
    SetTransitionTimecycleModifier("")
    StopGameplayCamShaking()
end

function PepperOther()
    RequestAnimDict(cfg.animations.peppering.dict)
    while not HasAnimDictLoaded(cfg.animations.peppering.dict) do Wait(10) end
    TaskPlayAnim(PlayerPedId(), cfg.animations.peppering.dict, cfg.animations.peppering.anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
    Wait(1500)
    ClearPedSecondaryTask(PlayerPedId())
    Citizen.Wait(10000)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Keypress() then
            cCallback:TriggerServerCallback("PepperSpray", {}, function(result)
                if result.isCop then
                    if result.success then
                        exports['mythic_notify']:DoLongHudText("inform", cfg.msgs.confirm)
                        PepperOther()
                    else
                        exports['mythic_notify']:DoLongHudText("error", cfg.msgs.deny)
                        Citizen.Wait(1000)
                    end
                end
            end)
        end
    end
end)

RegisterNetEvent("mo-pepperspray:getPepperSprayed")
AddEventHandler("mo-pepperspray:getPepperSprayed", function()
    getPeppered()
end)