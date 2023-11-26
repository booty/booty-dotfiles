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
