{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;

  # Firewall configuration
  networking.firewall.allowedTCPPorts = [ 22 57621 ]; # For SSH, Spotify
  networking.firewall.allowedUDPPorts = [ 5353 ]; # For mDNS/Avahi

  # Wireguard
  networking.wireguard.enable = true;
  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.3/24" ];
    privateKeyFile = "/home/senti/.config/wireguard/private.key";
    peers = [
      {
        publicKey = "ZQBVad3wepbfQcYMxMicY9wG29LEeFpjGUr+4C3ksx4=";
        allowedIPs = [ "10.0.0.0/24" ];
        endpoint = "157.180.69.13:51820";
        persistentKeepalive = 25;
      }
    ];
  };
}
