{ config, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    allowSFTP = true;
    settings = {
      X11Forwarding = true;
      X11UseLocalhost = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}