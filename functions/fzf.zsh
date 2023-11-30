fzf_history_search() {
    local selected_command
    # Get the current command line content
    local initial_query="$LBUFFER"

    selected_command=$(fc -l 1 | fzf --height 60% --reverse --no-sort +s --tac --tiebreak=index --query="$initial_query")

    if [ -n "$selected_command" ]; then
        local cmd
        # Extract the command (remove line numbers)
        cmd=$(echo "$selected_command" | sed 's/^[ ]*[0-9]*[ ]*//')
        # Place the command in the command line buffer
        LBUFFER=$cmd
    fi
    zle redisplay
}

# Bind this function to Ctrl-R
zle -N fzf_history_search
bindkey '^R' fzf_history_search
