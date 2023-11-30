# FZF-powered history search
fzf_history_search() {
    local selected_command
    selected_command=$(fc -l 1 | fzf --height 60% --reverse --no-sort +s --tac --tiebreak=index)

    if [ -n "$selected_command" ]; then
        local cmd
        # Extract the command (remove line numbers)
        cmd=$(echo "$selected_command" | sed 's/^[ ]*[0-9]*[ ]*//')
        # Place the command in the command line buffer
        LBUFFER=$cmd
    fi
    zle redisplay
}

# Bind the function to a key combination (e.g., Ctrl+R)
zle -N fzf_history_search
bindkey '^R' fzf_history_search
