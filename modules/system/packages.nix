{ config, pkgs, ... }:

{
  programs.nix-index-database.comma.enable = true;
  programs.command-not-found.enable = false;

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    htop
    btop
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
    wofi
  ];
}
