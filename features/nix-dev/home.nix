{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
  ];

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
