{
  lib,
  config,
  pkgs,
  ...
}:
let
  isGnome = config.desktop.environment == "gnome";
  extensionPackages =
    let
      requestedExtensions = [
        "appindicator"
        "blur-my-shell"
        "tiling-assistant"
        "dash-to-panel"
        "vitals"
        "desktop-cube"
        "just-perfection"
        "user-themes"
      ];
      mkExtension =
        name:
        if builtins.hasAttr name pkgs.gnomeExtensions then
          [ (builtins.getAttr name pkgs.gnomeExtensions) ]
        else
          lib.warn "Requested GNOME extension `${name}` is not packaged in this nixpkgs; skipping." [ ];
    in
    lib.concatMap mkExtension requestedExtensions;
in
{
  config = lib.mkIf isGnome {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "us"; # Keyboard layout
        variant = ""; # Keyboard variant
      };
    };

    services.gnome.gnome-keyring.enable = true;
    programs.dconf.enable = true;

    xdg.portal = {
      enable = true;
      config.common.default = [
        "gnome"
        "gtk"
      ];
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    environment.systemPackages = [ pkgs.gnome-tweaks ] ++ extensionPackages;

    fonts.packages = with pkgs; [
      font-awesome
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-emoji
      jetbrains-mono
    ];
  };
}
