#!/usr/bin/env bash

set -e

# create symlink for neovim init.vim

VUNDLE_SRC=https://github.com/VundleVim/Vundle.vim.git
VUNDLE_DEST=$HOME/.vim/bundle/Vundle.vim

if [ "$#" -eq 0 ]; then
    echo "expected arguments to pass to YouCompleteMe installation"
    exit 1
fi

using_neovim() {
    type "nvim" > /dev/null 2>&1
}


if using_neovim; then
    export VIM=nvim
    export VIM_CONFIG_DIR=$HOME/.config/nvim
    export VIM_CONFIG=$VIM_CONFIG_DIR/init.vim
else
    export VIM=vim
    export VIM_CONFIG_DIR=$HOME
    export VIM_CONFIG=$VIM_CONFIG_DIR/.vimrc
    mv $VIM_CONFIG $VIM_CONFIG.orig-reloc
fi

#  link vim to includes-only now
if [ ! -L "$VIM_CONFIG" ]; then
    mkdir -p $VIM_CONFIG_DIR
    ln -s $HOME/.vim_includes $VIM_CONFIG
fi


# install Vundle base
if [ ! -e "$VUNDLE_DEST" ]; then
    git clone $VUNDLE_SRC $VUNDLE_DEST
fi

# install all listed plugins (NOTE: using nvim)
$VIM +PluginInstall +qall

# spawn with new working dir and call YCM install
( cd ~/.vim/bundle/YouCompleteMe ; ./install.py $@ )

# finally, transition to the full vim config
rm $VIM_CONFIG
if using_neovim; then
    ln -s $HOME/.vimrc $VIM_CONFIG
    pip2 install --user --upgrade neovim
    pip3 install --user --upgrade neovim
else
    mv $VIM_CONFIG.orig-reloc $VIM_CONFIG
fi
