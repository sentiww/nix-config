_: {
  imports = [
    ./desktop-selection.nix
    ./programs
    ./packages
    ./programs/obsidian.nix
  ];

  home = {
    username = "senti";
    homeDirectory = "/home/senti";
    stateVersion = "25.11";
  };
}
