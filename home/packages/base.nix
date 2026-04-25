{ pkgs, pkgsUnstable, ... }:
{
  home.packages = with pkgs; [
    # Day to day
    firefox
    thunderbird
    steam
    discord
    spotify
    gimp
    kitty
    blender
    teams-for-linux
    bitwarden-desktop
    obsidian
    networkmanagerapplet
    pamixer
    playerctl
    libnotify
    pavucontrol
    brightnessctl
    cava

    # .NET
    dotnet-sdk_9
    omnisharp-roslyn

    # JS
    nodejs_20
    nodePackages.pnpm
    nodePackages.yarn
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.typescript

    # Nix
    nixd

    # IAC
    terraform
    act

    # IDE
    jetbrains.rider

    # AI
    pkgsUnstable.opencode
  ];
}
