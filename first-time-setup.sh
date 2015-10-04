#!/bin/bash

sudo apt-get install vim curl tmux

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

ln -s ~/dotfiles/.vimrc ~
ln -s ~/dotfiles/.tmux.conf ~

vim +PluginInstall +qall
