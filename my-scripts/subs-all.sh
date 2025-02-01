#!/bin/bash

files=( "$HOME/Downloads/convert/ygo/"*.mkv )
if [[ ${#files[@]} -eq 0 ]]; then
	    echo 'No .mkv files found, in directory' >&2
      exit 1
fi

for file in "${files[@]}"; do
  if [[ -f "$file" ]]; then
    dir=$(dirname "$file")	# Extract dir path
    base=$(basename "$file")	# Extract file name with extension
    name="${base%.*}"	# Remove extension
    new_file="subbed_${name}"
    mkv_file="$new_file.mkv"
    mp4_file="$new_file.mp4"
    renamed="waste.mkv"

    mv "$file" "$renamed"

    ffmpeg -i "$renamed" -vf subtitles="$renamed" "$mkv_file" > /dev/null 2>&1
    ffmpeg -i "$mkv_file" -c:v libx264 -crf 23 -preset slow -c:a aac -b:a 300k "$mp4_file" > /dev/null 2>&1
    
    if [[ -f "$mp4_file" ]]; then
      echo "Succesfully burned in subtitles: $mp4_file"
    else
      echo "Error processing file: $file" >&2
      continue
    fi

    rm -f "$renamed" "$mkv_file"
    echo "Deleted temporary files: $file"
    echo
  else
    echo "Skipping invalid file: $file" >&2
  fi
done
