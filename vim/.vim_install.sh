#!/usr/bin/env bash

set -e

VUNDLE_SRC="https://github.com/VundleVim/Vundle.vim.git"
VUNDLE_DEST="$HOME/.vim/bundle/Vundle.vim"

# install Vundle base
if [ ! -e "$VUNDLE_DEST" ]; then
    git clone $VUNDLE_SRC $VUNDLE_DEST
fi

# install all listed plugins
vim -u ~/.vim_includes +PluginInstall +qall

if [ $# -eq 1 ] && [ "$1" = "--skip-ycm" ]; then
    exit 0
fi

# spawn with new working dir and call YCM install
( cd ~/.vim/bundle/YouCompleteMe ; ./install.py $@ )
