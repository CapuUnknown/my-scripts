#!/bin/bash
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

# while [[ "$crf" != [0..51] ]]; do
crf=$(zenity \
  --entry \
  --text="Select bitrate (0-51, 23 for standard)")
# done

dir=$(dirname "$files")
base=$(basename "$files")
name="${base%.*}"
sub="${dir}/subbed_${name}"
mkv="${sub}.mkv"
mp4="${sub}.mp4"
temp="temp.mkv"

printf "base: \t%s $base \n"
echo -e "$(printf base:'\t')" "$base"
echo -e "$(printf name:'\t')" "$name"
echo -e "$(printf files:'\t')" "$files"
echo -e "$(printf sub:'\t')" "$sub"
echo -e "$(printf mkv:'\t')" "$mkv"
echo -e "$(printf mp4:'\t')" "$mp4"
echo "$crf"
echo "$temp"

# mv "$mkv" "$temp"

# ffmpeg -i "$files" -vf subtitles="$files" "$mkv_file" >/dev/null 2>&1
# ffmpeg -i "$mkv_file" -c:v libx264 -crf "$crf" -preset slow -c:a aac -b:a 300k "$mp4_file" >/dev/null 2>&1
