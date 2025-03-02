#!/bin/bash
while true; do
  while [[ "$files" != *".mkv" ]]; do
    files=$(zenity \
      --file-selection \
      --filename="$HOME/Downloads/convert/" \
      --file-filter=*".mkv")

    if [[ "$files" == "" ]]; then
      exit
    fi
    if [[ "$files" != *".mkv" ]]; then
      zenity \
        --error \
        --text="Invalid choice for '$files', try again"
      continue
    fi
  done

  while [[ "$crf" == "" || "$crf" -lt 0 || "$crf" -gt 51 ]]; do
    crf=$(zenity \
      --entry \
      --text="Select bitrate (0-51)")
    if [[ "$crf" == "" ]]; then
      zenity \
        --info \
        --text="Setting bitrate to 23"
      crf="23"
    fi
  done

  dir=$(dirname "$files")
  base=$(basename "$files")
  name="${base%.*}"
  sub="${dir}/subbed_${name}"
  mkv="${sub}.mkv"
  mp4="${sub}.mp4"
  temp="${dir}/temp.mkv"
  mv "$files" "$temp"

  (
    echo "10"
    sleep 1
    echo "# Ripping subtitles..."
    ffmpeg -i "$temp" -vf subtitles="$temp" "$mkv" >/dev/null 2>&1
    echo "50"
    sleep 0.5
    echo "Converting to mp4..."
    ffmpeg -i "$mkv" -c:v libx264 -crf "$crf" -preset slow -c:a aac -b:a 300k "$mp4" >/dev/null 2>&1
    echo "95"
    sleep 0.5
    echo "Removing temporary files..."
    sleep 1
    rm "$temp" "$mkv"
    echo "100"
    sleep 1
  ) |
    zenity \
      --progress \
      --title="ffmpeg in progress..." \
      --text="Creating temporary files..." \
      --percentage=0

  if [ "$?" = -1 ]; then
    zenity \
      --error \
      --test="Burning canceled"
    exit
  fi

  crf=""
  files=""

  if (zenity \
    --question \
    --text="Do you want to continue?"); then
    continue
  else
    exit
  fi
done
