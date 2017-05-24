# .bashrc
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


# Add ~/bin to the $PATH, if it exists and if
# there is not a ~/.path file
if [ ! -f "$HOME/.path" ] && [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend $PATH.
# * ~/.extra can be used for other settings you don’t want to commit.
for f in "$HOME/"{.path,.aliases,.extra,.usnews}; do
	[ -r "$f" ] && [ -f "$f" ] && source "$f";
done;
unset f;

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
    mkdir $HOME/tmp
    mkdir $HOME/tmp/vim
elif [ ! -d "$HOME/tmp/vim/" ] ; then
    mkdir $HOME/tmp/vim
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

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
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


export VIRTUALENVWRAPPER="/usr/local/bin/virtualenvwrapper.sh"
export WORKON_HOME="${HOME}/.envs"
mkdir -p $WORKON_HOME
source "$VIRTUALENVWRAPPER"

# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
if [ -f "$HOME/.git-completion.bash" ] ; then
    source "$HOME/.git-completion.bash"
fi

# Run bash-git-prompt (installed via Homebrew)
if [ -f /usr/local/share/gitprompt.sh ]; then
    # Set config variables first

    # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status

    # GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
    # GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files

    # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

    # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
    # GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

    # as last entry source the gitprompt script
    # GIT_PROMPT_THEME=Custom # use custom .git-prompt-colors.sh
    # GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme
    GIT_PROMPT_ONLY_IN_REPO=0
    GIT_PROMPT_THEME=Default
    . /usr/local/share/gitprompt.sh
fi

# Exercism
if [ -f ~/.config/exercism/exercism_completion.bash ]; then
    . ~/.config/exercism/exercism_completion.bash
fi
