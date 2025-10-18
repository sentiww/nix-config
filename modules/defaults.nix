{ ... }:
{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./system/boot.nix
    ./system/network.nix
    ./system/firewall.nix
    ./system/packages.nix
    ./system/services.nix
    ./system/desktop.nix
    ./system/users.nix
    ./system/virtualisation.nix
  ];
}
