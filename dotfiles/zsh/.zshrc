# Use vi keybindings for editing command line
set -o vi

# Enable up/down arrows to search history using partial string matching
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward


# Configure git prompt
#
# https://github.com/zsh-git-prompt/zsh-git-prompt
#
# NOTE: to debug, execute:
#
#   `$__GIT_PROMPT_DIR/zshrc.sh --debug`
#
ZSH_GIT_PROMPT_SCRIPT="$(readlink -f ~/.zsh-git-prompt/zshrc.sh)"
if [ -e $ZSH_GIT_PROMPT_SCRIPT ]; then
  source $ZSH_GIT_PROMPT_SCRIPT
  # Git prompt for use with zsh-git-prompt
  PROMPT='%B%m%~%b$(git_super_status) %# '
else
  echo "zsh-git-prompt not found"
fi


# Run MacOS specific commands
if [ "$os_name" = "Darwin" ]; then
  # Running on MacOS
  # Disable two-finger swipe gesture for going back/forward in Chrome history
  defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
else
  # Not running on MacOS
fi


# Configure Pyenv
#
# https://github.com/pyenv/pyenv
#
if command -v pyenv 1>/dev/null 2>&1; then
  # Add pyenv to PATH
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  # Initialize pyenv
  eval "$(pyenv init -)"
fi
