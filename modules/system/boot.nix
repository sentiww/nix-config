{ ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "nvidia-modeset.hdmi_deepcolor=0"
    ];
    blacklistedKernelModules = [ "kvm_amd" "kvm" ];
  };
}
