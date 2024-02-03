-- Server-side function to add items to a player's inventory
RegisterServerEvent('serverAddItemsToInventory')
AddEventHandler('serverAddItemsToInventory', function(animalName, skinAmount, meatAmount)
    local playerId = source
    print("Player ID:", playerId)

    -- Retrieve player data using NDCore (assuming it's a custom function)
    local player = NDCore.getPlayer(playerId)
    print("Player:", player)

    local skinItem = animalName .. "_skin"
    local meatItem = animalName .. "_meat"

    -- Add items to the player's inventory
    print("Adding items to inventory:")
    print("Skin item:", skinItem, "Amount:", skinAmount)
    print("Meat item:", meatItem, "Amount:", meatAmount)

    -- Add the skin and meat items to the player's inventory
    local success1, response1 = exports.ox_inventory:AddItem(source, skinItem, skinAmount)
    local success2, response2 = exports.ox_inventory:AddItem(source, meatItem, meatAmount)

    -- Check if the items were successfully added
    if not success1 then
        print("Failed to add skin item:", response1)
    end

    if not success2 then
        print("Failed to add meat item:", response2)
    end

    print("Items added to inventory successfully.")
end)
