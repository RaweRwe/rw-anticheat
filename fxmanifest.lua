fx_version 'adamant'

game 'gta5'
description 'Rawe AntiCheat'
author 'Rawe'
version '4.3'

ui_page "html/index.html"

files {
    'html/*.html',
    'html/*.js'
}

client_scripts {
    'config.lua',
    'client.lua',
    'Enumerators.lua'
}

server_scripts {
    'config.lua', 
    'server.lua'
}