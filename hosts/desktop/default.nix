_: {
  imports = [
    ./hardware-configuration.nix
    ../../features/remote-access/ssh-client.nix
    ../../features/hardware/rtl-sdr.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.
  system.stateVersion = "25.05"; # State version of the NixOS release

  # GPU driver override just for this machine
  services.xserver.videoDrivers = [ "nvidia" ];
}
