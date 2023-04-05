# Enable gnome terminal to understand UTF-8
export LANG=en_US.UTF-8

# Tell bash to use vi-style editing on the command-line
set -o vi

# Set vim as the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Up/down arrow autocomplete from history file
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Ensure that a personal tmp/vim/ dir exists; my Vim configuration will
# use this dir for swap and backup files, but only if it exists.
if [ ! -d "$HOME/tmp" ] ; then
    mkdir "$HOME/tmp"
    mkdir "$HOME/tmp/vim"
elif [ ! -d "$HOME/tmp/vim/" ] ; then
    mkdir "$HOME/tmp/vim"
fi

# Set TMOUT to null; this avoids 'inactive' screen sessions
# being killed overnight
export TMOUT=

# Append to the history file immediately, don't wait until session ends
setopt INC_APPEND_HISTORY
# Append to the history file only once session ends
#setopt APPEND_HISTORY

# Don't put duplicate lines or lines starting with space in the history
#HISTCONTROL=ignoreboth

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3000
HISTFILESIZE=10000
