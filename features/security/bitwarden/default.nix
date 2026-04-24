{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.bitwarden-desktop ];
}
