{
  config,
  pkgs,
  lib,
  ...
}:
let
  gtkTheme = {
    name = "nordic";
    package = pkgs.nordic;
  };
  iconTheme = {
    name = "Nordzy";
    package = pkgs.nordzy-icon-theme;
  };
  shellTheme = {
    name = "nordic";
    package = pkgs.nordic;
  };
  cursorTheme = {
    name = "Nordzy-cursors-white";
    package = pkgs.nordzy-cursor-theme;
    size = 24;
  };
  wallpaperSource = ../../../assets/wallpapers/wallpaper.png;
  wallpaperTarget = "${config.home.homeDirectory}/.local/share/backgrounds/nixos-gnome.png";

  conkyConfig = ''
        conky.config = {
          alignment = 'top_right';
          background = true;
          default_color = '#f6f6f6';
          double_buffer = true;
          font = 'JetBrains Mono 11';
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
    ''${offset 20}''${font JetBrains Mono:bold:size=26}''${color #81A1C1}''${time %H:%M}
    ''${offset 20}''${font JetBrains Mono:size=12}''${color #f6f6f6}''${time %A, %d %B}

    ''${offset 20}''${color #81A1C1}CPU ''${color #f6f6f6}''${cpu cpu0}% ''${cpubar 6,110}
    ''${offset 20}''${color #81A1C1}GPU ''${color #f6f6f6}''${exec bash -c "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1 || echo N/A"}%
    ''${offset 20}''${color #81A1C1}RAM ''${color #f6f6f6}''${memperc}% ''${membar 6,110}
    ''${offset 20}''${color #81A1C1}NET ''${if_up enp3s0}''${color #f6f6f6}⬆ ''${upspeed enp3s0} ⬇ ''${downspeed enp3s0}''${else}''${if_up wlp3s0}''${color #f6f6f6}⬆ ''${upspeed wlp3s0} ⬇ ''${downspeed wlp3s0}''${else}''${color #f6f6f6}No link''${endif}''${endif}

    ''${offset 20}''${color #81A1C1}''${font JetBrains Mono:bold:size=14}Now Playing
    ''${offset 20}''${color #f6f6f6}''${exec playerctl metadata --format '{{ artist }} - {{ title }}'}
        ]];
  '';
in
{
  home.packages = lib.mkAfter (
    with pkgs;
    [
      conky
      gtkTheme.package
      iconTheme.package
      shellTheme.package
      pkgs.nordzy-cursor-theme
      pkgs.gnomeExtensions.arcmenu
      pkgs.gnomeExtensions.blur-my-shell
    ]
  );

  gtk = {
    enable = true;
    theme = gtkTheme;
    inherit iconTheme cursorTheme;
  };

  home.sessionVariables = {
    XCURSOR_PATH = "/run/current-system/sw/share/icons:~/.local/share/icons:${pkgs.nordzy-cursor-theme}/share/icons";
  };

  xdg.configFile."mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/http=firefox.desktop
    x-scheme-handler/https=firefox.desktop
    text/html=firefox.desktop
  '';

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = cursorTheme.name;
      cursor-size = cursorTheme.size;
      enable-hot-corners = false;
      font-name = "JetBrains Mono 11";
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
        "gsconnect@andyholmes.github.io"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "arcmenu@arcmenu.com"
      ];
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "kitty.desktop"
        "obsidian.desktop"
        "org.gnome.Settings.desktop"
        "thunderbird.desktop"
      ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      inherit (shellTheme) name;
    };

    "org/gnome/shell/extensions/arcmenu" = {
      menu-button-appearance = "Icon";
      menu-button-icon = "Distro_Icon";
      menu-button-border-radius = "(true, 0)";
      menu-button-border-width = "(true, 0)";
      menu-button-hover-bg-color = "(true, rgba(242,242,242,0.15))";
      menu-button-hover-fg-color = "(false, rgb(242,242,242))";
      distro-icon = 22;
      custom-menu-button-icon-size = 32.0;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      panel-element-positions = ''{"BOE-0x00000000":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'';
    };
  };

  home.file.".local/share/backgrounds/nixos-gnome.png".source = wallpaperSource;

  xdg.configFile."conky/alterf.conf".text = conkyConfig;
  xdg.configFile."conky/alterf/assets/overlay.png".source = ../../../assets/conky/alterf/overlay.png;

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
