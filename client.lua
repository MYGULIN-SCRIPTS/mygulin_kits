RegisterCommand("kit", function()
    lib.callback('mygulin_kits:getAvailableKit', false, function(data)
        if not data then
            lib.notify({ title = 'KIT', description = '❌ Nemáš žádný kit k dispozici.', type = 'error' })
            return
        end

        local options = {}

        local title = (data.type == 'vip' and 'VIP kit' or 'Základní kit')

        local items = ""
        for _, item in ipairs(data.items) do
            items = items .. item.count .. "x " .. (item.label or item.name) .. "\n"
        end

        local description = items
        if data.remaining > 0 then
            description = description .. "\n⏳ Další vyzvednutí za " .. math.ceil(data.remaining / 60) .. " minut."
        else
            description = description .. "\n✅ Kit je dostupný! Klikni pro vyzvednutí."
        end

        table.insert(options, {
            title = title,
            description = description,
            icon = (data.type == 'vip' and 'star' or 'box'),
            disabled = data.remaining > 0,
            onSelect = function()
                TriggerServerEvent("mygulin_kits:claimKit", { type = data.type })
            end
        })

        lib.registerContext({
            id = 'kit_menu',
            title = 'Výběr kitu',
            options = options
        })

        lib.showContext('kit_menu')
    end)
end)
