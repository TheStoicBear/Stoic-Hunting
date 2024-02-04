-- Function to add a model as targetable with specific options
function addModelWithOptions(models, options)
    exports['qb-target']:AddTargetModel(models, options)
end

-- Event handler to check and add models
RegisterNetEvent('checkAndAddTargetable')
AddEventHandler('checkAndAddTargetable', function(pedModels)
    for _, model in ipairs(pedModels) do
        local ped = GetPed(model)
        if ped ~= 0 and IsPedDeadOrDying(ped) then
            local options = {
                options = {
                    {
                        type = "client",
                        event = "startSkinning",
                        icon = "fas fa-dna",
                        label = "Skin Animal",
                        canInteract = function(entity, distance, data)
                            return IsPedDeadOrDying(entity)
                        end
                    }
                },
                distance = 2.5
            }
            addModelWithOptions(model, options)
        end
    end
end)

-- Event handler for skinning
RegisterNetEvent('startSkinning')
AddEventHandler('startSkinning', function(data)
    local pedModel = data.model
    -- Add your logic to start skinning
    TriggerEvent('playSkinningAnimation', pedModel)
end)

-- Event handler for playing skinning animation
RegisterNetEvent('playSkinningAnimation')
AddEventHandler('playSkinningAnimation', function(data)
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

-- Function to get the ped by model name
function GetPed(modelName)
    for _, ped in ipairs(GetGamePool('CPed')) do
        if GetEntityModel(ped) == GetHashKey(modelName) then
            return ped
        end
    end
    return 0
end
