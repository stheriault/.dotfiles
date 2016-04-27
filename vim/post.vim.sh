#!/bin/bash

# vundle install dir
vundleInstallpath="$HOME/.vim/bundle/Vundle.vim"

# git clone the vundle repository
if [[ ! -d $vundleInstallpath ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $vundleInstallpath
fi

# run vim to install the Vundles
vim +PluginInstall +qall
