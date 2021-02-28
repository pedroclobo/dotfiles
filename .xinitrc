#!/bin/sh

# Connect to external monitor if available
monitors &&

setxkbmap pt &              # Set keyboard layout
xrdb .Xresources            # Update Xresources
nitrogen --restore &        # Set wallpaper
dwmblocks &                 # DWM bar
xset s off -dpms            # Disable screen timeout
redshift -l 38.610161:-9.096800 &

while true; do
	dwm >/dev/null 2>&1
done

exec dwm
