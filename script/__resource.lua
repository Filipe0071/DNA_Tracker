fx_version 'adamant'
game 'gta5'


client_scripts {
  'include.lua',
	'config.lua',
  'utils.lua',
	'client.lua',
}

server_scripts {	
  '@mysql-async/lib/MySQL.lua',
  'incl.lua',
	'config.lua',
  'utils.lua',
	'server.lua',
}