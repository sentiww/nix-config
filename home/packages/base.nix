{ pkgs, ... }:
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
    nodePackages.live-server

    # IAC
    terraform
    act

    # IDE
    jetbrains.rider
  ];
}
