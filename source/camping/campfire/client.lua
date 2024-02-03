local prevCampfire = 0
local campfireNetId = nil

local function pickupCampfire()
    if prevCampfire == 0 then
        TriggerEvent('chatMessage', '', {255,255,255}, '^8Error: ^0no previous campfire spawned, or your previous campfire has already been deleted.')
    else
        SetEntityAsMissionEntity(prevCampfire)
        DeleteObject(prevCampfire)
        prevCampfire = 0
        -- Remove the campfire entity from the targetable options when picked up
        if campfireNetId then
            exports.ox_target:removeEntity(campfireNetId, 'pickupCampfire')
            campfireNetId = nil
        end
                -- Trigger a server event to add the "chair" item to the player's inventory
                TriggerServerEvent('AddCampfireback', source)
    end
end




exports('campfire', function(data, slot)
    if prevCampfire ~= 0 then
        TriggerEvent('chatMessage', '', {255,255,255}, '^8Error: ^0a campfire is already spawned.')
        return
    end

    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local campfireModel = GetHashKey('prop_beach_fire') -- Specify the campfire model

    -- Create the campfire object
    local prop = CreateObject(campfireModel, x, y, z, true, false, true)
    if prop == 0 then
        print("Failed to create campfire entity.")
        return
    end

    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    prevCampfire = prop

    -- Get the network ID of the created campfire object
    campfireNetId = NetworkGetNetworkIdFromEntity(prop)

    -- Check if the network ID is valid
    if campfireNetId ~= 0 then
        -- Add the cooking option to the campfire
        exports.ox_target:addEntity(campfireNetId, {
            label = 'Cook Meat', -- Label for the option
            onSelect = function(data)
                cookMeat() -- Calls the 'cookMeat' function to cook raw meat
            end
        })

        -- Add the pick up option to the campfire
        exports.ox_target:addEntity(campfireNetId, {
            label = 'Pick up Campfire', -- Label for the option
            onSelect = function(data)
                pickupCampfire() -- Calls the 'pickupCampfire' function to pick up the campfire
            end
        })
    else
        print("Failed to get network ID for campfire entity.")
    end
end)

-- Export the pickupCampfire function
exports('pickupCampfire', pickupCampfire)
