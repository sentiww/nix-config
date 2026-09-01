{ pkgs, ... }:
{
  home.packages = with pkgs; [
    thunderbird
    steam
    discord
    spotify
    gimp
    blender
    teams-for-linux
    bitwarden-desktop
    networkmanagerapplet
    pamixer
    playerctl
    libnotify
    pavucontrol
    brightnessctl
    cava
  ];
}
