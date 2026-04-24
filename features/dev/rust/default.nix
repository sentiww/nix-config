{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.rustc ];
}
