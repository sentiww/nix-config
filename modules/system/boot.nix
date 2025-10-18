{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "nvidia-modeset.hdmi_deepcolor=0"
  ];
  boot.blacklistedKernelModules = [ "kvm_amd" "kvm" ];

}
