Config = {}

Config.Cooldown = 3600 -- Cooldown na běžný kit (3600 sekund) / Cooldown for the basic kit (3600 seconds)

Config.BasicKit = {
    {name = "water", label = "Water", count = 5}, --
    {name = "bread", label = "Chleba", count = 5}, -- "water" - jmeno itemu "Water" - nazev co se bude ukazovat /"water" - item spawn code "Water" - item label
    {name = "WEAPON_PISTOL", label = "Pistole", count = 1},
    {name = "ammo-9", label = "Náboje do pistole", count = 50},
}

Config.VIPKits = {
    ["947135911907450931"] = { -- Discord ID
        cooldown = 1800, -- Cooldown na vip kit (1800 sekund) / Cooldown for the vip kit (1800 seconds)
        items = {
            {name = "bread", label = "Chleba", count = 10},
            {name = "water", label = "Voda", count = 10},
            {name = "WEAPON_CARBINERIFLE", label = "Karabina", count = 1},
            {name = "ammo-rifle", label = "Náboje do karabiny", count = 120},
        }
    },
    ["987654321098765432"] = { -- Discord ID
        cooldown = 900, -- Cooldown na vip kit (900 sekund) / Cooldown for the vip kit (900 seconds)
        items = {
            {name = "bread", label = "Chleba", count = 20},
            {name = "water", label = "Voda", count = 20},
            {name = "WEAPON_SMG", label = "Samopal", count = 1},
            {name = "ammo-smg", label = "Náboje do samopalu", count = 150},
            {name = "armor", label = "Neprůstřelná vesta", count = 2},
        }
    }
}
