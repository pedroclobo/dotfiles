#!/bin/sh

# Git repo directory
repo_dir="$HOME/Projects/dotfiles"

# List of all files to link
files=$(find "$repo_dir" -type f | grep -v -e ".git" -e "md" -e "setup")


# Return the link path
get_link() {
	link=$(echo "$1" | sed "s|${repo_dir}||")
	echo "$HOME""$link"
}

# Check if link already exists
link_exists() {
	[ -e "$1" ]
}

# Return the parent directory
get_parent_dir() {
	echo "${1%/*}"
}

# Check if directory already exists
dir_exists() {
	[ -d "$1" ]
}


# Only link new files and create directories if missing
for file in $files
do
	link=$(get_link "$file")
	dir=$(get_parent_dir "$link")
	! dir_exists "$dir" && mkdir -p "$dir"
	! link_exists "$link" && ln -s -f "$file" "$link"
done
