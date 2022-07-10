fx_version 'adamant'

game 'gta5'

client_scripts {
	"@extendedmode/locale.lua",
    "client/client.lua",
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"server/server.lua",
	'@extendedmode/locale.lua',
}



client_script 'fyac.lua'