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
	read  -r -p "Please Enter the task Code: " taskCode

	case ${taskCode} in
		"0")
			echo "All software installing"
			devTool
			python_install
			nodejs_install
			fzf_install
			vim_install
			;;
		"1")
			echo "Dev tool installing..."
			devTool
			;;

		"2")
			echo "Python installing..."
			python_install		
			;;

		"3")
			echo "NodeJs installing..."	
			nodejs_install					
			;;

		"4")
			echo "Fzf installing..."	
			#fzf_install
			#fzf_config	
			fzf_clear_config

			;;

		"5")
			echo "Vim installing..."	
			vim_install
			;;
		"6")
			echo "Nerd fonts installing"
			nerdfonts_install
			;;
		"-h")
			echo "test help"	
			;;
		*)
			echo "task error!"
			;;
	esac

	#shellcheck source=/home/gavin/.bashrc
	source "$HOME/.bashrc"
} 

function menus {
    
    while getopts "iuh" flag
    do
	case "${flag}" in
	    i) 
		echo "Install software." 
		    Install "$@"	
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

#Run menus
menus "$@"




