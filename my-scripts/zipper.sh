#!/bin/bash

read -p "Zip or Unzip: " choice
#switch case

main() {
  ADD=""
  files=(*)
  PS3='Select file, press 0 when done or q to cancel: '
  while true; do
    select file in "${files[@]}"; do
      if [[ $REPLY == "0" ]]; then
        read -p "Select archive name: " zip
        7z a $zip $ADD > /dev/null 2>&1
        echo "Successfully created archive: $zip.7z"
        exit 0

      elif [[ $REPLY == "q" ]]; then
        exit 0

      elif [[ -z $file ]]; then
        echo 'Invalid choice, try again' >&2

      else
        add_to_file "$file"
        echo $ADD
      fi
    done
  done
}

add_to_file() {
  local new_file="$1"
  ADD+="${ADD:+ }$new_file"
}

main
