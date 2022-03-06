#!/bin/sh

# Connect to external monitor if available
monitors &

# Set keyboard layout and remap caps to escape
setxkbmap pt -option "caps:escape" &

nitrogen --restore &        # Set wallpaper
dwmblocks &                 # DWM bar
xset s off -dpms &          # Disable screen timeout
unclutter &                 # Hide mouse cursor when inactive
redshift &                  # Night light
picom &                     # Compositor

# dwm reload
while true; do
	dwm
done

# Start desktop
exec dwm
