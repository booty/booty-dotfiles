# ░░░░░░░░░█▀▀░▀█▀░▀█▀░░░█▀▀░█░█░█▀▄░░░░░░░░░░
# ░░░░░░░░░█░█░░█░░░█░░░░█░█░█░█░█░█░░░░░░░░░░
# ░░░░░░░░░▀▀▀░▀▀▀░░▀░░░░▀▀▀░▀▀▀░▀▀░░░░░░░░░░░

alias gs="git status"
alias ga="git add"
alias gcm="git commit --message"
alias gp="git push"
alias gl="git log"
alias gd="git diff"

alias g.log="git log --oneline --decorate -20"
alias g.graphlog="git log --oneline --decorate --graph --all"
alias g.fuckyeah="git add . && git commit --amend --no-edit && git push --force"
alias g.unstage="git reset HEAD --"
alias g.amend="git commit --amend --no-edit"
alias g.diff="git diff --staged"

# If you run these by accident and nuke a branch you wanted, you can recover it with:
# git reflog
# git checkout -b <branch_name> <commit_hash>
alias g.nukeorphans="git fetch --prune && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D"
alias g.turbonukeorphans="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D"



# Function to fetch branches and pipe into fzf
select_git_branch() {
    # Fetch all branches (local and remote), remove duplicates, format, and store in an array
    branches=$(git branch -a | sed 's/remotes\/origin\///' | awk '!seen[$0]++' | awk '{$1=$1};1')

    # Get the current command line content
    local initial_query="$1"

    # Check if the input matches an existing branch exactly
    IFS=$'\n' branches_ary=($(echo "${branches[@]}"))
    for branch in "${branches_ary[@]}"; do
        if [ "$branch" = "$initial_query" ]; then
            git checkout "$initial_query"
            return
        fi
    done

    # Use fzf to select a branch if no exact match is found
    selected_branch=$(echo "${branches[@]}" | fzf --height 60% --layout=reverse --query="$initial_query")

    # Check if a branch is selected
    if [ -n "$selected_branch" ]; then
        # Checkout the selected branch
        git checkout "$selected_branch"
    else
        echo "No branch selected."
    fi
}



alias gco=select_git_branch
