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

# Prompt to install packages
read -p "Install packages? [N|y] " -n 1 -r
echo

if [[ "$REPLY" =~ ^[Yy]$ ]] # if yes
then

    if [ "$ID_LIKE" == "debian" ];
    then
        sudo apt-get update
        sudo apt-get install ${PACKAGES[@]}
    elif [ "$ID" == "arch" ];
    then
        sudo pacman -Su ${PACKAGES[@]}
    fi

    # I ♥ unity
    if [ "$XDG_CURRENT_DESKTOP" == "Unity" ];
    then
        sudo apt-get install \
            indicator-multiload \
            compizconfig-settings-manager \
            compiz-plugins-extra

        # TODO: find a way to import unity profile from command line
        echo "Remember to import your unity profile!";
    fi
fi

if [ ! -e ~/.vim/bundle ];
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Create symlinks
ln -sf ~/dotfiles/.vimrc ~
ln -sf ~/dotfiles/.tmux.conf ~
ln -sf ~/dotfiles/.inputrc ~
ln -sf ~/dotfiles/.gitconfig ~
ln -sf ~/dotfiles/.vimrc ~/.vim/init.vim

# Create folders for nvim
mkdir -p ~/.config ~/.local/share/nvim/backup
ln -sf ~/.vim ~/.config/nvim

# Install vim plugins
vim +PluginInstall +qall
