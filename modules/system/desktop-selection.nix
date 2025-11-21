{ lib, ... }:
let
  # Change this line to pick your desktop; the name is derived automatically.
  selectedDesktopModule = ./desktops/gnome.nix;
  selectedDesktop = lib.removeSuffix ".nix" (builtins.baseNameOf selectedDesktopModule);
in
{
  imports = [
    selectedDesktopModule
  ];

  # Keep desktop.environment in sync with the chosen module so HM extras work.
  desktop.environment = selectedDesktop;
}
