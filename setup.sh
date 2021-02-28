#!/usr/bin/sh
dir=/home/$USER/Projects/dotfiles

# Xorg files
ln -s -f $dir/.xinitrc /home/$USER/.xinitrc
ln -s -f $dir/.Xresources /home/$USER/.Xresources

# zsh
ln -s -f $dir/.zprofile /home/$USER/.zprofile
ln -s -f $dir/.config/zsh/.zshrc /home/$USER/.config/zsh/.zshrc
ln -s -f $dir/.config/alias /home/$USER/.config/alias

# Zoom
ln -s -f $dir/.config/zoomus.conf /home/$USER/.config/zoomus.conf

# Scripts
ln -s -f $dir/.local/bin/scripts/audio /home/$USER/.local/bin/scripts/audio
ln -s -f $dir/.local/bin/scripts/compiler /home/$USER/.local/bin/scripts/compiler
ln -s -f $dir/.local/bin/scripts/configs /home/$USER/.local/bin/scripts/configs
ln -s -f $dir/.local/bin/scripts/displays /home/$USER/.local/bin/scripts/displays
ln -s -f $dir/.local/bin/scripts/monitors /home/$USER/.local/bin/scripts/monitors
ln -s -f $dir/.local/bin/scripts/open /home/$USER/.local/bin/scripts/open
ln -s -f $dir/.local/bin/scripts/power /home/$USER/.local/bin/scripts/power
ln -s -f $dir/.local/bin/scripts/settings /home/$USER/.local/bin/scripts/settings

# Status bar
ln -s -f $dir/.local/bin/statusbar/battery /home/$USER/.local/bin/statusbar/battery
ln -s -f $dir/.local/bin/statusbar/brightness /home/$USER/.local/bin/statusbar/brightness
ln -s -f $dir/.local/bin/statusbar/clock /home/$USER/.local/bin/statusbar/clock
ln -s -f $dir/.local/bin/statusbar/volume /home/$USER/.local/bin/statusbar/volume
