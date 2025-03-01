#!/bin/bash

while [[ "$image" != *".iso" ]]; do
  image=$(zenity \
    --file-selection \
    --filename="$HOME/Documents/images/" \
    --file-filter=*".iso")
  if [[ "$image" == "" ]]; then
    exit
  fi
  if [[ "$image" != *".iso" ]]; then
    zenity \
      --error \
      --text="Invalid choice for '$image', try again"
    continue
  fi
done

while [[ "$device" != "usb-"* ]]; do
  device=$(zenity \
    --file-selection \
    --filename="/dev/disk/by-id/usb-"* \
    --file-filter="usb-"*)
  if [[ "$device" == "" ]]; then
    exit
  fi
  if [[ "$device" != "usb-"* ]]; then
    zenity \
      --error \
      --text="Invalid choice for '$device', try again"
    continue
  fi
done

cat "$image" >"$device"
