#!/usr/bin/env bash

VUNDLE_SRC=https://github.com/VundleVim/Vundle.vim.git

if [ "$#" -eq 0 ]; then
    echo "expected arguments to pass to YouCompleteMe installation"
    exit 1
fi

# install Vundle base
git clone $VUNDLE_SRC $HOME/.vim/bundle/Vundle.vim

# install all listed plugins
vim +PluginInstall +qall

# spawn with new working dir and call YCM install
( cd ~/.vim/bundle/YouCompleteMe ; ./install.py $@ )
