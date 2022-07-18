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

# Automatically lock after 5 minutes of inactivity
xautolock -time 5 -locker slock -detectsleep &

# Load Xresources
[[ -f ~/.Xresources ]] && xrdb ~/.Xresources

# dwm reload
while true; do
	dwm
done
