{ config, pkgs, ... }:
{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
}
