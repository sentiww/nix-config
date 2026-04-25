{ lib, ... }: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.overlays = lib.mkForce [];

  imports = [
    ./system/boot.nix
    ./system/network.nix
    ./system/firewall.nix
    ./system/packages.nix
    ./system/services.nix
    ./system/desktop.nix
    ./system/desktop-selection.nix
    ./system/users.nix
    ./system/virtualisation.nix
  ];
}
