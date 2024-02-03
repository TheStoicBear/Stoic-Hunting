-- Load Configuration
local interactionDistance = Config.interactionDistance
local sellingCooldownTime = Config.sellingCooldownTime

-- Load NPC Configuration
local npcConfig = Config.SkinNPCs

-- Table to store created NPC entities
local npcEntities = {}

-- Function to spawn NPCs
function SpawnNPCs()
    for _, npcData in ipairs(npcConfig) do
        local modelHash = GetHashKey(npcData.model)

        -- Request model load
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(500)
        end

        -- Create NPC
        local npcPed = CreatePed(4, modelHash, npcData.coords.x, npcData.coords.y, npcData.coords.z, npcData.coords.w, false, true)
        SetEntityAsMissionEntity(npcPed, true, true)
        SetBlockingOfNonTemporaryEvents(npcPed, true)
        SetPedDiesWhenInjured(npcPed, false)
        SetPedCanPlayAmbientAnims(npcPed, true)
        SetPedCanRagdollFromPlayerImpact(npcPed, false)
        SetEntityInvincible(npcPed, true)
        FreezeEntityPosition(npcPed, true)

        -- Store NPC entity
        table.insert(npcEntities, npcPed)
    end

    -- Create targetable entities for NPCs
    local npcModels = {}
    for _, npcData in ipairs(npcConfig) do
        table.insert(npcModels, npcData.model)
    end

    local options = {
        label = "Sell Skin",
        distance = 2.0,
        icon = "fa-solid fa-sack-dollar",
        onSelect = function()
            SellSkin()
        end
    }
    exports.ox_target:addModel(npcModels, options)
end

-- Spawn NPCs when the script starts
SpawnNPCs()

-- Function to handle selling skin
function SellSkin()
    if not sellingCooldown then
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local closestNPCDist = interactionDistance
        local closestNPC = nil

        -- Find the closest NPC
        for _, npcData in ipairs(npcConfig) do
            local npcDist = #(playerCoords - vector3(npcData.coords.x, npcData.coords.y, npcData.coords.z))
            if npcDist < closestNPCDist then
                closestNPCDist = npcDist
                closestNPC = npcData
            end
        end

        if closestNPC then
            -- Logic to sell skin goes here
            TriggerServerEvent('sellSkin', closestNPC.model)
            sellingCooldown = true
            Citizen.SetTimeout(sellingCooldownTime, function()
                sellingCooldown = false
            end)
        end
    end
end
