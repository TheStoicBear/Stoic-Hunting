author "TheStoicBear"
description "Stoic-Hunting"
version "1.0.0"

fx_version "cerulean"
game "gta5"
lua54 "yes"

client_scripts {
    "source/skinning/client.lua",
    "source/merchants/meat/client.lua",
    "source/merchants/skin/client.lua",
    "source/camping/campfire/client.lua",
    "source/camping/chair/client.lua",
    "source/camping/tent/client.lua",
    "source/bait/deer/client.lua",
    "source/bait/boar/client.lua"
}

server_scripts {
    "source/skinning/server.lua",
    "source/merchants/meat/server.lua",
    "source/merchants/skin/server.lua",
    "source/camping/campfire/server.lua",
    "source/camping/chair/server.lua",
    "source/camping/tent/server.lua"
}

shared_scripts {
    "config.lua",
    "@ox_lib/init.lua",
    "@ND_Core/init.lua"
}

escrow_ignore {
    "config.lua"
}

dependency "ND_Core"
