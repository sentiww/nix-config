{ config, pkgs, ... }:
{
  home.username = "senti";
  home.homeDirectory = "/home/senti";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    firefox
    thunderbird
    steam
    discord
    spotify
    jetbrains.rider
  ];

  programs.git = {
    enable = true;
    userName = "sentiww";
    userEmail = "wojciech.warwas01@gmail.com";
  };
}
