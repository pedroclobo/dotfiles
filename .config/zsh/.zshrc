#!/bin/zsh

# Enable Colors and Prompt
autoload -U promptinit
promptinit
prompt pure

# Autocd
setopt autocd

# Auto-correct commands
setopt correctall

# Prevent file overwriting
setopt noclobber

# Globbing
setopt extendedglob

# Alias and shortcuts
source $HOME/.config/alias

# History
HISTFILE="$HOME/.cache/zhistory"
HISTSIZE="1000"
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Basic Auto/Tab complete:
autoload -U compinit
zstyle ":completion:*:descriptions" format "%U%B%d%b%u"
compinit
_comp_options+=(globdots)

# vi Mode
bindkey -v

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}

zle -N zle-keymap-select

zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# zsh autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
