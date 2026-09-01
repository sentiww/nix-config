_: {
  imports = [
    ./hardware-configuration.nix
    ../../features/remote-access/ssh-client.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.
  system.stateVersion = "25.05"; # State version of the NixOS release
}
