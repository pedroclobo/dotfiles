#!/bin/sh

# Connect to external monitor if available
monitors &

# Set keyboard layout and remap caps to control
setxkbmap pt -option "caps:ctrl_modifier" &
xcape -e "Caps_Lock=Escape" &

nitrogen --restore &        # Set wallpaper
dwmblocks &                 # DWM bar
xset s off -dpms &          # Disable screen timeout
unclutter &                 # Hide mouse cursor when inactive
redshift &                  # Night light
picom &                     # Compositor
dunst &                     # Notification daemon

# Automatically lock after 5 minutes of inactivity
xautolock -time 5 -locker slock -detectsleep &

# Load Xresources
xrdb ~/.Xresources

# dwm reload
while true; do
	dwm
done
