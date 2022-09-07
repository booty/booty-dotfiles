# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/    :/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/booty/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="booty"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='subl'
else
  export EDITOR='subl'
fi

#####################################################################################################
# Booty's stuff #####################################################################################
#####################################################################################################

alias worktime="sudo cp /etc/hosts.work-time /etc/hosts"
alias funtime="sudo subl /etc/hosts"
alias zshrc="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"

# Ruby+Rails
alias be="bundle exec"
alias ber="bundle exec rake"
alias bi="bundle install"
alias rc="bundle exec rails console"
alias rs="bundle exec rails server"
alias rrc="bundle exec rescue rails console"
alias rrs="bundle exec rescue rails server"
alias rg="bundle exec rails generate"
alias rdbm="bundle exec rails db:migrate"
alias railtail='tail -f -n 10000 log/development.log | ag -A1 "(Started (POST|GET|PATCH|PUT|DELETE) \"\/.*\")|jbootz|(Processing by.*#.*$)|Rendered"'
alias r="rails"
alias rg="rails g"
alias rt="rails test"
alias rgm="rails generate migration"
alias beg="bundle exec guard"
alias ber="bundle exec rspec"
alias cber="clear; bundle exec rspec"
alias cberr="clear; bundle exec rescue rspec"

alias sublcomp="$EDITOR /Users/booty/Dropbox/Sublime/Packages/User/"

# Git
alias gs="git status"
alias gt="gittower ."
alias ga="git add"
alias gcm="git commit --message"
alias gp="git push"
alias gl="git log"
alias gsl="git log --oneline --decorate -20"
alias gsla="git log --oneline --decorate --graph --all -20"
alias gslap="slap = log --oneline --decorate --graph --all"
alias gd="git diff"
alias gnukelocalorphans="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D"



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

function gco() {
  local branches branch

  # Be a solid bro and point them in the right direction
  # if fzf not installed
  if ! [ -x "$(command -v fzf)" ]; then
    echo "fzf not installed. See https://github.com/junegunn/fzf for info or simply \`brew install fzf\`"
    return 1
  fi

  # If no search term supplied, list them
  if [ -z "$1" ]; then
    branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    return 0
  fi

  # If search term supplied...
  branches=$(git branch | ag $1 | fzf --filter="$1" --no-sort | sed -e 's/^[ \s\*]*//')
  if [ -z "$branches" ]; then
    # No matches!
    return 1
  elif [ $(wc -l <<< "$branches") -eq 1 ]; then
    # There was only one match, so let's jump to it
    git checkout $branches
  else
    # There were multiple matches; list them
    git checkout $(git branch | ag $1 | fzf)
  fi
}

# Basic shell stuff
alias reload="source ~/.zshrc"
alias cag="clear; ag --ignore-dir=vendor,log -W 100 $1"
alias lls="ls -lah"
alias twee="tree --filelimit=20"

# rsync
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-synchronize="rsync -avzu --delete --progress -h"

# Compliancemate - psql (note: these will use the passwords in ~/.pgpass)
# alias set_danger_color="it2setcolor preset 'Solarized Darcula'"
# alias unset_danger_color="it2setcolor preset 'Solarized Light'"
# alias psql_cfa_prod="set_danger_color && psql --host=cm-postgresql-cfa-prod.c8gkpopdiz3i.us-east-1.rds.amazonaws.com --dbname=cmate_production --username=cmcfamaster && unset_danger_color"
# alias psql_cfa_stage="set_danger_color && psql --host=cmpgtest.c8gkpopdiz3i.us-east-1.rds.amazonaws.com --dbname=cmate_staging --username=cmdevops && unset_danger_color"
# alias psql_5g_stage="set_danger_color && psql -U cmfgmaster -h cm-postgresql-fg-staging-5.c8gkpopdiz3i.us-east-1.rds.amazonaws.com -d cmate_production && unset_danger_color"
# alias psql_5g_prod="set_danger_color && echo 'todo' && unset_danger_color"
# alias solar="it2setcolor preset 'Solarized Light'"

