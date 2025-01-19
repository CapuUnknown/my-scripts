#!/bin/bash

files=( "/dev/nvme"*"n"*"p"* "/dev/sd"*[0-9])
PS3='Select device to format, or 0 to exit: '
select dev in "${files[@]}"; do
	if [[ $REPLY == "0" ]]; then
		echo 'Exiting' >&2
		exit
	elif [[ -z $dev ]]; then
		echo 'Invalid choice, try again' >&2
	else
    dir=$(dirname "$dev")
    base=$(basename "$dev")
    name="${base%.*}"
    ext="${base##*.}"
    new_dev=
		break
	fi
done
echo
files=( "/usr/bin/mkfs."* )
PS3='Select filesystem, or 0 to exit: '
select fs in "${files[@]}"; do
    if [[ $REPLY == "0" ]]; then
        echo 'Exiting' >&2
        exit
    elif [[ -z $fs ]]; then
        echo 'Invalid choice, try again' >&2
    else
        break
    fi
done
$fs $dev
