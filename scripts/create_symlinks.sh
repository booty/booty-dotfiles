#!/bin/zsh

setopt EXTENDED_GLOB
setopt NULL_GLOB

dir=~/booty-dotfiles/symlinks

# Loop through each file in the scripts directory
for file in "$dir"/{.,}*; do
    # Skip if it's a directory or the special entries '.' or '..'
    if [ -d "$file" ] || [ "$(basename "$file")" = "." ] || [ "$(basename "$file")" = ".." ]; then
        continue
    fi

    # Extract just the filename from the path
    filename=$(basename "$file")

    # skip this file if it is named .DS_Store
    if [[ "$filename" == ".DS_Store" ]]; then
        continue
    fi

    # Target path in the home directory
    target="$HOME/$filename"
    # if [[ -n "$DEBUG_DOTFILES" ]]; then
      echo "$target will be linked to $file"
    # fi

    # Check if a file at the target path exists and is not a symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "⚠️  Error: File $target already exists and is not a symlink."
        continue
    fi

    # Create a symlink if it doesn't exist; if it does, do nothing (fail silently)
    ln -sf "$file" "$target"
done
