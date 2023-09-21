# ░░░░░░░░░▀▀█░█▀▀░█░█░░░░░░░░░░
# ░░░░░░░░░▄▀░░▀▀█░█▀█░░░░░░░░░░
# ░░░░░░░░░▀▀▀░▀▀▀░▀░▀░░░░░░░░░░

# Make autocomplete case-insensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh # autocompletions, duh

# ░░░░░░░░░█▀▀░█▀▄░▀█▀░▀█▀░█▀█░█▀▄░█▀▀░░░░░░░░░░
# ░░░░░░░░░█▀▀░█░█░░█░░░█░░█░█░█▀▄░▀▀█░░░░░░░░░░
# ░░░░░░░░░▀▀▀░▀▀░░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀░░░░░░░░░░

export EDITOR="code-insiders"
alias sublcomp="$EDITOR /Users/booty/Dropbox/Sublime/Packages/User/"

# ░░░░░░░░░█▀█░█░█░▀█▀░█▀█░█▄█░█▀█░▀█▀░█▀▀░░░░░░░░░░
# ░░░░░░░░░█▀█░█░█░░█░░█░█░█░█░█▀█░░█░░█▀▀░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░░▀░░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░░░░░░░░░░

alias worktime="sudo cp /etc/hosts.work-time /etc/hosts"
alias funtime="sudo $EDITOR /etc/hosts"
alias zshrc="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

# ░░░░░░░░░█▀▄░█░█░█▀▄░█░█░░░░░░░░░░
# ░░░░░░░░░█▀▄░█░█░█▀▄░░█░░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░▀▀░░░▀░░░░░░░░░░░

alias be="bundle exec"
alias ber="bundle exec ruby"
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
alias rr="rails routes | ag -v \"active_storage|action_mailbox|turbo\""
alias rrr="rails routes"
alias beg="bundle exec guard"
alias ber="bundle exec rspec"
alias cber="clear; bundle exec rspec"
alias cberr="clear; bundle exec rescue rspec"

# ░░░░░░░░░█▀▀░▀█▀░▀█▀░░░█▀▀░█░█░█▀▄░░░░░░░░░░
# ░░░░░░░░░█░█░░█░░░█░░░░█░█░█░█░█░█░░░░░░░░░░
# ░░░░░░░░░▀▀▀░▀▀▀░░▀░░░░▀▀▀░▀▀▀░▀▀░░░░░░░░░░░

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

# ░░░░░░░░░█▀█░█░█░▀█▀░█░█░█▀█░█▀█░░░░░░░░░░
# ░░░░░░░░░█▀▀░░█░░░█░░█▀█░█░█░█░█░░░░░░░░░░
# ░░░░░░░░░▀░░░░▀░░░▀░░▀░▀░▀▀▀░▀░▀░░░░░░░░░░

alias va="source venv/bin/activate"
alias p3="python3"
alias pv="python3 --version"
alias pynew="rsync -av /Volumes/Huggy/code/samplemod/ . --exclude='.git/' && curl https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore -o .gitignore && git init"

# ░░░░░░░░░█▀▄░█▀▀░█░█░░░█▄█░▀█▀░█▀▀░█▀▀░░░░░░░░░░
# ░░░░░░░░░█░█░█▀▀░▀▄▀░░░█░█░░█░░▀▀█░█░░░░░░░░░░░░
# ░░░░░░░░░▀▀░░▀▀▀░░▀░░░░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░

# Compliancemate - psql (note: these will use the passwords in ~/.pgpass)
# alias set_danger_color="it2setcolor preset 'Solarized Darcula'"
# alias unset_danger_color="it2setcolor preset 'Solarized Light'"
# alias psql_cfa_prod="set_danger_color && psql --host=cm-postgresql-cfa-prod.c8gkpopdiz3i.us-east-1.rds.amazonaws.com --dbname=cmate_production --username=cmcfamaster && unset_danger_color"
# alias psql_5g_prod="set_danger_color && echo 'todo' && unset_danger_color"
# alias solar="it2setcolor preset 'Solarized Light'"

# Automate drudgery
alias brewup="brew update && brew upgrade && brew cleanup && brew doctor"

# Postgres
alias pgconf="$EDITOR /usr/local/var/postgresql@14/postgresql.conf"
alias pgtail="tail -f -n 1000 /usr/local/var/log/postgresql@14.log"

# Redis
alias redistail="tail -f -n 100 /usr/local/var/log/redis.log"
alias redisconf="$EDITOR /usr/local/etc/redis.conf"

# Misc misc
alias subedit="cd ~/Dropbox/Sublime/Packages/User"

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

function gco() {
  local branches branch

  # Be a solid bro and point them in the right direction if fzf not installed
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
    return 1 # No matches!
  elif [ $(wc -l <<< "$branches") -eq 1 ]; then
    git checkout $branches # There was only one match, so let's jump to it
  else
    git checkout $(git branch | ag $1 | fzf) # There were multiple matches; list them
  fi
}

# ░░░░░░░░░█▀▀░█░█░█▀▀░█░░░█░░░░░░░░░░░░
# ░░░░░░░░░▀▀█░█▀█░█▀▀░█░░░█░░░░░░░░░░░░
# ░░░░░░░░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░

alias reload="source ~/.zshrc"
alias cag="clear; ag --ignore-dir=vendor,log -W 100 $1"
alias lls="ls -lah"
alias lah="ls -lah"
alias twee="tree --filelimit=20"
alias ez="eza --all --color-scale --ignore-glob='.git|venv' --icons"
alias et="ez --tree"
alias el="et --long"
alias shellcrap="$EDITOR ~/.zshrc ~/.oh-my-zsh/themes/booty.zsh-theme ~/.zshenv"

