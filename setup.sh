#!/bin/sh

# Git repo directory
dir="$HOME/Projects/dotfiles"

# Return the link path
get_link() {
	link=$(echo "$1" | sed "s/\/Projects\/dotfiles//")
	echo "$link"
}

# Check if link already exists
link_exists() {
	[ -e "$link" ]
}


# Create missing directories, if missing
[ -d "$HOME/.local/bin/scripts" ] && mkdir -p "$HOME"/.local/bin/scripts
[ -d "$HOME/.local/bin/statusbar" ] && mkdir -p "$HOME"/.local/bin/statusbar
[ -d "$HOME/.config/zsh" ] && mkdir -p "$HOME"/.config/zsh
mkdir -p "$HOME"/.config/wget && touch "$HOME"/.config/wget/wgetrc

# List of all files to link
files=$(find "$dir" -type f | grep -v -e ".git" -e "md" -e "setup")

# Link every file
for file in $files
do
	link=$(get_link "$file")
	! link_exists "$link" && ln -s -f "$file" "$link"
done
