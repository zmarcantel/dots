#!/usr/bin/env bash

set -e
set -x

# create symlink for neovim init.vim

VUNDLE_SRC=https://github.com/VundleVim/Vundle.vim.git
VUNDLE_DEST=$HOME/.vim/bundle/Vundle.vim

if [ "$#" -eq 0 ]; then
    echo "expected arguments to pass to YouCompleteMe installation"
    exit 1
fi

#  link nvim to includes-only now
if [ ! -L "$HOME/.config/nvim/init.vim" ]; then
    mkdir -p $HOME/.config/nvim/
    ln -s $HOME/.vim_includes $HOME/.config/nvim/init.vim
fi


# install Vundle base
if [ ! -e "$VUNDLE_DEST" ]; then
    git clone $VUNDLE_SRC $VUNDLE_DEST
fi

# install all listed plugins (NOTE: using nvim)
nvim +PluginInstall +qall

# spawn with new working dir and call YCM install
( cd ~/.vim/bundle/YouCompleteMe ; ./install.py $@ )

# finally, transition to the full vim config
rm $HOME/.config/nvim/init.vim
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim

pip2 install --user --upgrade neovim
pip3 install --user --upgrade neovim
