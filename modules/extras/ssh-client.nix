{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ waypipe ];
}