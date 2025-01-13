#!/usr/bin/bash

#Auto load source file
SCRIPTS_DIR="./tool"

if [ -d "$SCRIPTS_DIR" ]; then
    for script in "$SCRIPTS_DIR"/*.sh; do 
	if [ -f "$script" ] && [ -r "$script" ]; then
	    source "$script"
	fi
    done
fi




function Install {
	echo "Software Installing"
	
	echo -e "${GREEN}Dev tool installing...${NC}"
	devTool

	echo -e "${GREEN}Python installing...${NC}"
	python_install

	echo -e "${GREEN}NodeJs installing...${NC}"	
	nodejs_install

	echo -e "${GREEN}Fzf installing...${NC}"	
	fzf_install
	fzf_config

	echo -e "${GREEN}Vim installing...${NC}"	
	vim_install

	#shellcheck source=/home/gavin/.bashrc
	source "$HOME/.bashrc"

	echo -e "${GREEN}All Software Installed.${NC}"
} 




function menus {
    while getopts "iuh" flag
    do
	case "${flag}" in
	    i) 
		echo "Install software." 
		    Install	
		;;
	    u) 
		echo "Uninstall software" 
		    Uninstall		
		;;
	    h) 
		echo "Help" 
		;;
	    *) 
		echo "Usage: $0 [-i]:Install tool [-u]:Uninstall package [-h]" ;;
	esac
    done
}

#Run menus --------------------------------------------------------------------------------------
menus "$@"




