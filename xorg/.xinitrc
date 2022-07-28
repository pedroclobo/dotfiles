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

# Load Xresources
xrdb ~/.Xresources

# dwm reload
while true; do
	dwm
done
