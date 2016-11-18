# .bash_profile
#
# This file is executed for login shells, while .bashrc is executed for
# interactive non-login shells. If .bash_profile exists, .profile will
# not be automatically executed.
#
# If I want something to happen for any interactive shells, I will put
# it in .bashrc.
#
# If I want something to happen for all login shells, I will put it in
# .profile, unless it is bash-specific; in that case, I will put it 
# here, in .bash_profile.
# 
# See also: 
#
#   http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html


# execute ~/.profile, containing my generic
# login shell configuration
#if [ -f "$HOME/.profile" ] ; then
#    source "$HOME/.profile"
#fi

# execute ~/.bashrc, containing my interactive,
# non-login shell configuration
if [ -f "$HOME/.bashrc" ] ; then
    source "$HOME/.bashrc"
fi
