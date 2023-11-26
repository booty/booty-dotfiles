DEBUG_DOTFILES=1

debug_echo() {
    if [[ -n "$DEBUG_DOTFILES" ]]; then
        echo "$1"
    fi
}
debug_echo ".zshrc begin"

. /opt/homebrew/opt/asdf/libexec/asdf.sh
. ~/booty-dotfiles/scripts/create_symlinks.sh

export PATH="/opt/homebrew/bin/:$PATH"

for file in ~/booty-dotfiles/functions/*; do
    if [ -f "$file" ]; then
        debug_echo "sourcing $file"
        source "$file"
    fi
done

# ░░░░░░░░░▀▀█░█▀▀░█░█░░░░░░░░░░
# ░░░░░░░░░▄▀░░▀▀█░█▀█░░░░░░░░░░
# ░░░░░░░░░▀▀▀░▀▀▀░▀░▀░░░░░░░░░░

autoload -Uz compinit
compinit -u

setopt INC_APPEND_HISTORY # Append to history file instead of overwriting
setopt SHARE_HISTORY # Immediate sharing of history between all sessions.
setopt HIST_IGNORE_DUPS

# Make autocomplete case-insensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
# autoload -Uz compinit && compinit
autoload -U colors && colors

# autocompletions, duh. disabled because it kind of sucks?
# source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source /Users/booty/.iterm2_shell_integration.zsh

# ░░░░░░░░░█▀▀░█▀▄░▀█▀░▀█▀░█▀█░█▀▄░█▀▀░░░░░░░░░░
# ░░░░░░░░░█▀▀░█░█░░█░░░█░░█░█░█▀▄░▀▀█░░░░░░░░░░
# ░░░░░░░░░▀▀▀░▀▀░░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀░░░░░░░░░░

export EDITOR="code-insiders"
alias sublcomp="$EDITOR /Users/booty/Dropbox/Sublime/Packages/User/"
alias ci="code-insiders"

alias worktime="sudo cp /etc/hosts.work-time /etc/hosts"
alias funtime="sudo $EDITOR /etc/hosts"
alias zshrc="$EDITOR ~/booty-dotfiles/"

alias brewup="brew update && brew upgrade && brew cleanup && brew doctor"



# ░░░░░░░░░█▀▀░▀▀█░█▀▀░░░░░░░░░░
# ░░░░░░░░░█▀▀░▄▀░░█▀▀░░░░░░░░░░
# ░░░░░░░░░▀░░░▀▀▀░▀░░░░░░░░░░░░

# ~~ Usage ~~
#
# 1. Install fzf via `brew install fzf` or your package manager of choice
# 2. You probably want to copy this to ~/.bashrc or ~/.zshrc, or (better yet) load this file from your .bashrc/.zshrc
# 3. `gco` will list the 30 most recently-active commits
# 4. `gco foo` will list all branches matching "foo"
# 5. If `gco foo` returns only a single result, we skip the list and
#    check it out.
#
#  Particularly Useful for branches named after issue numbers.
#
#  `gco 123` will take you right to "jr-my-long-branch-name-cw-123"
#  assuming you don't have any other branches w/ "123" in them

# function gco() {
#   local branches branch

#   # Be a solid bro and point them in the right direction if fzf not installed
#   if ! [ -x "$(command -v fzf)" ]; then
#     echo "fzf not installed. See https://github.com/junegunn/fzf for info or simply \`brew install fzf\`"
#     return 1
#   fi

#   # If no search term supplied, list them
#   if [ -z "$1" ]; then
#     branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
#     branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
#     git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
#     return 0
#   fi

#   # If search term supplied...
#   branches=$(git branch | ag $1 | fzf --filter="$1" --no-sort | sed -e 's/^[ \s\*]*//')
#   if [ -z "$branches" ]; then
#     return 1 # No matches!
#   elif [ $(wc -l <<< "$branches") -eq 1 ]; then
#     git checkout $branches # There was only one match, so let's jump to it
#   else
#     git checkout $(git branch | ag $1 | fzf) # There were multiple matches; list them
#   fi
# }

# ░░░░░░░░░█▀▀░█░█░█▀▀░█░░░█░░░░░░░░░░░░
# ░░░░░░░░░▀▀█░█▀█░█▀▀░█░░░█░░░░░░░░░░░░
# ░░░░░░░░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░

export HISTFILESIZE=99999999 # max lines in history file on disk
export HISTSIZE=100000 # number of commands in shell's in-memory history (number of commands with up/down arrow)
export SAVEHIST=100000 # number of commands to save in history file after shell closes
alias iterm2clear='echo -e "\033]1337;ClearScrollback\a"'
alias ic='iterm2clear'
alias reload="source ~/.zshrc"

