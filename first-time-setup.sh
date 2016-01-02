#!/bin/bash

# Import distro info variables
for f in /etc/*-release;
do
    . "$f"
done

PUT_IN_BASHRC=". ~/dotfiles/.bashrc"
if ! grep -q "$PUT_IN_BASHRC" ~/.bashrc;
then
    echo -e "\n$PUT_IN_BASHRC\n" >> ~/.bashrc
fi

# Packages to install
PACKAGES=(
vim
curl
tmux
)

if [ "$ID_LIKE" == "debian" ];
then
    sudo apt-get update
    sudo apt-get install ${PACKAGES[@]}
elif [ "$ID" == "arch" ];
then
    sudo pacman -Su ${PACKAGES[@]}
fi

# I love unity
if [ "$XDG_CURRENT_DESKTOP" == "Unity" ];
then
    sudo apt-get install \
        indicator-multiload \
        compizconfig-settings-manager \
        compiz-plugins-extra

    # TODO: find a way to import unity profile from command line
    echo "Remember to import your unity profile!";
fi

if [ ! -e ~/.vim/bundle ];
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

ln -sf ~/dotfiles/.vimrc ~
ln -sf ~/dotfiles/.tmux.conf ~
ln -sf ~/dotfiles/.inputrc ~
ln -sf ~/dotfiles/.gitconfig

vim +PluginInstall +qall
