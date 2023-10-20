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
  #PROMPT='%B%m%~%b $(git_super_status) %# '
  # Omit double-space if not in a git repo:
  PROMPT='%B%m%~%b $(git_super_status 2>/dev/null || echo "") %# '
  #PROMPT='%B%m%~%b $(if [ -n "$(git_super_status 2>/dev/null)" ]; then echo " "; fi)$(git_super_status 2>/dev/null)%# '

else
  echo "zsh-git-prompt not found"
fi


# Run MacOS specific commands
if [ "$os_name" = "Darwin" ]; then
  # Running on MacOS
  # Disable two-finger swipe gesture for going back/forward in Chrome history
  defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE

  # Postgres configuration (brew installed):
  # If you need to have postgresql@15 first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"' >> ~/.zshrc
  # For compilers to find postgresql@15 you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/postgresql@15/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/postgresql@15/include"
  # For pkg-config to find postgresql@15 you may need to set:
  export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@15/lib/pkgconfig"
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


# NOTE:
#
# Homebrew Postgres setup:
#
# This formula has created a default database cluster with:
#   initdb --locale=C -E UTF-8 /opt/homebrew/var/postgresql@15
# For more details, read:
#   https://www.postgresql.org/docs/15/app-initdb.html
#
# postgresql@15 is keg-only, which means it was not symlinked into /opt/homebrew,
# because this is an alternate version of another formula.
#
# If you need to have postgresql@15 first in your PATH, run:
#   echo 'export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"' >> ~/.zshrc
#
# For compilers to find postgresql@15 you may need to set:
#   export LDFLAGS="-L/opt/homebrew/opt/postgresql@15/lib"
#   export CPPFLAGS="-I/opt/homebrew/opt/postgresql@15/include"
#
# For pkg-config to find postgresql@15 you may need to set:
#   export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@15/lib/pkgconfig"
#
# To start postgresql@15 now and restart at login:
#   brew services start postgresql@15
# Or, if you don't want/need a background service you can just run:
#   LC_ALL="C" /opt/homebrew/opt/postgresql@15/bin/postgres -D /opt/homebrew/var/postgresql@15
