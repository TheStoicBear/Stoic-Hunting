Config = {}
-- Define the range for the random amount of skin and meat
Config.MinSkinAmount = 1
Config.MaxSkinAmount = 3
Config.MinMeatAmount = 1
Config.MaxMeatAmount = 5

-- Interaction Configurationrabbit_skin
Config.interactionDistance = 2.0
Config.sellingCooldownTime = 2000 -- 2000 milliseconds cooldown

-- Prices for different animal skins
-- Do not add more unless you know how to make new ox_inventory items.
Config.SkinPrices = {
    rabbit_skin = 10,
    pig_skin = 15,
    mountainlion_skin = 20,
    pigeon_skin = 5,
    crow_skin = 5,
    deer_skin = 25,
    cow_skin = 30,
    boar_skin = 20,
    chicken_skin = 10,
}
Config.MeatPrices = {
    rabbit_meat = 10,
    pig_meat = 15,
    mountainlion_meat = 20,
    pigeon_meat = 5,
    crow_meat = 5,
    deer_meat = 25,
    cow_meat = 30,
    boar_meat = 20,
    chicken_meat = 10
}

-- Skin selling NPC Configuration
Config.SkinNPCs = {
    {
        coords = vector4(725.06, 4192.04, 39.70, 243.78),
        model = "a_m_m_bevhills_02",
    },
    {
        coords = vector4(3046.75, -4610.16, 14.26, 14.26),
        model = "a_m_m_business_01",
    }
    -- Add more NPCs as needed
}

-- Meat Selling NPC Configuration
Config.MeatNPCs = {
    {
        coords = vector4(726.75, 4169.21, 39.70, 0.00),
        model = "a_m_m_bevhills_01",
    },
    {
        coords = vector4(3046.75, -4610.16, 14.26, 14.26),
        model = "a_m_m_business_01",
    }
    -- Add more NPCs as needed
}






















----------------------------------------------------------------------------
--Do not edit this unless you know how to make new items with ox_inventory--
----------------------------------------------------------------------------
-- Animal names based on ped models
Config.AnimalNames = {
    [GetHashKey("a_c_rabbit_01")] = "rabbit",
    [GetHashKey("a_c_pig")] = "pig",
    [GetHashKey("a_c_mtlion")] = "mountainlion",
    [GetHashKey("a_c_pigeon")] = "pigeon",
    [GetHashKey("a_c_crow")] = "crow",
    [GetHashKey("a_c_deer")] = "deer",
    [GetHashKey("a_c_cow")] = "cow",
    [GetHashKey("a_c_boar")] = "boar",
    [GetHashKey("a_c_chicken")] = "chicken"
}
-- Models for targetable options
Config.TargetableModels = { 
    "a_c_deer", "a_c_cow","a_c_pig", "a_c_rabbit_01", 
    "a_c_mtlion", "a_c_pigeon", "a_c_crow", "a_c_boar", 
    "a_c_chicken" 
}