# heroku
# alias hk="heroku"

# Projects
alias mm="cd ~/proj/mmagic/mmagic"

# Automate drudgery
alias lossybackup="rsync -avziut /Users/booty/Music/iTunes/iTunes\ Media/Music/ /Volumes/SpaceCowboy/Music/Lossy"
alias losslessbackup="rsync -avziut /Volumes/Stubby512/Dropbox/Music\ and\ Media/Lossless/ /Volumes/SpaceCowboy/Music/Lossless"
alias musicbackup="lossybackup; losslessbackup"
alias cowboybackup="rsync -avziut /Volumes/SpaceCowboy/ /Volumes/SpaceHarrier"
alias brewup="brew update && brew upgrade && brew cleanup && brew doctor"

# Postgres
alias pgconf="$EDITOR /usr/local/var/postgresql@12/postgresql.conf"
alias pgtail="tail -f -n 1000 /usr/local/var/log/postgresql@12.log"

# Redis
alias redistail="tail -f -n 100 /usr/local/var/log/redis.log"
alias redisconf="subl /usr/local/etc/redis.conf"

# Sublime
alias subedit="cd ~/Dropbox/Sublime/Packages/User"

# Usage: deepcp foo.jpg somedir/thatdoesnt/existyet/foo.jpg will create somedir/thatdoesnt/existyet/ if needed
# http://stackoverflow.com/questions/1529946/linux-copy-and-create-destination-dir-if-it-does-not-exist (see bury_copy)
deepcp() { mkdir -p `dirname $2` && cp "$1" "$2"; }
mp3all() { parallel -i -j4 ffmpeg -i {} -qscale:a 0 {}.mp3 ::: ls ./*.flac }
aacall() { parallel -i -j4 ffmpeg -i {} -vn -c:a libfdk_aac -afterburner 1 -vbr 5 {}.m4a ::: ls ./*.flac; }
aacall2() { parallel -i -j4 ffmpeg -i {} -vn -c:a libfdk_aac -vbr 5 {}.m4a ::: ls ./*.m4a; }

#####################################################################################################
# Fun ###############################################################################################
#####################################################################################################

toiletfonts () {
	for f in /usr/local/Cellar/toilet/0.3/share/figlet/*
	do
	  fs=$(basename $f)
	  fname=${fs%%.tlf}
	  toilet -f $fname $fname
	done
}
alias toylet="toilet -w 180 -f mono12"
alias baker="afplay /Users/booty/Dropbox/Music\ and\ Media/ForScripts/BakerStreet.mp3"
alias glory="afplay /Users/booty/Dropbox/Music\ and\ Media/ForScripts/10\ _Together,\ In\ the\ Glory\ of\ the\ Legend_\ from\ Albert\ Odyssey\ 2.mp3"
alias triumph=glory

source $(brew --prefix)/etc/profile.d/z.sh

alias shellcrap="subl ~/.zshrc ~/.oh-my-zsh/themes/booty.zsh-theme ~/.zshenv"

#####################################################################################################
# PSQL stuff ########################################################################################
#####################################################################################################

export HISTFILESIZE=99999999
export HISTSIZE=99999
export PSQL_EDITOR="subl --wait"

#####################################################################################################
# ???? stuff ########################################################################################
#####################################################################################################

source /Users/booty/.iterm2_shell_integration.zsh

alias sshfix="eval \"$(ssh-agent)\" && ssh-add ~/.ssh/id_rsa"

# wtf was this????
# export PATH="/usr/local/sbin:$PATH:/Users/booty/Library/Python/3.7/bin:"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
echo "loaded zshrc"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"

. /usr/local/opt/asdf/libexec/asdf.sh

# source /Users/booty/.config/broot/launcher/bash/br
