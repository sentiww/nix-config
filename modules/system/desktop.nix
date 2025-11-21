{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.desktop.environment = mkOption {
    type = types.enum [ "gnome" ];
    default = "gnome";
    description = ''
      Selects which desktop environment stack to enable. The value is set by
      `modules/system/desktop-selection.nix` so you only change one file to flip
      between desktops.
    '';
    example = "gnome";
  };

  config.nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
