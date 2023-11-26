# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
source "/opt/homebrew/opt/fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"


# Key bindings for fzf command history
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use fzf for command history search
fzf_history() {
    local selected_command
    selected_command=$(fc -l 1 | fzf +s --tac --tiebreak=index | sed 's/^[ ]*[0-9]*[ ]*//')
    if [ -n "$selected_command" ]; then
        LBUFFER="$selected_command"
    fi
    zle redisplay
}

zle -N fzf_history
bindkey '^R' fzf_history

debug_echo "ok?"