# ░░░░░░░░░█▀▄░█▀▀░█░█░█▀█░█▀▀░░░░░░░░░░
# ░░░░░░░░░█▀▄░▀▀█░░█░░█░█░█░░░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░░░░░░░░░░

alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-synchronize="rsync -avzu --delete --progress -h"
alias cowboybackup="rsync -avziut /Volumes/SpaceCowboy/ /Volumes/SpaceHarrier"

# ░░░░░░░░░█▄█░█░█░█▀▀░▀█▀░█▀▀░░░░░░░░░░
# ░░░░░░░░░█░█░█░█░▀▀█░░█░░█░░░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░

mp3all() { parallel -i -j6 ffmpeg -i {} -qscale:a -vcodec copy  0 {}.mp3 ::: ls ./*.flac }
aacall() { parallel -i -j6 ffmpeg -i {} -vn -c:a libfdk_aac -afterburner 1 -vbr 5 -vcodec copy  {}.m4a ::: ls ./*.flac; }
aacall2() { parallel -i -j6 ffmpeg -i {} -vn -c:a libfdk_aac -vbr 5 -vcodec copy  {}.m4a ::: ls ./*.m4a; }
alacall() { parallel -i -j6 ffmpeg -i {} -acodec alac -vcodec copy {}.m4a ::: ls ./*.flac; }
alias lossybackup="rsync -avziut /Users/booty/Music/iTunes/iTunes\ Media/Music/ /Volumes/SpaceCowboy/Music/Lossy"
alias losslessbackup="rsync -avziut /Volumes/Stubby512/Dropbox/Music\ and\ Media/Lossless/ /Volumes/SpaceCowboy/Music/Lossless"
alias musicbackup="lossybackup; losslessbackup"

# ░░░░░░░░░█▀▄░█▀█░█▀▀░█░█░█▀▀░█▀▄░░░░░░░░░░
# ░░░░░░░░░█░█░█░█░█░░░█▀▄░█▀▀░█▀▄░░░░░░░░░░
# ░░░░░░░░░▀▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░░░░░░░░░

alias d.up='docker compose up'
alias d.down='docker compose down'
alias d.kick='docker compose restart'
alias d.stop='docker compose stop'
alias d.ps='docker compose ps'
alias d.build='docker compose up -d --build --force-recreate' # Rebuild Container
alias d.logs='docker compose logs -f --tail=100'
alias d.bomb='docker stop $(docker ps -q) || true && docker rm -v $(docker ps -aq) || true' # Destroy all containers (including running ones)
alias d.nuke='d.bomb && docker rmi $(docker images)' # Destroy all containers & images
alias d.clean='docker rm -v $(docker ps -aq) || true' # Cleanup exited containers
alias d.imgclean='docker rmi $(docker images) || true' # Cleanup images
alias d.sync='docker run -it --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i date -u $(date -u +%m%d%H%M%Y)' # Resync time within docker container

# ░░░░░░░░░█▀▀░█░█░█▀█░░░░░░░░░░
# ░░░░░░░░░█▀▀░█░█░█░█░░░░░░░░░░
# ░░░░░░░░░▀░░░▀▀▀░▀░▀░░░░░░░░░░

# list all fonts
toiletfonts () {
	for f in /usr/local/Cellar/toilet/0.3/share/figlet/*
	do
	  fs=$(basename $f)
	  fname=${fs%%.tlf}
	  toilet -f $fname $fname
	done
}
alias toylet="toilet -w 180 -f mono12"
alias ttoylet="toilet -w 180 -f pagga" # Used to generate the "headers" in this file

# ░░░░░░░░░█▀█░█▀▀░▄▀▄░█░░░░░░░░░░░░
# ░░░░░░░░░█▀▀░▀▀█░█\█░█░░░░░░░░░░░░
# ░░░░░░░░░▀░░░▀▀▀░░▀\░▀▀▀░░░░░░░░░░

export HISTFILESIZE=99999999
export HISTSIZE=99999
export PSQL_EDITOR="subl --wait"

# ░░░░░░░░░█▄█░▀█▀░█▀▀░█▀▀░░░░░░░░░░
# ░░░░░░░░░█░█░░█░░▀▀█░█░░░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░

source $(brew --prefix)/etc/profile.d/z.sh

# sanitize history
cat ~/.zsh_history | ag -v "yt\-dlp|youtube\-dl" > ~/.zsh_history-tmp && mv ~/.zsh_history-tmp ~/.zsh_history

source /Users/booty/.iterm2_shell_integration.zsh

alias sshfix="eval \"$(ssh-agent)\" && ssh-add ~/.ssh/id_rsa"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. /usr/local/opt/asdf/libexec/asdf.sh

autoload -U colors && colors
PS1="%{$fg[yellow]%}%5~ %{$reset_color%}% $ "
RPROMPT="%F{111}[%n@%m %D{%f/%m/%y} %@]"

# ░░░░░░░░░█▀█░█▀█░▀█▀░█░█░░░░░░░░░░
# ░░░░░░░░░█▀▀░█▀█░░█░░█▀█░░░░░░░░░░
# ░░░░░░░░░▀░░░▀░▀░░▀░░▀░▀░░░░░░░░░░

export PATH="/usr/local/opt/postgresql@15/bin:$PATH"

echo "loaded zshrc"