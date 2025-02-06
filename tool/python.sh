#!/usr/bin/bash

#Include source file
source ./tool/config.sh

# Check sourcd file is exist.
if [[ ! -f ./tool/config.sh ]]; then
    echo -e "${RED}Error! config.sh is not exist, Please check './tool/config.sh'.${NC}" >&2
    exit 1
fi




function python_install {
    local appAllinstall=true

    curl https://pyenv.run | bash
    
    export PYENV_ROOT="$HOME/.pyenv" >> ~/.bashrc
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH" >> ~/.bashrc
    eval "$(pyenv init -)" >> ~/.bashrc

    #shellcheck source=/home/gavin/.bashrc
    source "$HOME/.bashrc"

    # Check and Install required package for python.
    echo -e "${BLUE}Software check and install for Python.${NC}"

    for softwareName in "${python_software_list[@]}"
    do
	if ! softwareCheckAndInstall "$softwareName" 
	then
	    appAllinstall=false
	fi
    done

    if [ "$appAllinstall" = true ]; then
	echo -e "${GREEN}All specified software packages are installed.${NC}"
    else
	echo -e "${RED}Some software packages failed to install. Please check above for details.${NC}"
    fi

    # Update pyenv
    pyenv update
}


