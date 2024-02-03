To install these to your ox_inventory resource you need to go to 
ox_inventory/data/items.lua
Then go to the bottom of the file. and add the items listed below.
Then go to Stoic-Hunting/Images and drag and drop these images into
ox_inventory/web/images. 

Once done restart your server!





    ['rabbit_skin'] = {
        label = 'Rabbit Pelt',
        weight = 100,
        stack = true,
        close = true,
    },
    ['rabbit_meat'] = {
        label = 'Rabbit Meat',
        weight = 100,
        stack = true,
        close = true,
    },
    ['pig_skin'] = {
        label = 'Pig Skin',
        weight = 100,
        stack = true,
        close = true,
    },
    ['pig_meat'] = {
        label = 'Pig Meat',
        weight = 100,
        stack = true,
        close = true,
    },
    ['mountainlion_skin'] = {
        label = 'Mountain Lion Pelt',
        weight = 100,
        stack = true,
        close = true,
    },
    ['mountainlion_meat'] = {
        label = 'Mountain Lion Meat',
        weight = 100,
        stack = true,
        close = true,
    },
    ['pigeon_skin'] = {
        label = 'Pigeon Feather',
        weight = 100,
        stack = true,
        close = true,
    },
    ['pigeon_meat'] = {
        label = 'Pigeon Meat',
        weight = 100,
        stack = true,
        close = true,
    },
    ['crow_skin'] = {
        label = 'Crow Feather',
        weight = 100,
        stack = true,
        close = true,
    },
    ['crow_meat'] = {
        label = 'Crow Meat',
        weight = 100,
        stack = true,
        close = true,
    },
    ['chicken_skin'] = {
        label = 'Chicken Feathers',
        weight = 100,
        stack = true,
        close = true,
    },
    ['chicken_meat'] = {
        label = 'Chicken Meat',
        weight = 100,
        stack = true,
        close = true,
    },
    ['deer_skin'] = {
        label = 'Deer Pelt',
        weight = 100,
        stack = true,
        close = true,
    },
    ['deer_meat'] = {
        label = 'Deer Meat',
        weight = 100,
        stack = true,
        close = true,
    },
    ['cow_skin'] = {
        label = 'Cow Hide',
        weight = 100,
        stack = true,
        close = true,
    },
    ['cow_meat'] = {
        label = 'Cow Meat',
        weight = 100,
        stack = true,
        close = true,
    },
    ['boar_skin'] = {
        label = 'Boar Hide',
        weight = 100,
        stack = true,
        close = true,
    },
    ['boar_meat'] = {
        label = 'Boar Meat',
        weight = 100,
        stack = true,
        close = true,
    },
    ['tent'] = {
        label = 'Hunting Tent',
        weight = 1000,  -- Adjust weight as needed
        stack = false,  -- Assuming one tent cannot be stacked
        close = true,   -- Close inventory after use
        description = 'A durable hunting tent for those long expeditions into the wilderness.',
        consume = 1,    -- Consumes 1 tent per use
        client = {
            export = 'Stoic-Hunting.tent'  -- Calls the 'tent' export from client.lua
        }
    
    },
    ['campfire'] = {
        label = 'Campfire',
        weight = 1000,  -- Adjust weight as needed
        stack = false,  -- Assuming one tent cannot be stacked
        close = true,   -- Close inventory after use
        description = 'A durable hunting tent for those long expeditions into the wilderness.',
        consume = 1,    -- Consumes 1 tent per use
        client = {
            export = 'Stoic-Hunting.campfire'  -- Calls the 'campfire' export from client.lua
        }
    },
    ['chair'] = {
        label = 'Chair',
        weight = 1000,  -- Adjust weight as needed
        stack = false,  -- Assuming one tent cannot be stacked
        close = true,   -- Close inventory after use
        description = 'A durable hunting tent for those long expeditions into the wilderness.',
        consume = 1,    -- Consumes 1 tent per use
        client = {
            export = 'Stoic-Hunting.chair'  -- Calls the 'chair' export from client.lua
        }
    },
    ['deer_bait'] = {
        label = 'Deer Bait',
        weight = 1000,  -- Adjust weight as needed
        stack = false,  -- Assuming one deer_bait cannot be stacked
        close = true,   -- Close inventory after use
        description = 'Used to bait deer to your hunting spot.',
        consume = 1,    -- Consumes 1 deer_bait per use
        client = {
            export = 'Stoic-Hunting.spawnDeer'  -- Calls the 'spawnDeer' export from client.lua
        }
    },
    ['boar_bait'] = {
        label = 'Boar Bait',
        weight = 1000,  -- Adjust weight as needed
        stack = false,  -- Assuming one boar_bait cannot be stacked
        close = true,   -- Close inventory after use
        description = 'Used to bait boar to your hunting spot.',
        consume = 1,    -- Consumes 1 boar_bait per use
        client = {
            export = 'Stoic-Hunting.spawnBoar'  -- Calls the 'spawnBoar' export from client.lua
        }
    }