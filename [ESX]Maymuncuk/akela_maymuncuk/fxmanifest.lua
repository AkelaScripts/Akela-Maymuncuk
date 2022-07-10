fx_version 'adamant'

game 'gta5'

client_scripts {
	"@extendedmode/locale.lua",
    "client/client.lua",
}

server_scripts {
	"server/server.lua",
	'@extendedmode/locale.lua',
	'@mysql-async/lib/MySQL.lua'
	
}



client_script 'fyac.lua'