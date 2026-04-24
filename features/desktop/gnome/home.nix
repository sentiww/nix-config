{ config, pkgs, lib, ... }:

let
  wallpaperSource = ../../../assets/wallpapers/wallpaper.png;
  wallpaperTarget = "${config.home.homeDirectory}/.local/share/backgrounds/nixos-gnome.png";

  gtkTheme = {
    name = "Flat-Remix-GTK-Red-Darkest-fullPanel";
    package = pkgs.flat-remix-gtk;
  };

  iconTheme = {
    name = "Flat-Remix-Red-Dark";
    package = pkgs.flat-remix-icon-theme;
  };

  shellTheme = {
    name = "Qogir-ubuntu-dark";
    package = pkgs.qogir-theme;
  };

  cursorTheme = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };
in

{
  home.packages = lib.mkAfter [
    gtkTheme.package
    iconTheme.package
    shellTheme.package
  ];

  gtk = {
    enable = true;
    theme = gtkTheme;
    inherit iconTheme cursorTheme;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = cursorTheme.name;
      cursor-size = cursorTheme.size;
      enable-hot-corners = false;
      font-name = "Cantarell 11";
      icon-theme = iconTheme.name;
      gtk-theme = gtkTheme.name;
      monospace-font-name = "JetBrains Mono 11";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/background" = {
      picture-uri = "file://${wallpaperTarget}";
      picture-uri-dark = "file://${wallpaperTarget}";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri = "file://${wallpaperTarget}";
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      natural-scroll = true;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 3600;
      sleep-inactive-ac-type = "suspend";
      sleep-inactive-battery-timeout = 1800;
      sleep-inactive-battery-type = "suspend";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "tiling-assistant@leleat-on-github"
        "dash-to-panel@jderose9.github.com"
        "aylurs@aylur"
        "Vitals@CoreCoding.com"
        "bigavatar@NayanMalveda"
        "cpupower@sri"
        "desktop-cube@schneegans.github.com"
        "just-perfection-desktop@just-perfection"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "kitty.desktop"
        "org.gnome.Settings.desktop"
        "thunderbird.desktop"
      ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      inherit (shellTheme) name;
    };
  };

  home.file.".local/share/backgrounds/nixos-gnome.png".source = wallpaperSource;
}
