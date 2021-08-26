#!/bin/sh

# Connect to external monitor if available
monitors &

setxkbmap pt &              # Set keyboard layout
nitrogen --restore &        # Set wallpaper
dwmblocks &                 # DWM bar
xset s off -dpms &          # Disable screen timeout
unclutter &                 # Hide mouse cursor when inactive
redshift &                  # Night light
picom &                     # Compositor

# Automatically lock after 5 minutes of inactivity
xautolock -time 5 -locker slock -detectsleep &

# dwm reload
while true; do
	dwm
done

# Start desktop
exec dwm
