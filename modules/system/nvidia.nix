{ config, pkgs, ... }:
{
  hardware.graphics = {
    enable = true; # Enable OpenGL
  };

  services.xserver.videoDrivers = [ "nvidia" ]; # NVIDIA drivers for Xorg and Wayland

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Preserve VRAM across hibernation
  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/var/tmp
  '';

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];

  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
