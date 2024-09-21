#!/usr/bin/bash

#Message color define  
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'



#Software Install List
python_software_list=(
	    "build-essential" \
	    "libssl-dev" \
	    "zlib1g-dev" \
	    "libbz2-dev" \
	    "libreadline-dev" \
	    "libsqlite3-dev" \
	    "libncursesw5-dev" \
	    "xz-utils" "tk-dev" \
	    "libxml2-dev" \
	    "libxmlsec1-dev" \
	    "libffi-dev" \
	    "liblzma-dev" \
	)

dev_software_list=(
	    "gcc" \
	    "cmake" \
	    "make" \
	    "git" \
	    "bear" \
	    "clang"\
	)
	
system_software_list=(
	    "tree" \
	    "curl" \
	    "wget" \
	    "zip" \
	    "unzip" \
	    "openssh-server"
	)

vim_software_list=(
	    "libtool-bin" \
	    "libxt-dev" \
	    "libgtk-3-dev"\
	    "cscope" \
	    "universal-ctags" \
	    "libncurses-dev" \
	    "shellcheck" 
	)




#System software check and install

function systemUpdate {
	sudo apt-get update && sudo apt-get upgrade -y
} 


function softwareCheckAndInstall {
	local softwareName=$1

	if dpkg -l | grep -q "^ii  $softwareName"; then
		echo -e "${GREEN}$softwareName already installed.${NC}"
		return 0
	else
		echo -e "${YELLOW}$softwareName not installed, Installing...${NC}"
		if sudo apt-get install -y "$softwareName"; then
			echo -e "${GREEN}$softwareName installed successfully.${NC}"
			return 0
		else
			echo -e "${RED}Failed to install $softwareName.${NC}"
			return 1
		fi
	fi
}

