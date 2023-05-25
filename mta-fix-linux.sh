#!/bin/bash
#
# mta-fix-linux.sh - by: proxlu@debian

# Estrutura
diretorio=$(dirname $0)
if [ -f "$diretorio/Multi Theft Auto.exe" ];then
	# Ajuda
	if [ "$1" = "-*" ];then
	echo 'Uso: mta-fix-linux.sh [--ajuda|--versão] Comandos de inicialização'
	echo '  '
	echo 'Versão: 1.0' 
	echo '  '
	# Inicialização
	elif [ -d "$diretorio/multitheftauto_linux" -o -d "$diretorio/multitheftauto_linux_x64" ];then
		iniciar(){
			wine --version&>/dev/null&&wine "$diretorio/Multi Theft Auto.exe"
			wine --version&>/dev/null||yad --text 'É necessário ter o WINE instalado, para instruções visite: https://wiki.winehq.org/Download'
		}
		iniciar
	# Correções
	else
		instalar(){
			cd "$diretorio"
			wget https://github.com/matomo-org/travis-scripts/raw/master/fonts/Verdana.ttf https://linux.mtasa.com/dl/multitheftauto_linux.tar.gz https://linux.mtasa.com/dl/multitheftauto_linux_x64.tar.gz https://linux.mtasa.com/dl/baseconfig.tar.gz
			mv Verdana.ttf "$HOME"/.wine/drive_c/windows/Fonts
			tar -xf multitheftauto_linux_x64.tar.gz
			tar -xf multitheftauto_linux.tar.gz
			tar -xf baseconfig.tar.gz
			cp baseconfig/* multitheftauto_linux/mods/deathmatch
	        	mv baseconfig/* multitheftauto_linux_x64/mods/deathmatch
		    	mkdir mods/deathmatch/resources
			cd mods/deathmatch/resources
			wget https://mirror.mtasa.com/mtasa/resources/mtasa-resources-latest.zip
	    		unzip mtasa-resources-latest.zip
    			cd ../../..
	                rm -r multitheftauto_linux_x64.tar.gz multitheftauto_linux.tar.gz baseconfig.tar.gz mods/deathmatch/resources/mtasa-resources-latest.zip baseconfig/
			multitheftauto_linux/mta-server&
			sleep 3
			kill -9 $!
			multitheftauto_linux_64/mta-server64&
			sleep 3
			kill -9 $!
			cd
		}
		unzip -v&>/dev/null||(yad --text 'É necessário ter o zip/unzip instalado, tente em um terminal: "sudo apt install zip -y"';exit)
		instalar&>/dev/null
		iniciar
	fi
else
	yad --text 'Diretório inválido: Coloque este executável na raíz da pasta do MTA'
fi
