# .bashrc
#
# shellcheck disable=SC1090
#
# This file is executed for interactive, non-login shells, while
# .bash_profile is executed for login shells.
#
# If I want something to happen for any interactive shells, I will put
# it here, in .bashrc.
#
# If I want something to happen for all login shells, I will put it in
# .profile, unless it is bash-specific.
#
# See also:
#
#   http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html


# *IMPORTANT* Keep this command at the top of .bashrc
# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Add ~/.local/bin to PATH
export PATH=$HOME/.local/bin:$PATH

export SHELL_CONFIG_VERBOSE=true

# Shell configuration for specific software or environements is factored out
# into separate config files. Which ones get executed can then be customized
# here according to the environment we're running in:
for f in "$HOME/.shell/"{aliases,git,pyenv,virtualenvwrapper}; do
	[ -r "$f" ] && [ -f "$f" ] && source "$f";
done;
unset f;

# Set the terminal colors appropriately, see:
# https://superuser.com/questions/431922/tmux-and-screen-256-term-not
if [[ $SSH_TTY ]]
then
    TERM=xterm-color
else
    TERM=xterm-256color
fi
export TERM

# Enable gnome terminal to understand UTF-8
export LANG=en_US.UTF-8

# Tell bash to use vi-style editing on the command-line
set -o vi

# Set vim as the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Ensure that a personal tmp/vim/ dir exists; my Vim configuration will
# use this dir for swap and backup files, but only if it exists.
if [ ! -d "$HOME/tmp" ] ; then
    mkdir "$HOME/tmp"
    mkdir "$HOME/tmp/vim"
elif [ ! -d "$HOME/tmp/vim/" ] ; then
    mkdir "$HOME/tmp/vim"
fi

# Set TMOUT to null; this avoids 'inactive' screen sessions
# being killed overnight. 2015-03-19 Stew via Andrew Martin
export TMOUT=

## If not running interactively, don't do anything
#case $- in
#    *i*) ;;
#      *) return;;
#esac;


# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
# [Note: didn't like this like I thought I would, so I disabled it]
#shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3000
HISTFILESIZE=10000

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# Automatically start ssh-agent
# http://wiki.usnews.com/its/SSH_private_key_generation_and_usage#SSH_Agent.2FForwarding_HOWTO
SSH_AGENT_CACHE=/tmp/ssh_agent_eval_`whoami`
if [ -s "${SSH_AGENT_CACHE}" ]
then
    echo "Reusing existing ssh-agent"
    eval `cat "${SSH_AGENT_CACHE}"`
    # Check that agent still exists
    kill -0 "${SSH_AGENT_PID}" 2>/dev/null
    if [ $? -eq 1 ]
    then
        echo "ssh-agent pid ${SSH_AGENT_PID} no longer running"
        # Looks like the SSH-Agent has died, it'll be restarted below
        rm -f "${SSH_AGENT_CACHE}"
    fi
fi

if [ ! -f "${SSH_AGENT_CACHE}" ]
then
    echo "Starting new ssh-agent"
    touch "${SSH_AGENT_CACHE}"
    chmod 600 "${SSH_AGENT_CACHE}"
    ssh-agent >> "${SSH_AGENT_CACHE}"
    chmod 400 "${SSH_AGENT_CACHE}"
    eval `cat "${SSH_AGENT_CACHE}"`
    ssh-add
fi

for key in "${HOME}/.ssh/id_rsa."{usn,github.primordialstew}; do
    [ -r "$key" ] && [ -f "$key" ] && ssh-add "$key";
done;
unset key;


# Exercism
if [ -f ~/.config/exercism/exercism_completion.bash ]; then
    . ~/.config/exercism/exercism_completion.bash
fi

# These PATH and MANPATH changes are for use with ``brew install coreutils``
# on Mac OS X, which installs traditional gnu core utilities:
# ==> Caveats
# All commands have been installed with the prefix 'g'.
#
# If you really need to use these commands with their normal names, you
# can add a "gnubin" directory to your PATH from your bashrc like:
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Additionally, you can access their man pages with normal names if you add
# the "gnuman" directory to your MANPATH from your bashrc as well:
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
