_: {
  imports = [
    ./programs
    ../desktop/gnome/home.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "senti";
    homeDirectory = "/home/senti";
    stateVersion = "25.05";
  };
}
