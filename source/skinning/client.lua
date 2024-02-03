-- Function to check if a ped is dead
function isPedDead(ped)
    return IsEntityDead(ped)
end

-- Function to add a model as targetable with specific options
function addModelWithOptions(model, options)
    exports.ox_target:addModel(model, options)
end

-- Event handler to check and add models
RegisterNetEvent('checkAndAddTargetable')
AddEventHandler('checkAndAddTargetable', function(pedModels)
    for _, model in ipairs(pedModels) do
        if isPedDead(model) then
            local options = {
                label = "Skin Animal",
                icon = "fa-brands fa-wolf-pack-battalion",
                distance = 2.0,
                canInteract = function(entity, distance, coords, name)
                    return isPedDead(entity)
                end,
                onSelect = function(data)
                    TriggerEvent('startSkinning', data.model)
                end
            }
            addModelWithOptions(model, options)
        end
    end
end)

-- Function to get the ped by model name
function GetPed(modelName)
    for _, ped in ipairs(GetGamePool('CPed')) do
        if GetEntityModel(ped) == GetHashKey(modelName) then
            return ped
        end
    end
    return 0
end

-- Event handler for skinning
RegisterNetEvent('startSkinning')
AddEventHandler('startSkinning', function(pedModel)
    -- Add your logic to start skinning
    TriggerEvent('playSkinningAnimation', pedModel)
end)

-- Event handler for playing skinning animation
RegisterNetEvent('playSkinningAnimation')
AddEventHandler('playSkinningAnimation', function()
    print("Starting skinning animation...")
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    Citizen.Wait(5000) -- Adjust duration as needed

    local closestPed = GetClosestPed()

    if closestPed ~= 0 then
        local animalModel = GetEntityModel(closestPed)
        local animalName = GetAnimalName(animalModel)

        local skinAmount = math.random(Config.MinSkinAmount, Config.MaxSkinAmount)
        local meatAmount = math.random(Config.MinMeatAmount, Config.MaxMeatAmount)

        -- Trigger the server event to add items to the player's inventory
        TriggerServerEvent('serverAddItemsToInventory', animalName, skinAmount, meatAmount)

        -- Clear the animation for the source player
        ClearPedTasks(playerPed)

        -- Delete the ped
        DeleteEntity(closestPed)
    else
        -- Handle the case when no nearby animal is found
        print("No nearby animal found to skin.")
    end
end)

-- Function to get the closest ped
function GetClosestPed()
    print("Searching for closest ped...")
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local closestPed = 0
    local closestDistance = -1

    for _, ped in ipairs(GetGamePool('CPed')) do
        if IsPedDeadOrDying(ped) then
            local pedCoords = GetEntityCoords(ped)
            local distance = #(pedCoords - playerCoords)

            if closestDistance == -1 or distance < closestDistance then
                closestPed = ped
                closestDistance = distance
            end
        end
    end

    print("Closest ped found:", closestPed)
    return closestPed
end

-- Function to get the animal name based on the ped model
function GetAnimalName(model)
    local animalName = Config.AnimalNames[model] or "Unknown"
    print("Animal name:", animalName)
    return animalName
end

-- Add the targetable options when the resource starts
Citizen.CreateThread(function()
    local pedModels = Config.TargetableModels
    TriggerEvent('checkAndAddTargetable', pedModels)
end)
