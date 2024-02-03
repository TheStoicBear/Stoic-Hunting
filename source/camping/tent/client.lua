local prevtent = 0
local function pickupTent()
    if prevtent == 0 then
        TriggerEvent('chatMessage', '', {255,255,255}, '^8Error: ^0no previous tent spawned, or your previous tent has already been deleted.')
    else
        SetEntityAsMissionEntity(prevtent)
        DeleteObject(prevtent)
        prevtent = 0
        -- Remove the tent entity from the targetable options when picked up
        if tentNetId then
            exports.ox_target:removeEntity(tentNetId, 'pickupTent')
            tentNetId = nil
        end

        -- Trigger a server event to add the "tent" item to the player's inventory
        TriggerServerEvent('AddTentBack', source)
    end
end

-- Assuming you're using QBCore, replace 'bandage' with 'tent'
exports('tent', function(data, slot)
    if prevtent ~= 0 then
        SetEntityAsMissionEntity(prevtent)
        DeleteObject(prevtent)
        prevtent = 0
        -- Remove the tent entity from the targetable options when picked up
        if tentNetId then
            exports.ox_target:removeEntity(tentNetId, 'pickupTent')
            tentNetId = nil
        end
    end
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.95))
    local tents = {
        'prop_skid_tent_01',
        'prop_skid_tent_01b',
        'prop_skid_tent_03',
    }
    local randomint = math.random(1, 3)
    local tent = GetHashKey(tents[randomint])
    local prop = CreateObject(tent, x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    prevtent = prop

    -- Get the network ID of the created tent object
    tentNetId = NetworkGetNetworkIdFromEntity(prop)

    -- Create the targetable option for picking up the tent
    exports.ox_target:addEntity(tentNetId, {
        label = 'Pick up Tent', -- Label for the option
        onSelect = function(data)
            pickupTent() -- Calls the 'pickupTent' function to pick up the tent
        end
    })
end)

-- Export the pickupTent function
exports('pickupTent', pickupTent)
