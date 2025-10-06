{ config, pkgs, ... }:

{
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
  ];
}