# Find stuff
# alias cag="clear; ag --ignore-dir=vendor,log,venv,node_modules -W 100 $1"
alias cag="iterm2clear; ag --ignore-dir=vendor,log,venv,node_modules -W 100 "
alias cag.py="cag --python "
alias cag.rb="cag --ruby "
alias cag.js="cag --js"

# Directory listing stuff
alias lls="ls -lah"
alias lah="ls -lah"
alias twee.all="tree -I 'node_modules|.git|venv|.DS_Store|__pycache__'"
alias twee="twee.all --filelimit=10 -L 3"
alias twee.3x20="twee.all -L 3 --filelimit=20 "
alias twee.dirs="twee.all -L 99 --filelimit=20 -d"
alias ez="eza --all --color-scale --ignore-glob='.git|venv|node_modules|__pycache__' --icons"
alias et="ez --tree"
alias el="et --long"
alias shellcrap="$EDITOR ~/.zshrc ~/.oh-my-zsh/themes/booty.zsh-theme ~/.zshenv"


# ░░░░░░░░░█▀▀░█░█░█▀█░░░░░░░░░░
# ░░░░░░░░░█▀▀░█░█░█░█░░░░░░░░░░
# ░░░░░░░░░▀░░░▀▀▀░▀░▀░░░░░░░░░░

# list all fonts
toiletfonts () {
	# for f in /usr/local/Cellar/toilet/0.3/share/figlet/*
    for f in /opt/homebrew/Cellar/toilet/0.3/share/figlet/*
	do
	  fs=$(basename $f)
	  fname=${fs%%.tlf}
	  toilet -f $fname $fname
	done
}
function h1() {
    toilet_output=$(toilet -w 180 -f pagga "   $1   ")
    echo "$toilet_output" | sed "s/^/# /"
}
function h1c() {
    toilet_output=$(toilet -w 180 -f pagga "   $1   ")
    echo "$toilet_output" | sed "s/^/# /" | pbcopy
}

alias toylet="toilet -w 180 -f mono12"
alias ttoylet="toilet -w 180 -f pagga"

# ░░░░░░░░░█▀█░█▀▀░▄▀▄░█░░░░░░░░░░░░
# ░░░░░░░░░█▀▀░▀▀█░█\█░█░░░░░░░░░░░░
# ░░░░░░░░░▀░░░▀▀▀░░▀\░▀▀▀░░░░░░░░░░

export PSQL_EDITOR="subl --wait"

# ░░░░░░░░░█▄█░▀█▀░█▀▀░█▀▀░░░░░░░░░░
# ░░░░░░░░░█░█░░█░░▀▀█░█░░░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░

source $(brew --prefix)/etc/profile.d/z.sh

# sanitize history, de-dupe history
HISTFILE=~/.zsh_history
TEMPFILE=$(mktemp)
cat "$HISTFILE" | ag -v "yt\-dlp|youtube\-dl" > "$TEMPFILE" && awk '!seen[$0]++' "$TEMPFILE" > "$HISTFILE"

alias sshfix="eval \"$(ssh-agent)\" && ssh-add ~/.ssh/id_rsa"

# ░░░░░░░░░█▀█░█▀█░▀█▀░█░█░░░░░░░░░░
# ░░░░░░░░░█▀▀░█▀█░░█░░█▀█░░░░░░░░░░
# ░░░░░░░░░▀░░░▀░▀░░▀░░▀░▀░░░░░░░░░░

# needed for some gems, packages e.g. pg, psycopg2like
export PATH="/usr/local/opt/postgresql@16/bin:$PATH"

# ░░░░░░░░░█▀█░█░█░▀█▀░█▀█░░░░░█▀█░█▀▄░█▀▄░█▀▀░█▀▄░░░▀▀█░█░█░█▀█░█░█░░░░░░░░░░
# ░░░░░░░░░█▀█░█░█░░█░░█░█░▄▄▄░█▀█░█░█░█░█░█▀▀░█░█░░░░░█░█░█░█░█░█▀▄░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░░▀░░▀▀▀░░░░░▀░▀░▀▀░░▀▀░░▀▀▀░▀▀░░░░▀▀░░▀▀▀░▀░▀░▀░▀░░░░░░░░░░


# echo "hello" if DEBUG_DOTFILES is set
if [ -n "$DEBUG_DOTFILES" ]; then
    echo ".zshrc end"
fi
