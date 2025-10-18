{ config, pkgs, ... }:
{
  users.users.senti = {
    isNormalUser = true;
    description = "Senti";
    extraGroups = [ "wheel" "networkmanager" "vboxusers" ];
    packages = with pkgs; [ ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHAzQxZFR7px3z4VC9N+1Y3b3Z3/hLXRx6dBw5Ch76dE senti@nixos"
    ];
  };
}
