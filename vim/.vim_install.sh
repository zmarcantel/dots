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
