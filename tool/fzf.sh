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




function fzf_config() {
    local rcfile="$HOME/.bashrc"

    # FZF_CTRL_T_OPTS
    grep -qE '^export FZF_CTRL_T_OPTS=' "$rcfile" || cat << 'EOF' >> "$rcfile"

# --- FZF CTRL-T config ---
export FZF_CTRL_T_OPTS="
	  --walker-skip .git,node_modules,target
	  --preview '(bat -p --color=always {} 2> /dev/null || cat {} || tree -C {}) | head -800'
	  --bind 'ctrl-/:toggle-preview'
	  --select-1
	  --exit-0
	  --layout=reverse
"
EOF

    # FZF_CTRL_R_OPTS
    grep -qE '^export FZF_CTRL_R_OPTS=' "$rcfile" || cat << 'EOF' >> "$rcfile"

# --- FZF CTRL-R config ---
export FZF_CTRL_R_OPTS="
	  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
	  --color header:italic
	  --header 'Press CTRL-Y to copy command into clipboard'
	  --no-sort
	  --exact
	  --layout=reverse
	"
EOF

    # FZF_ALT_C_OPTS
    grep -qE '^export FZF_ALT_C_OPTS=' "$rcfile" || cat << 'EOF' >> "$rcfile"

# --- FZF ALT-C config ---
export FZF_ALT_C_OPTS="
	  --walker-skip .git,node_modules,target
	  --preview 'tree -C {} | head -200'
	  --layout=reverse
	"
EOF

    # FZF_DEFAULT_OPTS
    grep -qE '^export FZF_DEFAULT_OPTS=' "$rcfile" || cat << 'EOF' >> "$rcfile"

# --- FZF default options ---
export FZF_DEFAULT_OPTS="
	  --height=40%
	  --tmux bottom,40%
	  --border=top
	  --info=inline
	  --margin=1
	  --padding=1
	  --color=fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
	  --color=info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
	"
EOF

    echo "[FZF 多行配置已加入 $rcfile] ✅"
}




function fzf_clear_config {
    local CONFIG_FILE="${1:-$HOME/.bashrc}"

    echo "Cleaning FZF-related configurations from: $CONFIG_FILE"

    # Patterns to match. Use flexible matching to allow for multiline variants.
    local -a PATTERNS=(
        '^export FZF_CTRL_T_OPTS='
        '^export FZF_CTRL_R_OPTS='
        '^export FZF_ALT_C_OPTS='
        '^export FZF_DEFAULT_OPTS='
    )

    for PATTERN in "${PATTERNS[@]}"; do
        if grep -qE "$PATTERN" "$CONFIG_FILE"; then
            echo -e "\033[0;33mDeleting block: $PATTERN\033[0m"
            # Delete multi-line export using sed. Handles line continuations with '\'
            sed -i "/$PATTERN/,/^[^ ]*[^\\]$/d" "$CONFIG_FILE"
        else
            echo -e "\033[0;33mPattern not found: $PATTERN\033[0m"
        fi
    done

    echo -e "\033[0;32mAll FZF configurations cleared from $CONFIG_FILE.\033[0m"
}

