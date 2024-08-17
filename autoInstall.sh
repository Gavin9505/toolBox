#!/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'


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





function Python {
	local appAllinstall=true
	local appList=("build-essential" "libssl-dev" "zlib1g-dev" "libbz2-dev" "libreadline-dev" \
	"libsqlite3-dev" "libncursesw5-dev" "xz-utils" "tk-dev" "libxml2-dev" "libxmlsec1-dev" \
	"libffi-dev" "liblzma-dev")

	curl https://pyenv.run | bash

	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
	echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
	echo 'eval "$(pyenv init -)"' >> ~/.bashrc


	#shellcheck source=/home/gavin/.bashrc
	source . "$HOME/.bashrc"


	echo -e "${BLUE}Software check and install for Python.${NC}"
			
	for softwareName in "${appList[@]}"
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

function Vim {
	local appAllinstall=true
	local appList=("cscope" "universal-ctags" "libncurses-dev" "shellcheck")

	echo -e "${BLUE}Software check and install for Vim.${NC}"
			
	for softwareName in "${appList[@]}"
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

}

function Fzf {
	local appAllinstall=true
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/toolBox/software/fzf		
	~/toolBox/software/fzf/install		

	#shellcheck source=/home/gavin/.bashrc
	source . "$HOME/.bashrc"
}

function Nodejs {
	local appAllinstall=true
	local appList=()
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

	#shellcheck source=/home/gavin/.bashrc
	source . "$HOME/.bashrc"
	
	nvm install --lts	
}

function Toolchain {
	local appAllinstall=true
	local appList=("gcc" "cmake" "make" "git" "bear")
	
	echo -e "${BLUE}Software check and install for toolchain.${NC}"
			
	for softwareName in "${appList[@]}"
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

}

function SystemTool {
	local appAllinstall=true
	local appList=("tree" "curl" "wget" "zip" "unzip")

	echo -e "${BLUE}Software check and install for SystemTool.${NC}"
			
	for softwareName in "${appList[@]}"
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


}

function main {
	read  -r -p "Please Enter the task Code: " taskCode

	case ${taskCode} in

		"python")
			echo "Python installing..."
			Python		
			;;

		"nodejs")
			echo "NodeJs installing..."	
			Nodejs					
			;;

		"fzf")
			echo "Fzf installing..."	
			Fzf
			;;


		"vim")
			echo "Vim installing..."	
			Vim
			;;


		"toolchain")
			echo "ARM toolchain installing..."
			Toolchain	
			;;
		"systemtool")
			echo "System tool installing..."
			SystemTool
			;;

		"-h")
			echo "AppList:"
			echo "    python"
			echo "    nodejs"
			echo "    fzf"
			echo "    vim"
			echo "    toolchain"
			echo "    systemtool"
			;;
		*)
			echo "task error!"
			;;
	esac
} 


main
