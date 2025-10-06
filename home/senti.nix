{ config, pkgs, ... }:
{
  home.username = "senti";
  home.homeDirectory = "/home/senti";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Day to day
    firefox
    thunderbird
    steam
    discord
    spotify
    gimp
    # .NET
    dotnet-sdk_9
    omnisharp-roslyn
    # JS
    nodejs_20
    nodePackages.pnpm
    nodePackages.yarn
    nodePackages.eslint
    nodePackages.prettier
    # nodePackages.vite
    nodePackages.typescript
    nodePackages.live-server
    # IAC
    terraform
    # IDE
    jetbrains.rider
    vscode
  ];

  programs.git = {
    enable = true;
    userName = "sentiww";
    userEmail = "wojciech.warwas01@gmail.com";
  };
}
