#!/bin/bash

files=( "$HOME/Downloads/convert/"*.mkv )
PS3='Select file, press 0 when done: '

while true; do
  select file in "${files[@]}"; do
    if [[ $REPLY == "0" ]]; then
      echo 'Exiting' >&2
      exit 0

    elif [[ -z $file ]]; then
      echo 'Invalid choice, try again' >&2

    else
      dir=$(dirname "$file")	# Extract dir path
      base=$(basename "$file")	# Extract file name with extension
      name="${base%.*}"	# Remove extension
      new_file="subbed_${name}"
      mkv_file="$new_file.mkv"
      mp4_file="$new_file.mp4"
      renamed="waste.mkv"

      mv "$file" "$renamed"
      
      read -p 'Select bitrate (0-51, 23 for Standard)' crf

      ffmpeg -i "$renamed" -vf subtitles="$renamed" "$mkv_file" > /dev/null 2>&1
      ffmpeg -i "$mkv_file" -c:v libx264 -crf $crf -preset slow -c:a aac -b:a 300k "$mp4_file" > /dev/null 2>&1
      
      echo 'Succesfully burned in subtitles'
      
      rm "$renamed"
      rm "$mkv_file"
      echo 'Deleted temporary .mkv files'
      break
    fi
  done
done
