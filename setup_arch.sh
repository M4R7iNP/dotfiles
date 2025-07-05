SUDO=""
if which sudo; then
    SUDO="sudo"
fi

$SUDO pacman -Syq --needed $(cat arch-pkgs.txt)
