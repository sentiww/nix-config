{ config, pkgs, ... }:
{
  hardware.graphics = {
    enable = true; # Enable OpenGL
  };

  services.xserver.videoDrivers = [ "nvidia" ]; # NVIDIA drivers for Xorg and Wayland

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
