#!/usr/bin/env bash 
QTILE="$HOME/.config/qtile"
COLORSCHEME=DoomOne

### CHECKS IF VIRTUAL MACHINE ###
# If so, this sets an appropriate screen resolution.
# This is needed as part of DTOS.
if [[ $(systemd-detect-virt) = "none" ]]; then
    echo "Not running in a Virtual Machine";
elif xrandr | grep "1366x768"; then
    xrandr -s 1366x768 || echo "Cannot set 1366x768 resolution.";
elif xrandr | grep "1920x1080"; then
    xrandr -s 1920x1080 || echo "Cannot set 1920x1080 resolution.";
else echo "Could not set a resolution."
fi

### FIX EMACS ELPACA SYMLINKS ###
# This runs the fix-elpaca-symlinks scripts which 
# fixes all of the symlinks in .config/emacs/elpaca/build.
# This is needed as part of DTOS and is only run ONCE!

### AUTOSTART PROGRAMS ###
#lxsession &
picom --daemon &
xsettingsd --config="$QTILE"/xsettingsd &
xsetroot -cursor_name left_ptr
#/usr/bin/emacs --daemon &
#copyq &
#nm-applet &
#pamac-tray-icon-plasma &
#"$HOME"/.screenlayout/layout.sh &

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
# xargs xwallpaper --stretch < ~/.cache/wall &
# 2. Uncomment to set a random wallpaper on login
# find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# 3. Uncomment to set wallpaper with nitrogen
# nitrogen --restore &

### SETS CONKY STYLE BASED ON SCREEN RESOLUTION
# Checks screen resolution.  If 1080p or higher, then we use '01' conky.
# If less than 1080p (laptops?), then we use the smaller '02' conky.
# You can also set these to values '03' and '04' if you want a fancier
# conky that displays lua rings and sensor information.
resolutionHeight=$(xrandr | grep "primary" | awk '{print $4}' | awk -F "+" '{print $1}' | awk -F 'x' '{print $2}')
