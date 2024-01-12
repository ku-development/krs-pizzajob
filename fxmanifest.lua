fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
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

-- make sure to disable if u dont want the cars
files {
	'stream/vehicles.meta',
	'stream/carvariations.meta',
	'stream/carcols.meta',
	'stream/handling.meta',
	'stream/dlctext.meta',
	'stream/vehiclelayouts.meta',
}
 
data_file 'HANDLING_FILE' 'stream/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'stream/vehicles.meta'
data_file 'CARCOLS_FILE' 'stream/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'stream/carvariations.meta'
data_file 'DLC_TEXT_FILE' 'stream/dlctext.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'stream/vehiclelayouts.meta'