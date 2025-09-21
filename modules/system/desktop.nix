{ config, pkgs, ... }:
{
  services.xserver.enable = true; # Enable X11
  services.xserver.displayManager.gdm.enable = true; # GNOME Display Manager
  services.xserver.desktopManager.gnome.enable = true; # GNOME Desktop

  services.xserver.xkb = {
    layout = "us"; # Keyboard layout
    variant = "";   # Keyboard variant
  };
}
