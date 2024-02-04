-- Server-side function to add items to a player's inventory
RegisterServerEvent('serverAddItemsToInventory')
AddEventHandler('serverAddItemsToInventory', function(animalName, skinAmount, meatAmount)
    local player = QBCore.Functions.GetPlayer(source)
    if not player then
        print("Player not found.")
        return
    end

    local skinItem = animalName .. "_skin"
    local meatItem = animalName .. "_meat"

    -- Add items to the player's inventory
    print("Adding items to inventory:")
    print("Skin item:", skinItem, "Amount:", skinAmount)
    print("Meat item:", meatItem, "Amount:", meatAmount)

    -- Add the skin and meat items to the player's inventory
    player.Functions.AddItem(skinItem, skinAmount)
    player.Functions.AddItem(meatItem, meatAmount)

    print("Items added to inventory successfully.")
end)
