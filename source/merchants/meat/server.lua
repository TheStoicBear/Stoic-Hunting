RegisterServerEvent('sellMeat')
AddEventHandler('sellMeat', function(npcModel)
    local player = source
    local tPlayer = NDCore.getPlayer(player)
    local inventoryId = tPlayer.getData("id")
    local success = false

    local animalMeat = {
        "rabbit_meat",
        "pig_meat",
        "mountainlion_meat",
        "pigeon_meat",
        "crow_meat",
        "deer_meat",
        "cow_meat",
        "boar_meat",
        "chicken_meat"
    }

    local totalIncome = 0

    for _, meatName in ipairs(animalMeat) do
        local item = exports.ox_inventory:Search(player, 'count', meatName)

        if item > 0 then
            local sellPrice = CalculateMeatSellPrice(meatName, item)
            totalIncome = totalIncome + sellPrice

            -- Remove the found items
            exports.ox_inventory:RemoveItem(player, meatName, item, nil, nil, function(removed, response)
                if removed then
                    success = true
                else
                    print("Failed to remove " .. meatName .. " meat: " .. response)
                end
            end)

            local notificationData = {
                title = "Sold " .. item .. " " .. meatName .. " meat",
                description = "Received $" .. sellPrice,
                type = 'success'
            }
            TriggerClientEvent('ox_lib:notify', player, notificationData)
        else
            print("No " .. meatName .. " meat found in inventory")
        end
    end

    if totalIncome > 0 then
        local moneyAdded = tPlayer.addMoney("cash", totalIncome, "Sold meat")
        if not moneyAdded then
            print("Failed to add money to the player's cash account.")
        else
            local totalNotificationData = {
                title = "Total income from selling meat:",
                description = "Received $" .. totalIncome,
                type = 'success'
            }
            TriggerClientEvent('ox_lib:notify', player, totalNotificationData)
        end
    else
        local noItemsNotificationData = {
            title = "No meat sold, no income generated",
            type = 'error'
        }
        TriggerClientEvent('ox_lib:notify', player, noItemsNotificationData)
    end
end)

-- Function to calculate the sell price for a specific meat item
function CalculateMeatSellPrice(itemName, itemCount)
    local priceTable = Config.MeatPrices
    local price = priceTable[itemName] or 0
    print("Item: " .. itemName .. ", Price: $" .. price) -- Add this line for debugging
    return price * itemCount
end

