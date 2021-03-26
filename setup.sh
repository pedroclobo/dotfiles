#!/bin/sh

### Git repo directory
dir="/home/$USER/Projects/dotfiles"

### Files
([ -d "/home/$USER/.local/bin/scripts" ] && [ -d "/home/$USER/.local/bin/statusbar" ]) ||
mkdir -p /home/$USER/.local/bin/{scripts,statusbar}

files=$(find $dir -type f | grep -v -e ".git" -e "md" -e "setup")

for file in $files
do
    link=$(echo $file | sed "s/\/Projects\/dotfiles//")
    ln -s -f $file $link
done
