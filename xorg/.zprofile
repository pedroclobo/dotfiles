#!/bin/zsh

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(find "$HOME/.local/bin" | paste -sd ':')"

# Default programs:
export FILE="pcmanfm"
export BROWSER="firefox"
export TERMINAL="alacritty"
export EDITOR="nvim"
export PDF_READER="zathura"

# fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Start graphical server on tty1 if not already running.
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
