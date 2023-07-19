# Use vi keybindings for editing command line
set -o vi

# Enable up/down arrows to search history using partial string matching
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
