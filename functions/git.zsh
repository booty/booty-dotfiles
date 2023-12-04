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




# Function to fetch branches and pipe into fzf
select_git_branch() {
    # Fetch all branches (local and remote), remove duplicates, and feed into fzf
    branches=$(git branch -a | sed 's/remotes\/origin\///' | awk '!seen[$0]++')
    # Get the current command line content
    local initial_query="$1"

    # Use fzf to select a branch
    selected_branch=$(echo "$branches" | fzf --height 60% --layout=reverse --query="$initial_query")

    # Check if a branch is selected
    if [ -n "$selected_branch" ]; then
        # Strip out any additional characters (like '*')
        clean_branch=$(echo $selected_branch | sed 's/^[* ]*//')

        # Checkout the selected branch
        git checkout $clean_branch
    else
        echo "No branch selected."
    fi
}

alias gco=select_git_branch
