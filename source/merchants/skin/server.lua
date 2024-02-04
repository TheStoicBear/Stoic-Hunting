Citizen.CreateThread(function()

    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
	
end)


RegisterServerEvent('sellSkin')
AddEventHandler('sellSkin', function(npcModel)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local success = false

    local animalSkins = {
        "rabbit_skin",
        "pig_skin",
        "mountainlion_skin",
        "pigeon_skin",
        "crow_skin",
        "deer_skin",
        "cow_skin",
        "boar_skin",
        "chicken_skin"
    }

    local totalIncome = 0

    for _, skinName in ipairs(animalSkins) do
        local itemCount = xPlayer.getInventoryItem(skinName).count

        if itemCount > 0 then
            local sellPrice = CalculateSkinSellPrice(skinName, itemCount)
            totalIncome = totalIncome + sellPrice

            -- Remove the found items
            xPlayer.removeInventoryItem(skinName, itemCount)
            success = true

            local notificationData = {
                title = "Sold " .. itemCount .. " " .. skinName .. " skins",
                description = "Received $" .. sellPrice,
                type = 'success'
            }
            TriggerClientEvent('ox_lib:notify', _source, notificationData)
        else
            print("No " .. skinName .. " skins found in inventory")
        end
    end

    if totalIncome > 0 then
        xPlayer.addMoney(totalIncome)
        local totalNotificationData = {
            title = "Total income from selling animal skins:",
            description = "Received $" .. totalIncome,
            type = 'success'
        }
        TriggerClientEvent('ox_lib:notify', _source, totalNotificationData)
    else
        local noItemsNotificationData = {
            title = "No animal skins sold, no income generated",
            type = 'error'
        }
        TriggerClientEvent('ox_lib:notify', _source, noItemsNotificationData)
    end
end)

-- Function to calculate the sell price for a specific skin item
function CalculateSkinSellPrice(itemName, itemCount)
    local priceTable = Config.SkinPrices
    local price = priceTable[itemName] or 0
    return price * itemCount
end
