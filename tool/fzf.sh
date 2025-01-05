#!/usr/bin/bash

#Include source file.
source ./tool/config.sh

# Check sourcd file is exist.
if [[ ! -f ./tool/config.sh ]]; then
    echo -e "${RED}Error! config.sh is not exist, Please check './tool/config.sh'.${NC}" >&2
    exit 1
fi


function fzf_install {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/toolBox/software/fzf		
	~/toolBox/software/fzf/install		
}

function fzf_Uninstall {
    bash $HOME/toolBox/software/fzf/uninstall.sh 
}


function fzf_config {
    #CTRL-T
    grep -q 'export FZF_CTRL_T_OPTS=' ~/.bashrc || echo 'export FZF_CTRL_T_OPTS="--exit-0 --preview '\''(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'\'' --bind '\''?:toggle-preview'\''"' >> ~/.bashrc
    #CTRL-R
    grep -q 'export FZF_CTRL_R_OPTS=' ~/.bashrc || echo 'export FZF_CTRL_R_OPTS="--exact --preview '\''echo {}'\'' --preview-window down:3:hidden:wrap --bind '\''?:toggle-preview'\''"' >> ~/.bashrc
    #ALT-C
    grep -q 'export FZF_ALT_C_OPTS=' ~/.bashrc || echo 'export FZF_ALT_C_OPTS="--preview '\''tree -C {} | head -200'\''"' >> ~/.bashrc
    #Color 
    grep -q 'export FZF_DEFAULT_OPTS=' ~/.bashrc || echo 'export FZF_DEFAULT_OPTS="--color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f 
	--color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54"' >> ~/.bashrc
}




function fzf_clear_config {


}

