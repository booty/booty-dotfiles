export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --color=bg+:24,hl:135,fg:252,header:202,spinner:108,pointer:167,marker:214,prompt:110
"

fzf-history-widget() {
  local selected
  # Use BUFFER as the default query for fzf
  # tac reverses the order of the history (it's cat backward lol)
  selected=$(history 1 | tac | sed 's/\*//' | fzf --height=80% --layout=reverse --scheme=history --query="$BUFFER" | sed 's/ *[0-9]* *//')
  if [[ -n $selected ]]; then
    BUFFER=$selected
    CURSOR=$#BUFFER
  fi
  zle redisplay
}

zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
