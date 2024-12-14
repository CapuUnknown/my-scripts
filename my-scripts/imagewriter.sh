#!/bin/bash
files=( "$HOME/Documents/images/"* )
PS3='Select image, or 0 to exit: '
select image in "${files[@]}"; do
	if [[ $REPLY == "0" ]]; then
		echo 'Exiting' >&2
		exit
	elif [[ -z $image ]]; then
		echo 'Invalid choice, try again' >&2
	else
		break
	fi
done
echo
files=( "/dev/disk/by-id/"usb-* )
PS3='Select device, or 0 to exit: '
select device in "${files[@]}"; do
    if [[ $REPLY == "0" ]]; then
        echo 'Bye!' >&2
        exit
    elif [[ -z $device ]]; then
        echo 'Invalid choice, try again' >&2
    else
        break
    fi
done
echo
cat $image > $device
