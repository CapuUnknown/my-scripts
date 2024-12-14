#!/bin/bash

files=( "$HOME/Downloads/convert/"*.mkv )
PS3='Select file, or 0 to exit: '

while true; do
    select file in "${files[@]}"; do
	if [[ $REPLY == "0" ]]; then
	    echo
	    echo 'Bye!' >&2
       	    exit 0
       	elif [[ -z $file ]]; then
            echo
	    echo 'Invalid choice, try again' >&2
       	else
	    dir=$(dirname "$file")	# Extract dir path
	    base=$(basename "$file")	# Extract file name with extension
	    name="${base%.*}"	# Remove extension
	    ext="${base##*.}"	# Extract extension
	    #new_file="${dir}/subbed_${name}.${ext}"
	    new_file="${dir}/${name}.mp4"
	    echo
	    echo "$file"
	    echo "$new_file"
#	    ffmpeg -i $new_file -vf subtitles=$new_file "$new_file" > /dev/null 2>&1
	    ffmpeg -i "$file" -codec copy "$new_file" > /dev/null 2>&1
	    echo
	    #echo 'Burning in subtitles, this may take a while'
	    echo 'Converting to .mp4, this may take a while'
	    echo
            break
       	fi
    done
done


#while :; do
#    read -p "Enter file name (or type 'q' to quit): " file
#
#    if [[ "$file" == "q" ]]; then
#        printf "Exiting the script.\n"
#        break
#    fi
#
#    if [[ ! -f "$file.mkv" ]]; then
#        printf "File '$file.mkv' not found. Please try again.\n" >&2
#        continue
#    fi
#
#    ffmpeg -i $file -vf subtitles=$file "$file_sub" > /dev/null 2>&1
