export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --color=bg+:24,hl:135,fg:252,header:202,spinner:108,pointer:167,marker:214,prompt:110
"


# Bind CTRL-R to an fzf-enabled reverse search
fzf-history-widget() {
  BUFFER=$(history | sed 's/\*//' | fzf --height=40% --layout=reverse --tac | sed 's/ *[0-9]* *//')
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
