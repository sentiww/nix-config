{ config, pkgs, lib, ... }:
let
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
  wallpaperSource = ../../wallpaper/wallpaper.png;
  wallpaperTarget = "${config.home.homeDirectory}/.local/share/backgrounds/nixos-gnome.png";
  conkyConfig = ''
    conky.config = {
      alignment = 'top_right';
      background = true;
      default_color = '#f6f6f6';
      double_buffer = true;
      font = 'Cantarell 11';
      gap_x = 60;
      gap_y = 60;
      minimum_height = 400;
      minimum_width = 260;
      maximum_width = 260;
      own_window = true;
      own_window_argb_value = 150;
      own_window_argb_visual = true;
      own_window_class = 'Conky';
      own_window_type = 'dock';
      own_window_hints = 'undecorated,sticky,skip_taskbar,skip_pager,below';
      update_interval = 1;
      use_xft = true;
      imlib_cache_size = 0;
    };

    conky.text = [[
''${image ~/.config/conky/alterf/assets/overlay.png -p 0,0 -s 260x260}
''${offset 20}''${font Cantarell:bold:size=26}''${color #ff4d67}''${time %H:%M}
''${offset 20}''${font Cantarell:size=12}''${color #f6f6f6}''${time %A, %d %B}

''${offset 20}''${color #ff4d67}CPU ''${color #f6f6f6}''${cpu cpu0}% ''${cpubar 6,110}
''${offset 20}''${color #ff4d67}GPU ''${color #f6f6f6}''${exec bash -c "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1 || echo N/A"}%
''${offset 20}''${color #ff4d67}RAM ''${color #f6f6f6}''${memperc}% ''${membar 6,110}
''${offset 20}''${color #ff4d67}NET ''${if_up enp3s0}''${color #f6f6f6}⬆ ''${upspeed enp3s0} ⬇ ''${downspeed enp3s0}''${else}''${if_up wlp3s0}''${color #f6f6f6}⬆ ''${upspeed wlp3s0} ⬇ ''${downspeed wlp3s0}''${else}''${color #f6f6f6}No link''${endif}''${endif}

''${offset 20}''${color #ff4d67}''${font Cantarell:bold:size=14}Now Playing
''${offset 20}''${color #f6f6f6}''${exec playerctl metadata --format '{{ artist }} - {{ title }}'}
    ]];
  '';
in
{
  home.packages = lib.mkAfter (with pkgs; [
    conky
    gtkTheme.package
    iconTheme.package
    shellTheme.package
  ]);

  gtk = {
    enable = true;
    theme = gtkTheme;
    iconTheme = iconTheme;
    cursorTheme = cursorTheme;
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
      name = shellTheme.name;
    };
  };

  home.file.".local/share/backgrounds/nixos-gnome.png".source = wallpaperSource;

  xdg.configFile."conky/alterf.conf".text = conkyConfig;
  xdg.configFile."conky/alterf/assets/overlay.png".source = ../../assets/conky/alterf/overlay.png;

  systemd.user.services.conky-alterf = {
    Unit = {
      Description = "Conky Alterf HUD";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.conky}/bin/conky -c ${config.xdg.configHome}/conky/alterf.conf";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
