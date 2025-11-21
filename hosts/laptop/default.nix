_:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/extras/ssh-common.nix
    ./../../modules/extras/wireguard.nix
  ];

  hostWireguardIp = "10.0.0.3";

  networking.hostName = "nixos"; # Define your hostname.
  time.timeZone = "Europe/Warsaw"; # Set your time zone.
  i18n.defaultLocale = "en_US.UTF-8"; # Default locale
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };
  system.stateVersion = "25.05"; # State version of the NixOS release
}
