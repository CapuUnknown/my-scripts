#!/bin/bash

files=("$HOME/Downloads/convert/"*.mkv)
if [[ ${#files[@]} -eq 0 ]]; then
  echo 'No .mkv files found, in directory' >&2
  exit 1
fi

for file in "${files[@]}"; do
  if [[ -f "$file" ]]; then

    dir=$(dirname "$file")   # Extract dir path
    base=$(basename "$file") # Extract file name with extension
    name="${base%.*}"        # Remove extension
    sub="${dir}/subbed_${name}"
    mkv="${sub}.mkv"
    mp4="${sub}.mp4"
    temp="${dir}/temp.mkv"
    mv "$file" "$temp"

    echo "Now working on: $base"
    ffmpeg -i "$temp" -vf subtitles="$temp" "$mkv" >/dev/null 2>&1
    ffmpeg -i "$mkv" -c:v libx264 -crf 23 -preset slow -c:a aac -b:a 300k "$mp4" >/dev/null 2>&1

    if [[ -f "$mp4" ]]; then
      echo "Succesfully burned in subtitles: $mp4"
    else
      echo "Error processing file: $file" >&2
      continue
    fi

    rm -f "$temp" "$mkv"
    echo "Deleted temporary files: $file"
    echo
  else
    echo "Skipping invalid file: $file" >&2
  fi
done
