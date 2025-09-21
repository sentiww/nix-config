{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;

  # Firewall configuration
  networking.firewall.allowedTCPPorts = [ 57621 ]; # For Spotify
  networking.firewall.allowedUDPPorts = [ 5353 ]; # For mDNS/Avahi
}
