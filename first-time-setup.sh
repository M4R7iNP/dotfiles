#!/bin/bash

# Import distro info variables
. /etc/os-release;

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
automake
build-essential
terminator
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

        read -p "Install neovim? [N|y] " -n 1 -r && echo
        [[ "$REPLY" =~ ^[Yy]$ ]] && \
            sudo apt install -y neovim && \
            pip install --user neovim && \
            npm i -g neovim
    elif [ "$ID" == "fedora" ];
    then
        sudo yum install -y vim \
            curl \
            tmux \
            automake \
            terminator \

        read -p "Install neovim? [N|y] " -n 1 -r && echo
        [[ "$REPLY" =~ ^[Yy]$ ]] && \
            sudo yum install -y neovim && \
            pip install --user neovim && \
            npm i -g neovim

        read -p "Install logid? [N|y] " -n 1 -r && echo
        [[ "$REPLY" =~ ^[Yy]$ ]] && \
            sudo yum install -y logid && \
            sudo ln -sf ~/dotfiles/logid.cfg /etc/logid.cfg &&
            sudo systemctl enable logid &&
            sudo systemctl start logid
    elif [ "$ID" == "arch" ];
    then
        sudo pacman -Su ${PACKAGES[@]}
    fi
fi

if ps aux | grep -q gnome-shell;
then
    dconf write /org/gnome/desktop/interface/enable-animations false

    # kb & mouse
    dconf write /org/gnome/desktop/peripherals/mouse/accel-profile \'flat\'
    dconf write /org/gnome/desktop/interface/gtk-enable-primary-paste false
    dconf write /org/gnome/desktop/input-sources/show-all-sources true
    dconf write /org/gnome/desktop/input-sources/xkb-options "['lv3:ralt_switch', 'grp:alt_shift_toggle']"
    dconf write /org/gnome/desktop/wm/preferences/mouse-button-modifier "'<Alt>'"
    dconf write /org/gnome/desktop/wm/preferences/resize-with-right-button true
    dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'us'), ('xkb', 'no')]"

    # kb shortcuts
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Pimary><Alt>t'"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command 'gnomee-terminal'
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name 'gnome-terminal'
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/binding "'<Super>e'"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/command 'nautilus'
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/name 'nautilus'
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"
fi

if [ ! -e ~/.vim/bundle ];
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Create symlinks
ln -sf ~/dotfiles/.vimrc ~
ln -sf ~/dotfiles/.tmux.conf ~
ln -sf ~/dotfiles/.inputrc ~
ln -sf ~/dotfiles/.psqlrc ~
ln -sf ~/dotfiles/.git{config,ignore_global} ~
ln -sf ~/dotfiles/.vimrc ~/.vim/init.vim

# Create folders for nvim
mkdir -p \
    ~/.config \
    ~/.local/share/nvim/backup \
    ~/.config/terminator

ln -sf ~/.vim ~/.config/nvim
ln -sf ~/dotfiles/terminator.config ~/.config/terminator/config

# Install vim plugins
vim +PluginInstall +qall

NPM_PACKAGES=(
eslint
prettier
)

# if npm is installed
NPM=$(command -v npm)
if [ -x $NPM ];
then
    if ! grep -q "^prefix" ~/.npmrc;
    then
        echo "prefix=/home/martin/.local" >> ~/.npmrc
    fi

    echo "Installing ${NPM_PACKAGES[@]}"

    $NPM install -g ${NPM_PACKAGES[@]}
fi

# Prompt to install ctags
read -p "Do you want ctags (universal ctags)? [N|y] " -n 1 -r
echo

if [[ "$REPLY" =~ ^[Yy]$ ]] # if yes
then

    pushd ~/dotfiles

    git clone https://github.com/universal-ctags/ctags.git ctags
    cd ctags

    ./autogen.sh
    ./configure --prefix=$HOME/.local
    make -j2
    make install

    popd

    # https://docs.ctags.io/en/latest/optlib.html#preload-option-file
    mkdir ~/.ctags.d
    ln -sf ~/dotfiles/.ctags ~/.ctags/AAA.ctags
fi

source ~/.bashrc
