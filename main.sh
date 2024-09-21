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



function main {
	read  -r -p "Please Enter the task Code: " taskCode

	case ${taskCode} in
		"all")
			echo "All software installing"
			devTool
			python_install
			nodejs_install
			fzf_install
			vim_install
			;;
		"dev")
			echo "Dev tool installing..."
			devTool
			;;

		"python")
			echo "Python installing..."
			python_install		
			;;

		"nodejs")
			echo "NodeJs installing..."	
			nodejs_install					
			;;

		"fzf")
			echo "Fzf installing..."	
			fzf_install
			;;

		"vim")
			echo "Vim installing..."	
			vim_install
			;;

		"-h")
			echo " "
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
