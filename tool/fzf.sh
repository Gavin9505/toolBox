#!/usr/bin/bash

#Include source file
source ./tool/config.sh


function fzf_install {
	local appAllinstall=true
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/toolBox/software/fzf		
	~/toolBox/software/fzf/install		

	#shellcheck source=/home/gavin/.bashrc
	source "$HOME/.bashrc"
}


