

# Function to fetch branches and pipe into fzf
select_git_branch() {
    # Fetch all branches (local and remote), remove duplicates, and feed into fzf
    branches=$(git branch -a | sed 's/remotes\/origin\///' | awk '!seen[$0]++')

    # Use fzf to select a branch
    selected_branch=$(echo "$branches" | fzf --height 20% --layout=reverse --border)

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
