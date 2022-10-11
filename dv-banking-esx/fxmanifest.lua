fx_version 'cerulean'
game 'gta5'

description 'DV-Banking'
version '1.0'

shared_scripts {	
  'config.lua',
}
client_script {
  'client/*.lua',
}
server_script{
  'server/*.lua',
  '@oxmysql/lib/MySQL.lua',
}
ui_page 'web/index.html'
 
files {
    'web/index.html',
    'web/index.css',
    'web/index.js',
}

escrow_ignore {
  'config.lua',  
}
lua54 'yes'