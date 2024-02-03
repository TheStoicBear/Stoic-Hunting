-- RegisterServerEvent('AddCampfireback')
-- AddEventHandler('AddCampfireback', function()
--     -- Add the "campfire" item to the player's inventory
--     local success, response = exports.ox_inventory:AddItem(source, 'campfire', 1)

--     if not success then
--         -- Handle the error response
--         print("Failed to add tent campfire to inventory: " .. response)
--     else
--         print("Campfire item added to inventory successfully")
--     end
-- end)

-- function RemoveItem(source, name, amount)
--     return exports.ox_inventory:RemoveItem(source, name, amount)
-- end


RegisterServerEvent('CookMeat')
AddEventHandler('CookMeat', function()
    local source = source

    -- Define the raw meat item names
    local meatNames = {
        'rabbit_meat',
        'pig_meat',
        'mountain_lion_meat',
        'pigeon_meat',
        'crow_meat',
        'deer_meat',
        'cow_meat',
        'boar_meat'
    }

    -- Get all items in the player's inventory
    local playerItems = exports.ox_inventory:GetInventoryItems(source)

    local rawMeatFound = false
    local rawMeatName = nil

    -- Search for raw meat in the player's inventory
    for _, item in ipairs(playerItems) do
        for _, meatName in ipairs(meatNames) do
            if item.name == meatName then
                rawMeatFound = true
                rawMeatName = meatName
                break
            end
        end
    end

    if rawMeatFound then
        -- Remove raw meat from the player's inventory
        local success = exports.ox_inventory:RemoveItem(source, rawMeatName, 1)

        if success then
            -- Add cooked meat to the player's inventory
            local cookedMeatName = 'cooked_' .. rawMeatName
            exports.ox_inventory:AddItem(source, cookedMeatName, 1)
        else
            -- Notify the player if removal fails
            TriggerClientEvent('chatMessage', source, '^1Cooking failed: Unable to remove raw meat from inventory.')
        end
    else
        -- Notify the player if no raw meat was found
        TriggerClientEvent('chatMessage', source, '^1Cooking failed: No raw meat found in inventory.')
    end
end)
