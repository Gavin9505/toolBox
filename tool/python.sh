#!/usr/bin/bash

#Include source file
source ./tool/config.sh

	
function python_install {
	local appAllinstall=true


	curl https://pyenv.run | bash

	
	export PYENV_ROOT="$HOME/.pyenv" >> ~/.bashrc
	command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH" >> ~/.bashrc
	eval "$(pyenv init -)" >> ~/.bashrc


	#shellcheck source=/home/gavin/.bashrc
	source "$HOME/.bashrc"

	#python software installing
	echo -e "${BLUE}Software check and install for Python.${NC}"

	for softwareName in "${python_software_list[@]}"
	do
		if ! softwareCheckAndInstall "$softwareName" 
		then
			appAllinstall=false
		fi
	done

	if [ "$appAllinstall" = true ] 
	then
		echo -e "${GREEN}All specified software packages are installed.${NC}"
	else
		echo -e "${RED}Some software packages failed to install. Please check above for details.${NC}"
	fi

	pyenv update

}


