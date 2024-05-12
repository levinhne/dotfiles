#!/usr/bin/env bash

xrdb merge ~/.Xresources 

xrandr -r 75

# Kill already running process
_ps=(dunst ksuperkey)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

dunst &


# Fix cursor
xsetroot -cursor_name left_ptr

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

picom --daemon &
feh --bg-fill ~/.wallpapers/

clipcatd
