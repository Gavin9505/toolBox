#!/usr/bin/bash

#Include source file
source ./tool/config.sh

function nodejs_install {
	local appAllinstall=true
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

	#shellcheck source=/home/gavin/.bashrc
	source "$HOME/.bashrc"

	#Link nvm folder path.
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 

	nvm install --lts	
}

