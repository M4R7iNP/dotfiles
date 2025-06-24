#!/bin/bash

# sudo dnf groupinstall "Development Tools"
dnf install @development-tools

pkcon install \
    git \
    git-crypt \
    conda \
    python3-pip \
    kubernetes-client \
    helm \
    google-noto-emoji-fonts \
    parallel \
    ripgrep \
    fd-find \
    rustup

pip install --user pyright neovim

# sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
# sudo dnf install vault terraform terraform-ls

