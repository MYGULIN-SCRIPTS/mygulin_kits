ESX = exports["es_extended"]:getSharedObject()
local lastUsed = {}


local function GetDiscordID(source)
    for _, id in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(id, 1, 8) == "discord:" then
            return string.sub(id, 9)
        end
    end
    return nil
end


lib.callback.register('mygulin_kits:getAvailableKit', function(source)
    local discordId = GetDiscordID(source)
    if not discordId then return nil end

    local kitType = "basic"
    local kit = Config.BasicKit
    local cooldown = Config.Cooldown 

    if Config.VIPKits[discordId] then
        kitType = "vip"
        kit = Config.VIPKits[discordId].items or Config.VIPKits[discordId]
        cooldown = Config.VIPKits[discordId].cooldown or Config.Cooldown
    end

    local remaining = 0
    if lastUsed[discordId] then
        local diff = os.time() - lastUsed[discordId]
        if diff < cooldown then
            remaining = cooldown - diff
        end
    end

    return { type = kitType, items = kit, remaining = remaining }
end)

RegisterNetEvent("mygulin_kits:claimKit", function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local discordId = GetDiscordID(src)
    if not discordId then return end

    local currentTime = os.time()
    local kit = Config.BasicKit
    local kitName = "základní kit"
    local cooldown = Config.Cooldown

    if data.type == "vip" then
        if Config.VIPKits[discordId] then
            kit = Config.VIPKits[discordId].items or Config.VIPKits[discordId]
            kitName = "VIP kit"
            cooldown = Config.VIPKits[discordId].cooldown or Config.Cooldown
        else
            TriggerClientEvent('okokNotify:Alert', src, "KIT", "❌ Nemáš přístup k VIP kitu.", 5000, 'error')
            return
        end
    else
     
        if Config.VIPKits[discordId] and not Config.VIPCanSeeBasicKit then
            TriggerClientEvent('okokNotify:Alert', src, "KIT", "❌ Nemůžeš vyzvednout základní kit.", 5000, 'error')
            return
        end
    end

 
    if lastUsed[discordId] and (currentTime - lastUsed[discordId]) < cooldown then
        local remaining = cooldown - (currentTime - lastUsed[discordId])
        TriggerClientEvent('okokNotify:Alert', src, "KIT", "⏳ Kit můžeš použít znovu za " .. math.ceil(remaining / 60) .. " minut.", 5000, 'error')
        return
    end

   
    for _, item in ipairs(kit) do
        xPlayer.addInventoryItem(item.name, item.count)
    end

    lastUsed[discordId] = currentTime
    TriggerClientEvent('okokNotify:Alert', src, "KIT", "✅ Dostal jsi svůj " .. kitName .. "!", 5000, 'success')
end)
