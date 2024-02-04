Citizen.CreateThread(function()

    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
	
end)

RegisterServerEvent('sellMeat')
AddEventHandler('sellMeat', function(npcModel)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
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
        local itemCount = xPlayer.getInventoryItem(meatName).count

        if itemCount > 0 then
            local sellPrice = CalculateMeatSellPrice(meatName, itemCount)
            totalIncome = totalIncome + sellPrice

            -- Remove the found items
            xPlayer.removeInventoryItem(meatName, itemCount)
            success = true

            local notificationData = {
                title = "Sold " .. itemCount .. " " .. meatName .. " meat",
                description = "Received $" .. sellPrice,
                type = 'success'
            }
            TriggerClientEvent('ox_lib:notify', _source, notificationData)
        else
            print("No " .. meatName .. " meat found in inventory")
        end
    end

    if totalIncome > 0 then
        xPlayer.addMoney(totalIncome)
        local totalNotificationData = {
            title = "Total income from selling meat:",
            description = "Received $" .. totalIncome,
            type = 'success'
        }
        TriggerClientEvent('ox_lib:notify', _source, totalNotificationData)
    else
        local noItemsNotificationData = {
            title = "No meat sold, no income generated",
            type = 'error'
        }
        TriggerClientEvent('ox_lib:notify', _source, noItemsNotificationData)
    end
end)

-- Function to calculate the sell price for a specific meat item
function CalculateMeatSellPrice(itemName, itemCount)
    local priceTable = Config.MeatPrices
    local price = priceTable[itemName] or 0
    print("Item: " .. itemName .. ", Price: $" .. price) -- Add this line for debugging
    return price * itemCount
end
