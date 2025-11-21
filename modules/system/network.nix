{ ... }:
{
  networking.networkmanager.enable = true;

  # Firewall configuration
  networking.firewall = {
    allowedTCPPorts = [ 22 57621 ]; # For SSH, Spotify
    allowedUDPPorts = [ 5353 ]; # For mDNS/Avahi
  };
}
