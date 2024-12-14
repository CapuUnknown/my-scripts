#!/bin/bash

files=( "$HOME/Downloads/convert/"*.mkv )
PS3='Select file, press 0 when done: '

while true; do
    select file in "${files[@]}"; do
	if [[ $REPLY == "0" ]]; then
	    echo
	    echo 'Exiting' >&2
       	    exit 0
       	elif [[ -z $file ]]; then
            echo
	    echo 'Invalid choice, try again' >&2
       	else
	    dir=$(dirname "$file")	# Extract dir path
	    base=$(basename "$file")	# Extract file name with extension
	    name="${base%.*}"	# Remove extension
	    ext="${base##*.}"	# Extract extension
	    new_file="${dir}/subbed_${name}.${ext}"
	    ffmpeg -i $new_file -vf subtitles=$new_file "$new_file" > /dev/null 2>&1
	    echo
	    echo 'Burning in subtitles, this may take a while'
	    echo
            break
       	fi
    done
done
