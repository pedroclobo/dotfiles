#!/bin/sh

### Git repo directory
dir="$HOME/Projects/dotfiles"

### Create missing directories, if missing
([ -d "$HOME/.local/bin/scripts" ] && [ -d "$HOME/.local/bin/statusbar" ]) ||
mkdir -p $HOME/.local/bin/{scripts,statusbar}

# List of all files to link
files=$(find $dir -type f | grep -v -e ".git" -e "md" -e "setup")

# Link every file
for file in $files
do
    link=$(echo $file | sed "s/\/Projects\/dotfiles//")
    ln -s -f $file $link
done

# Create wgetrc as .zprofile points to it
mkdir -p $HOME/.config/wget
touch $HOME/.config/wget/wgetrc
