_: {
  imports = [
    ./hardware-configuration.nix
    ../../features/remote-access/ssh-client.nix
    ../../features/remote-access/xrdp-server.nix
    ../../features/networking/wireguard/nixos.nix
    ../../features/hardware/rtl-sdr.nix
  ];

  hostWireguardIp = "10.0.0.2";

  networking.hostName = "nixos"; # Define your hostname.
  system.stateVersion = "25.05"; # State version of the NixOS release

  # GPU driver override just for this machine
  services.xserver.videoDrivers = [ "nvidia" ];
}
