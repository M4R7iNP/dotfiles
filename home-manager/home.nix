{ config, pkgs, ... }:

{
  home.username = "martin";
  home.homeDirectory = "/home/martin";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "UbuntuMono" "UbuntuSans" ]; })
    # nerd-fonts.ubuntu-mono
    # nerd-fonts.ubuntu-sans

    neovim
    # lua51Packages.tiktoken_core
    luajitPackages.tiktoken_core
    nixd
    harper
    kubectl
    kubernetes-helm
    google-cloud-sdk-gce
    saml2aws
    micromamba
    opentofu
    terraform-ls
    pyright
    ruff
    mongosh
    fzf
    lynx
    # ollama-rocm
    rocmPackages.rocminfo
    awscli2
    volta
    duckdb
    uv
    skaffold
    kustomize
    just
    gopls
    goose-cli
  ];

  home.file = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };

  # services.ollama = {
  #   enable = true;
  #   acceleration = "rocm";
  # };

  home.enableNixpkgsReleaseCheck = false;
}
