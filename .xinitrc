#!/bin/sh

# Connect to external monitor if available
monitors &&

setxkbmap pt &              # Set keyboard layout
xrdb .Xresources            # Update Xresources
nitrogen --restore &        # Set wallpaper
dwmblocks &                 # DWM bar
xset s off -dpms            # Disable screen timeout
redshift &                  # Night light
#picom &

# Fast dwm reloading
while true; do
	dwm
done

# Start desktop
exec dwm
