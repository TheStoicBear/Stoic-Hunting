-- Define a function to get the player's current position
function getPlayerPosition()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    return coords
end

-- Define the export function to spawn animals and assign tasks
exports('spawnDeer', function()
    -- Get the player's current position
    local playerPosition = getPlayerPosition()

    -- Check if the player's position is valid
    if not playerPosition then
        print("Failed to get the player's position.")
        return
    end

    -- Generate a random chance to determine the spawn count
    local spawnChance = math.random(1, 10)
    local animalCount = 1  -- Default spawn count

    -- Adjust the spawn count based on the random chance
    if spawnChance == 10 then
        animalCount = 10  -- Occasionally spawn 10 animals
    elseif spawnChance >= 8 then
        animalCount = math.random(1, 3)  -- Mostly spawn 1-3 animals
    end

    -- Task the player to perform a "put down" animation
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    Wait(3000)
    ClearPedTasksImmediately(PlayerPedId())

    -- Trigger a chat notification indicating that the bait has been placed
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 255},
        multiline = true,
        args = {"Bait Placed", "You have successfully placed the bait."}
    })
    Wait(5000)

    -- Iterate to spawn animals and create markers
    for i = 1, animalCount do
        -- Spawn an animal at a random position near the player
        local x = playerPosition.x + math.random(-200, 200) -- Adjust the range as needed
        local y = playerPosition.y + math.random(-200, 200) -- Adjust the range as needed
        local z = playerPosition.z

        -- Ensure that the animal model exists in the game
        local modelHash = GetHashKey("a_c_deer")
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(500)
        end

        -- Spawn the animal
        local animalPed = CreatePed(28, modelHash, x, y, z, 0.0, true, true)

        -- Check if the animal was spawned successfully
        if DoesEntityExist(animalPed) then
            -- Assign a task for the animal to move to the location where the bait was placed
            TaskGoToCoordAnyMeans(animalPed, playerPosition.x, playerPosition.y, playerPosition.z, 1.0, 0, false, 0)

            -- Create a marker for the spawned animal
            local animalBlip = AddBlipForEntity(animalPed)
            SetBlipSprite(animalBlip, 141)  -- Set the blip sprite (you can choose any suitable sprite)
            SetBlipColour(animalBlip, 1)     -- Set the blip color
            SetBlipScale(animalBlip, 1.0)    -- Set the blip scale
            SetBlipAsShortRange(animalBlip, true)  -- Set the blip as short range

            -- Remove the blip after 1 minute
            SetTimeout(60000, function()
                if DoesBlipExist(animalBlip) then
                    RemoveBlip(animalBlip)
                end
            end)

            print("Failed to spawn deer.")
        end
    end
end)

