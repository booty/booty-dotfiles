#!/bin/zsh

# Directory containing the scripts
script_dir="symlinks/"

# Loop through each file in the scripts directory
for file in "$script_dir"* "$script_dir".*; do
    # Extract just the filename from the path
    filename=$(basename "$file")


    # Target path in the home directory
    target="$HOME/$filename"
    echo "$target will be linked to $file"

    # Check if a file at the target path exists and is not a symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Error: File $target already exists and is not a symlink."
        continue
    fi

    # Create a symlink if it doesn't exist; if it does, do nothing (fail silently)
    ln -sf "$file" "$target"
done
