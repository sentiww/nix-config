{ pkgs, lib, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    adwaita-icon-theme
  ];

  environment.sessionVariables = {
    GTK_THEME = "Adwaita";
    GDK_BACKEND = "x11";
  };



  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
  ];
}
