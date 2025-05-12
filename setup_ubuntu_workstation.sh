set -e

sudo apt install build-essential cmake

sudo apt install \
    htop \
    podman \
    git \
    git-crypt \
    python3-pip \
    parallel \
    ripgrep \
    fd-find \
    pgcli \
    mycli \
    postgresql-client \
    awscli \
    caddy \
    brotli \
    ipcalc \
    pwgen \
    direnv \
    rustup

sudo snap install code
sudo snap install spotify
sudo snap install dbeaver-ce
sudo snap install vlc

# pip install --user pyright neovim
