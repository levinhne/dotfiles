#!/usr/bin/env bash

xrandr -r 75
if [[ `pidof dunst` ]]; then
	pkill dunst
fi
dunst -conf ~/.config/dunst/dunst.conf &
picom --daemon &
xsetroot -cursor_name left_ptr
feh --bg-fill ~/Pictures/Wallpapers/

