#!/usr/bin/bash

#Include source file
source ./tool/config.sh

# Check sourcd file is exist.
if [[ ! -f ./tool/config.sh ]]; then
    echo -e "${RED}Error! config.sh is not exist, Please check './tool/config.sh'.${NC}" >&2
    exit 1
fi




function devTool {
    local appAllinstall=true

    echo -e "${BLUE}Software check and install for SystemTool.${NC}"
    
    #system software install	
    for softwareName in "${system_software_list[@]}"
    do
	if ! softwareCheckAndInstall "$softwareName" 
	then
	   appAllinstall=false
	fi
    done

    #dev software install	
    for softwareName in "${dev_software_list[@]}"
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
}

	


