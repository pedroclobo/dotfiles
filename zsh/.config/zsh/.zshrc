#!/bin/zsh

##############
### Prompt ###
##############
autoload -U colors && colors

# Load vcs and enable git
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() { vcs_info }
setopt prompt_subst

# Check for untracked files in the directory
# and mark them with !
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!'
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[magenta]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[magenta]%})"

PS1="%B%{$fg[blue]%}%n@%M %~%{$fg[yellow]%}\$vcs_info_msg_0_%{$reset_color%} %(?.$.%{$fg[red]%}$)%b "


###############
### Options ###
###############
setopt autocd extendedglob menucomplete


###################
### Completions ###
###################
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)


###############
### Vi Mode ###
###############
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


###############
### History ###
###############
HISTFILE="$HOME/.cache/zhistory"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space


###############
### Keymaps ###
###############
# Delete word on Ctrl-Backspace
bindkey '^H' backward-kill-word
bindkey '5~' kill-word

# Move by work on Ctrl-Left/Right
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Pattern search history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


#############
### Alias ###
#############
source $HOME/.config/alias


###############
### Plugins ###
###############
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        source "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        source "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
