{ ... }:
{
  imports = [
    ./desktop-selection.nix
    ./programs
    ./packages
  ];

  home = {
    username = "senti";
    homeDirectory = "/home/senti";
    stateVersion = "25.05";
  };
}
