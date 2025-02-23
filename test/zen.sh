#!/bin/bash
das=$(zenity --entry --text="was das")
echo -e "$(printf Krank:'\t') $das"
echo "$das"
echo "$das"
zenity --info --text="$das"
file=$(zenity --file-selection) # --directory "/home/capu/Downloads/" --save)
echo "$file"
