#!/bin/bash

# git clone the vundle repository
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# run vim to install the Vundles
vim +PluginInstall +qall
