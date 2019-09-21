#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

ln -sf $SCRIPTPATH/.bashrc $HOME/.bashrc

ln -sf $SCRIPTPATH/.tmux.conf $HOME/.tmux.conf

if [ -e "$HOME/.themes" ]; then
    rm -r $HOME/.themes
fi
ln -sf $SCRIPTPATH/.themes $HOME/.themes

if [ -e "$HOME/.icons" ]; then
    rm -r $HOME/.icons
fi
ln -sf $SCRIPTPATH/.icons $HOME/.icons

mkdir -p $HOME/.vim
ln -sf $SCRIPTPATH/.vim/vimrc $HOME/.vim/vimrc

mkdir -p $HOME/.config
if [ -e "$HOME/.config/dconf" ]; then
    rm -r $HOME/.config/dconf
fi
ln -sf $SCRIPTPATH/.config/dconf $HOME/.config/dconf
