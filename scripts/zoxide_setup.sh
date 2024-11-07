# Save this script as add_to_zoxide.sh
#!/bin/bash

# List of top-level directories to include
dirs=(
    "$HOME/code"
    "$HOME/code/mzml_web"
    "/Volumes/Pokey"
    "/Volumes/Pokey/Video/Ganked"
    "$HOME"
)

# Loop over each top-level directory
for top_dir in "${dirs[@]}"; do
    # Add the top-level directory itself
    zoxide add "$top_dir"

    # Find and add all directories at depth 1 (immediate children)
    find "$top_dir" -mindepth 1 -maxdepth 1 -type d -exec zoxide add {} \;
done
