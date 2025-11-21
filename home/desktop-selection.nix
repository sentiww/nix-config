{ lib, desktopEnvironment, ... }:
let
  desktopModules = {
    gnome = ./gnome;
  };
  selectedModule = lib.getAttr desktopEnvironment desktopModules;
in
{
  imports = [
    selectedModule
  ];
}
