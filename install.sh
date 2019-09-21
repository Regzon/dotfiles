#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

ln -sf $SCRIPTPATH/.bashrc $HOME/.bashrc

ln -sf $SCRIPTPATH/.tmux.conf $HOME/.tmux.conf

ln -sf $SCRIPTPATH/.themes $HOME/.themes

ln -sf $SCRIPTPATH/.icons $HOME/.icons

mkdir -p $HOME/.vim
ln -sf $SCRIPTPATH/.vim/vimrc $HOME/.vim/vimrc

mkdir -p $HOME/.config/dconf
ln -sf $SCRIPTPATH/.config/dconf/user $HOME/.config/dconf/user
