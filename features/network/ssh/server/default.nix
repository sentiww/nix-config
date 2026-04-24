{ lib, ... }:
{
  services = {
    xserver = {
      enable = true;
      displayManager.lightdm.enable = lib.mkForce false;
      displayManager.gdm.enable = lib.mkForce true;
      desktopManager.gnome.enable = true;
      videoDrivers = [ "dummy" ];
      xrandrHeads = [
        {
          output = "Virtual-1";
          primary = true;
          monitorConfig = ''
            Option "PreferredMode" "1920x1080"
          '';
        }
      ];
    };

    xrdp = {
      enable = true;
      defaultWindowManager = "gnome-session";
    };

    displayManager.autoLogin.enable = false;
    getty.autologinUser = null;
  };

  environment.etc."X11/xorg.conf.d/10-dummy.conf".text = ''
    Section "Device"
        Identifier "DummyDevice"
        Driver "dummy"
        Option "SWCursor" "true"
    EndSection

    Section "Monitor"
        Identifier "Virtual-1"
        Option "PreferredMode" "1920x1080"
    EndSection

    Section "Screen"
        Identifier "Screen0"
        Device "DummyDevice"
        Monitor "Virtual-1"
    EndSection
  '';

  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";

  networking.firewall.allowedTCPPorts = [ 3389 ];

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
}
