RegisterServerEvent('sellMeat')
AddEventHandler('sellMeat', function(npcModel)
    local player = source
    local xPlayer = QBCore.Functions.GetPlayer(player)

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
        local itemCount = xPlayer.Functions.GetItemByName(meatName)
        if itemCount > 0 then
            local sellPrice = CalculateMeatSellPrice(meatName, itemCount)
            totalIncome = totalIncome + sellPrice

            -- Remove the found items
            xPlayer.Functions.RemoveItem(meatName, itemCount)

            local notificationData = {
                title = "Sold " .. itemCount .. " " .. meatName .. " meat",
                description = "Received $" .. sellPrice,
                type = 'success'
            }
            TriggerClientEvent('QBCore:Notify', player, notificationData)
        else
            print("No " .. meatName .. " meat found in inventory")
        end
    end

    if totalIncome > 0 then
        xPlayer.Functions.AddMoney('cash', totalIncome, "Sold meat")
        local totalNotificationData = {
            title = "Total income from selling meat:",
            description = "Received $" .. totalIncome,
            type = 'success'
        }
        TriggerClientEvent('QBCore:Notify', player, totalNotificationData)
    else
        local noItemsNotificationData = {
            title = "No meat sold, no income generated",
            type = 'error'
        }
        TriggerClientEvent('QBCore:Notify', player, noItemsNotificationData)
    end
end)

-- Function to calculate the sell price for a specific meat item
function CalculateMeatSellPrice(itemName, itemCount)
    local priceTable = Config.MeatPrices
    local price = priceTable[itemName] or 0
    print("Item: " .. itemName .. ", Price: $" .. price) -- Add this line for debugging
    return price * itemCount
end
