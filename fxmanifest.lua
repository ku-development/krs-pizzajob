fx_version 'cerulean'
games { 'gta5' }

name         'krs-pizzajob'
version      '1.0.0'
description  'A fully immersive pizzajob job.'
author       'KurdY'

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}