{ lib, config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../features/hardware/nvidia.nix
    ];

  networking.hostName = "nixos"; # Define your hostname.

  hardware.logitech.wireless.enable = true;

  services.xserver.videoDrivers = lib.mkForce [ "nvidia" ];

  console.keyMap = "pl2";

  environment.systemPackages = with pkgs; [
    git
    vscodium
  ];

  system.stateVersion = "25.11";
}
