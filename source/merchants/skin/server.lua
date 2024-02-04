local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('sellSkin')
AddEventHandler('sellSkin', function(npcModel)
    local player = source
    local tPlayer = NDCore.getPlayer(player)
    local inventoryId = tPlayer.getData("id")
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
        local item = exports.ox_inventory:Search(player, 'count', skinName)

        if item > 0 then
            local sellPrice = CalculateSkinSellPrice(skinName, item)
            totalIncome = totalIncome + sellPrice

            -- Remove the found items
            exports.ox_inventory:RemoveItem(player, skinName, item, nil, nil, function(removed, response)
                if removed then
                    success = true
                else
                    print("Failed to remove " .. skinName .. " skins: " .. response)
                end
            end)

            local notificationData = {
                title = "Sold " .. item .. " " .. skinName .. " skins",
                description = "Received $" .. sellPrice,
                type = 'success'
            }
            TriggerClientEvent('ox_lib:notify', player, notificationData)
        else
            print("No " .. skinName .. " skins found in inventory")
        end
    end

    if totalIncome > 0 then
        local moneyAdded = tPlayer.addMoney("cash", totalIncome, "Sold animal skins")
        if not moneyAdded then
            print("Failed to add money to the player's cash account.")
        else
            local totalNotificationData = {
                title = "Total income from selling animal skins:",
                description = "Received $" .. totalIncome,
                type = 'success'
            }
            TriggerClientEvent('ox_lib:notify', player, totalNotificationData)
        end
    else
        local noItemsNotificationData = {
            title = "No animal skins sold, no income generated",
            type = 'error'
        }
        TriggerClientEvent('ox_lib:notify', player, noItemsNotificationData)
    end
end)

-- Function to calculate the sell price for a specific item
function CalculateSkinSellPrice(itemName, itemCount)
    local priceTable = Config.SkinPrices
    local price = priceTable[itemName] or 0
    return price * itemCount
end
