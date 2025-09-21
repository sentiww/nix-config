{ config, pkgs, ... }:
{
  users.users.senti = {
    isNormalUser = true;
    description = "Senti";
    extraGroups = [ "wheel" "networkmanager" ]; # etc.
    packages = with pkgs; [ ];
    shell = pkgs.bash;
  };
}
