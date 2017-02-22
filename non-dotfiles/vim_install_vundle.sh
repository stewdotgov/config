#!/usr/bin/env bash

# Install the Vundle plugin for vim, if it is not already installed.
GREEN='\033[0;32m'
NC='\033[0m' # No Color
MSG="${GREEN}Alrighty! Now enter vim and run :PluginInstall${NC}"

VUNDLE=~/.vim/bundle/Vundle.vim
if [ ! -f $VUNDLE ];
then
    git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE
    echo -e $MSG
fi
