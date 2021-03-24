#!/bin/sh

printf "What's your username?\n--> "
read USERNAME

dir=/home/$USERNAME/Projects/dotfiles

# Xorg files
ln -s -f $dir/.xinitrc /home/$USERNAME/.xinitrc
ln -s -f $dir/.Xresources /home/$USERNAME/.Xresources

# zsh
ln -s -f $dir/.zprofile /home/$USERNAME/.zprofile
ln -s -f $dir/.config/zsh/.zshrc /home/$USERNAME/.config/zsh/.zshrc
ln -s -f $dir/.config/alias /home/$USERNAME/.config/alias

# Zoom
ln -s -f $dir/.config/zoomus.conf /home/$USERNAME/.config/zoomus.conf

# Scripts
ln -s -f $dir/.local/bin/scripts/audio /home/$USERNAME/.local/bin/scripts/audio
ln -s -f $dir/.local/bin/scripts/compiler /home/$USERNAME/.local/bin/scripts/compiler
ln -s -f $dir/.local/bin/scripts/displays /home/$USERNAME/.local/bin/scripts/displays
ln -s -f $dir/.local/bin/scripts/monitors /home/$USERNAME/.local/bin/scripts/monitors
ln -s -f $dir/.local/bin/scripts/open /home/$USERNAME/.local/bin/scripts/open
ln -s -f $dir/.local/bin/scripts/power /home/$USERNAME/.local/bin/scripts/power
ln -s -f $dir/.local/bin/scripts/screen-clip /home/$USERNAME/.local/bin/scripts/screen-clip
ln -s -f $dir/.local/bin/scripts/screen-save /home/$USERNAME/.local/bin/scripts/screen-save
ln -s -f $dir/.local/bin/scripts/settings /home/$USERNAME/.local/bin/scripts/settings

# Status bar
ln -s -f $dir/.local/bin/statusbar/battery /home/$USERNAME/.local/bin/statusbar/battery
ln -s -f $dir/.local/bin/statusbar/brightness /home/$USERNAME/.local/bin/statusbar/brightness
ln -s -f $dir/.local/bin/statusbar/clock /home/$USERNAME/.local/bin/statusbar/clock
ln -s -f $dir/.local/bin/statusbar/volume /home/$USERNAME/.local/bin/statusbar/volume
