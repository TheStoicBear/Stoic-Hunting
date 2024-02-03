local prevChair = 0
local chairNetId = nil

local function pickupChair()
    if prevChair == 0 then
        TriggerEvent('chatMessage', '', {255,255,255}, '^8Error: ^0no previous chair spawned, or your previous chair has already been deleted.')
    else
        SetEntityAsMissionEntity(prevChair)
        DeleteObject(prevChair)
        prevChair = 0
        -- Remove the chair entity from the targetable options when picked up
        if chairNetId then
            exports.ox_target:removeEntity(chairNetId, 'pickupChair')
            chairNetId = nil
        end

        -- Trigger a server event to add the "chair" item to the player's inventory
        TriggerServerEvent('AddChairBack', source)
    end
end

-- Assuming you're using QBCore, replace 'bandage' with 'chair'
exports('chair', function(data, slot)
    if prevChair ~= 0 then
        SetEntityAsMissionEntity(prevChair)
        DeleteObject(prevChair)
        prevChair = 0
        -- Remove the chair entity from the targetable options when picked up
        if chairNetId then
            exports.ox_target:removeEntity(chairNetId, 'pickupChair')
            chairNetId = nil
        end
    end
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.02))
    local chairs = {
        'prop_chair_02',
        'prop_chair_05',
        'prop_chair_10'
        -- Add more chair models as needed
    }
    local randomint = math.random(1, 3) -- Adjust the range according to the number of chair models
    local chairModel = GetHashKey(chairs[randomint])
    local prop = CreateObject(chairModel, x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    prevChair = prop

    -- Get the network ID of the created chair object
    chairNetId = NetworkGetNetworkIdFromEntity(prop)

    -- Create the targetable option for picking up the chair
    exports.ox_target:addEntity(chairNetId, {
        label = 'Pick up Chair', -- Label for the option
        onSelect = function(data)
            pickupChair() -- Calls the 'pickupChair' function to pick up the chair
        end
    })
end)

-- Export the pickupChair function
exports('pickupChair', pickupChair)
