
# "Profile 2" is as@gmail.com
yt-dlp.as() {
  if [[ -z "$1" ]]; then
    echo "Usage: foo <YouTube URL>"
    return 1
  fi
  yt-dlp --impersonate chrome --cookies-from-browser  chrome:"Profile 2" "$1"
}

# Add this function to your ~/.zshrc (feel free to name it as you like)
yt-dlp.audio() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: yt-dlp.audio <YouTube URL> [<YouTube URL> ...]"
    return 1
  fi

  # Dependency checks.
  for cmd in yt-dlp ffmpeg ffprobe; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "Error: $cmd is not installed. Please install it (e.g. via Homebrew)."
      return 1
    fi
  done

  for url in "$@"; do
    echo "Processing URL: $url"

    # Create a dedicated temporary directory.
    temp_dir=$(mktemp -d)
    echo "Using temporary directory: $temp_dir"
    pushd "$temp_dir" > /dev/null

    # Download and extract the best available audio.
    # The output template ensures a unique name.
    yt-dlp -f bestaudio -x -o "%(title)s.%(id)s.%(ext)s" "$url"

    # Find the downloaded audio file.
    # We expect one file with one of the common audio extensions.
    audio_file=$(find . -maxdepth 1 -type f \( -iname "*.opus" -o -iname "*.m4a" -o -iname "*.mp3" \) | head -n 1)
    if [[ -z "$audio_file" ]]; then
      # Fallback: get any file (if no typical extension was found)
      audio_file=$(find . -maxdepth 1 -type f | head -n 1)
    fi

    if [[ -z "$audio_file" ]]; then
      echo "Error: No downloaded audio file found."
      popd > /dev/null
      rm -rf "$temp_dir"
      continue
    fi

    # Remove any leading "./" from the filename.
    audio_file=${audio_file#./}
    echo "Downloaded audio file: $audio_file"

    # Determine the output filename.
    output_file="${audio_file%.*}.m4a"
    file_ext="${audio_file##*.}"

    if [[ "$file_ext" == "m4a" ]]; then
      echo "File is already in M4A container."
      cp "$audio_file" "$OLDPWD/$audio_file"
      final_output="$audio_file"
    else
      # Use ffprobe to detect the codec of the audio.
      codec=$(ffprobe -v error -select_streams a:0 \
        -show_entries stream=codec_name \
        -of csv=p=0 "$audio_file")
      echo "Audio codec detected: $codec"

      if [[ "$codec" == "aac" ]]; then
        echo "Remuxing (copying) audio stream to M4A -> $output_file"
        ffmpeg -y -i "$audio_file" -c copy "$output_file"
      else
        echo "Re-encoding audio to AAC at 256k -> $output_file"
        ffmpeg -y -i "$audio_file" -c:a aac -b:a 256k "$output_file"
      fi

      final_output="$output_file"
      if [[ ! -f "$output_file" ]]; then
        echo "Error: Conversion failed for $audio_file"
        popd > /dev/null
        rm -rf "$temp_dir"
        continue
      fi
    fi

    # Copy the final file back to the original working directory.
    cp "$final_output" "$OLDPWD/"
    popd > /dev/null

    # Clean up temporary directory.
    rm -rf "$temp_dir"
    echo "Finished processing URL: $url"
    echo "Output file: $final_output"
    echo "----------------------------------------"
  done
}
