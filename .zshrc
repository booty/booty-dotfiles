# Uncomment this for verbosity
# DEBUG_DOTFILES=1

debug_echo() {
    if [[ -n "$DEBUG_DOTFILES" ]]; then
        echo "$1"
    fi
}
debug_echo ".zshrc begin"

. /opt/homebrew/opt/asdf/libexec/asdf.sh
. ~/booty-dotfiles/scripts/create_symlinks.sh

export PATH="/opt/homebrew/bin/:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Load everything in functions/
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

# Make autocomplete case-insensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -U colors && colors


# ░░░░░░░░░█▀▀░█▀▄░▀█▀░▀█▀░█▀█░█▀▄░█▀▀░░░░░░░░░░
# ░░░░░░░░░█▀▀░█░█░░█░░░█░░█░█░█▀▄░▀▀█░░░░░░░░░░
# ░░░░░░░░░▀▀▀░▀▀░░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀░░░░░░░░░░

export EDITOR="code-insiders"
alias sublcomp="$EDITOR /Users/booty/Dropbox/Sublime/Packages/User/"
alias ci="code-insiders"

# alias worktime="sudo cp /etc/hosts.work-time /etc/hosts"
# alias funtime="sudo $EDITOR /etc/hosts"
alias zshrc="cd ~/booty-dotfiles && $EDITOR ~/booty-dotfiles/"

alias brewup="brew update && brew upgrade && brew cleanup && brew doctor"



# ░░░░░░░░░█▀▀░█░█░█▀▀░█░░░█░░░░░░░░░░░░
# ░░░░░░░░░▀▀█░█▀█░█▀▀░█░░░█░░░░░░░░░░░░
# ░░░░░░░░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░



HISTFILE="$HOME/.zsh_history"

# sanitize history, de-dupe history
TEMPFILE=$(mktemp)
cat "$HISTFILE" | ag -v "yt\-dl|youtube\-dl" > "$TEMPFILE" && awk '!seen[$0]++' "$TEMPFILE" > "$HISTFILE"

HISTSIZE=1000000
SAVEHIST=1000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
# setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# fc  -R                           # Load full history file from disk now that we've set all options

# echo "Pre-fc: HISTSIZE=$HISTSIZE, SAVEHIST=$SAVEHIST, HISTFILE=$HISTFILE"
# echo "Pre-fc: Loaded $(fc -l | wc -l) commands"
fc -R
# echo "Post-fc: Loaded $(fc -l | wc -l) commands"
# echo "~~what the fuck~~"

alias iterm2clear='echo -e "\033]1337;ClearScrollback\a"'
alias ic='iterm2clear'
alias reload="source ~/.zshrc"

# Find stuff
alias cag="iterm2clear; ag --ignore-dir=vendor,log,venv,node_modules -W 100 "
alias cag.py="cag --python "
alias cag.rb="cag --ruby "
alias cag.js="cag --js"

ffind() {                                                                        [~/code/mzml_web]
    find . -type f -name "*$1*"
}


# Directory listing stuff
alias lls="ls -lah"
alias lah="ls -lah"
alias twee.all="tree -I 'node_modules|.git|venv|.DS_Store|__pycache__'"
alias twee="twee.all --filelimit=10 -L 3"
alias twee.3x20="twee.all -L 3 --filelimit=20 "
alias twee.dirs="twee.all -L 99 --filelimit=20 -d"


alias shellcrap="$EDITOR ~/.zshrc ~/.oh-my-zsh/themes/booty.zsh-theme ~/.zshenv"

alias l="lsd"
alias la="lsd -a"
alias ll="lsd -lah"
alias lt="lsd --tree"
alias ltd="lsd --tree -d"
alias lsd.tree="lsd --tree"
alias lsd.treed="lsd --tree -d"
alias lsd.treed.3="lsd --tree -d -L 3"


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
alias ic='echo -e "\033]1337;ClearScrollback\a"'

# ░░░░░░░▀▀█░█▀█░█░█░▀█▀░█▀▄░█▀▀░░░░░░
# ░░░░░░░▄▀░░█░█░▄▀▄░░█░░█░█░█▀▀░░░░░░
# ░░░░░░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀░░▀▀▀░░░░░░

eval "$(zoxide init zsh)"

# Non-interactive query, takes arguments directly
z() {
    local dir
    dir=$(zoxide query "$@") && cd "$dir"
}

# Interactive mode, no initial input
zz() {
    local dir
    dir=$(zoxide query --interactive "$@") && cd "$dir"
}


# ░░░░░░░░░█▄█░▀█▀░█▀▀░█▀▀░░░░░░░░░░
# ░░░░░░░░░█░█░░█░░▀▀█░█░░░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░




alias sshfix="eval \"$(ssh-agent)\" && ssh-add ~/.ssh/id_rsa"

# echo "hello" if DEBUG_DOTFILES is set
if [ -n "$DEBUG_DOTFILES" ]; then
    echo ".zshrc end"
fi
export PATH="$PATH:/opt/homebrew/opt/openjdk/bin"
export PATH="$PATH:/Users/booty/.cargo/bin"
export PATH="$PATH:/usr/local/bin/nextflow"
export JAVA_CMD=/opt/homebrew/opt/openjdk/bin/java


# ░░░░░░░░░█▀█░█░█░▀█▀░█▀█░░░░░█▀█░█▀▄░█▀▄░█▀▀░█▀▄░░░▀▀█░█░█░█▀█░█░█░░░░░░░░░░
# ░░░░░░░░░█▀█░█░█░░█░░█░█░▄▄▄░█▀█░█░█░█░█░█▀▀░█░█░░░░░█░█░█░█░█░█▀▄░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░░▀░░▀▀▀░░░░░▀░▀░▀▀░░▀▀░░▀▀▀░▀▀░░░░▀▀░░▀▀▀░▀░▀░▀░▀░░░░░░░░░░

# Created by `pipx` on 2025-06-11 22:14:43
export PATH="$PATH:/Users/booty/.local/bin"
