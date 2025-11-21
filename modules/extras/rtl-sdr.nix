{ pkgs, ... }:
{
  hardware.rtl-sdr.enable = true;
  boot.kernelParams = [ "modprobe.blacklist=dvb_usb_rtl28xxu" ]; 
  users.users.senti.extraGroups = [ "plugdev" ];
  environment.systemPackages = with pkgs; [ sdrpp ];
}
