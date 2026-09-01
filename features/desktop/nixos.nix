{ lib, ... }:
let
  selectedDesktopModule = ./gnome/nixos.nix;
  selectedDesktop = "gnome";
in
{
  imports = [
    selectedDesktopModule
  ];

  options.desktop.environment = lib.mkOption {
    type = lib.types.enum [ "gnome" ];
    default = "gnome";
    description = ''
      Selects which desktop environment stack to enable. The value is set by
      `features/desktop/nixos.nix` so Home Manager can follow the same desktop.
    '';
    example = "gnome";
  };

  config = {
    desktop.environment = selectedDesktop;

    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
