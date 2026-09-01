_: {
  imports = [
    ./hardware-configuration.nix
    ../../features/remote-access/ssh-client.nix
    ../../features/networking/wireguard/nixos.nix
  ];

  hostWireguardIp = "10.0.0.3";

  networking.hostName = "nixos"; # Define your hostname.
  system.stateVersion = "25.05"; # State version of the NixOS release
}
