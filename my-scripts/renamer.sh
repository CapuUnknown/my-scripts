#!/bin/bash

# Prompt the user for the season number
read -p "Enter the season number: " season_number

# Validate season number is provided and is a valid number
if [[ ! "$season_number" =~ ^[0-9]{2}$ ]]; then
    printf "Invalid season number. Please provide a two-digit season number.\n" >&2
    exit 1
fi

# Process each .mp4 file in the current directory
for f in *.mp4; do
    # Match filenames with "episode-<number>", "EP.<number>", or "-<number>" followed by anything
    if [[ "$f" =~ episode-([0-9]+) ]]; then
        episode_num=$(printf "%03d" "${BASH_REMATCH[1]}")
    elif [[ "$f" =~ EP\.([0-9]+) ]]; then
        episode_num=$(printf "%03d" "${BASH_REMATCH[1]}")
    elif [[ "$f" =~ -([0-9]+) ]]; then
        episode_num=$(printf "%03d" "${BASH_REMATCH[1]}")
    else
        printf "Skipping: No recognizable episode number in '$f'.\n" >&2
        continue
    fi

    # Generate the new filename using the season and padded episode number
    new_name="S${season_number}E${episode_num}.mp4"
    mv -v "$f" "$new_name"
done
