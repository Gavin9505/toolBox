#!/usr/bin/bash

#Include source file
source ./tool/config.sh

# Check sourcd file is exist.
if [[ ! -f ./tool/config.sh ]]; then
    echo -e "${RED}Error! config.sh is not exist, Please check './tool/config.sh'.${NC}" >&2
    exit 1
fi




function vim_install {
    local appAllinstall=true

    # Check and Install required package for vim.
    echo -e "${BLUE}Software check and install for Vim.${NC}"
    for softwareName in "${vim_software_list[@]}" 
    do
	    if ! softwareCheckAndInstall "$softwareName" ; then
		    appAllinstall=false
	    fi
    done

    if [ "$appAllinstall" = true ]; then
	    echo -e "${GREEN}All specified software packages are installed.${NC}"
    else
	    echo -e "${RED}Some software packages failed to install. Please check above for details.${NC}"
    fi

    # Clone vim repository from github.
    git clone https://github.com/vim/vim.git ~/toolBox/software/vim
    
    # Into the "vim -> src" folder.
    cd ~/toolBox/software/vim/src || { echo "path not found"; exit 1; }
    
    # Compile project. 
    make
    
    # Install vim
    sudo make install
}

