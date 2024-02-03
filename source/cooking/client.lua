-- Function to cook raw meat into cooked meat
function cookMeat()
    -- Define the meat options available for cooking
    local meatOptions = {
        'Rabbit Meat',
        'Pig Meat',
        'Mountain Lion Meat',
        'Pigeon Meat',
        'Crow Meat',
        'Deer Meat',
        'Cow Meat',
        'Boar Meat'
    }

    -- Search the player's inventory for meat items and their counts
    local inventory = exports.ox_inventory:Search('count', meatOptions)

    -- Prepare the meat options with counts for the input dialog
    local meatOptionsWithCounts = {}
    for meat, count in pairs(inventory) do
        table.insert(meatOptionsWithCounts, { label = meat .. " (" .. count .. ")", value = meat })
    end

    -- Prepare the options for the input dialog
    local dialogOptions = {
        label = "Select meat to cook:",
        type = 'select',
        options = meatOptionsWithCounts,
        required = true
    }

    -- Show input dialog to the player
    local inputPromise = lib.inputDialog("Cook Meat", {}, { dialogOptions })

    -- Handle the result when the user selects an option
    inputPromise.then(function(data)
        -- On confirmation, data will contain the selected meat
        local selectedMeat = data[1].value
        -- Trigger the server event to cook the selected meat
        TriggerServerEvent('CookMeat', selectedMeat)
    end)
    .catch(function(error)
        -- Handle errors if any
        print("An error occurred: " .. error)
    end)
end
