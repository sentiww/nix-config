{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.hostWireguardIp = lib.mkOption {
    type = lib.types.str;
    description = "WireGuard IP address for this host.";
  };

  config = {
    networking.wireguard.enable = true;

    networking.wireguard.interfaces.wg0 = {
      ips = [ "${config.hostWireguardIp}/24" ];
      privateKeyFile = "/etc/wireguard/private.key";

      peers = [
        {
          publicKey = "ZQBVad3wepbfQcYMxMicY9wG29LEeFpjGUr+4C3ksx4=";
          endpoint = "157.180.69.13:51820";
          allowedIPs = [ "10.0.0.0/24" ];
          persistentKeepalive = 25;
        }
      ];
    };

    system.activationScripts.ensureWireguardKey.text = ''
      mkdir -p /etc/wireguard
      if [ ! -f /etc/wireguard/private.key ]; then
        echo "Generating WireGuard keypair..."
        umask 077
        ${pkgs.wireguard-tools}/bin/wg genkey | tee /etc/wireguard/private.key | \
          ${pkgs.wireguard-tools}/bin/wg pubkey > /etc/wireguard/public.key
      fi
      chmod 600 /etc/wireguard/private.key
      chmod 644 /etc/wireguard/public.key
    '';
  };
}
