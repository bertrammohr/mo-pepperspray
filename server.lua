vRP = module("vrp", "lib/Proxy").getInterface("vRP")
vRPclient = module("vrp", "lib/Tunnel").getInterface("vRP","mo-pepperspray")

sCallback = {
    RegisterServerCallback = function(self, name, f)
        self[name] = f
    end
}
RegisterServerEvent("mo-pepperspray:TriggerServerCallback")
AddEventHandler("mo-pepperspray:TriggerServerCallback", function(name, args)
    local source = source
    TriggerClientEvent("mo-pepperspray:RecieveServerCallback", source, name, sCallback[name](table.unpack(args)))
end)

sCallback:RegisterServerCallback("PepperSpray", function()
    local user_id = vRP.getUserId({source})
    if vRP.hasGroup({user_id, cfg.job}) then
        local nearbyPlayer
        vRPclient.getNearestPlayer(source, {5}, function(nplayer)
            if nplayer then
                nearbyPlayer = nplayer
            else
                nearbyPlayer = false
            end
        end)
        while nearbyPlayer == nil do Wait(10) end
        if nearbyPlayer then
            TriggerClientEvent("mo-pepperspray:getPepperSprayed", nearbyPlayer)
            return {isCop = true, success = true}
        else 
            return {isCop = true, success = false}
        end
    else
        return {isCop = false, success = false}
    end
end)    