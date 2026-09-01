{ lib, desktopEnvironment, ... }:
let
  desktopModules = {
    gnome = ./gnome/home.nix;
  };
  selectedModule = lib.getAttr desktopEnvironment desktopModules;
in
{
  imports = [
    selectedModule
  ];
}
