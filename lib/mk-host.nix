{
  system,
  nixpkgs,
  pkgs,
  pkgsUnstable,
  home-manager,
  sops-nix,
  nix-index-database,
  hostPath,
  extraModules ? [ ],
}:
nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit pkgs pkgsUnstable;
  };

  modules = [
    ./../profiles/base/nixos.nix
  ] ++ extraModules ++ [
    hostPath

    sops-nix.nixosModules.sops
    home-manager.nixosModules.home-manager
    nix-index-database.nixosModules.nix-index

    (
      { config, ... }:
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            desktopEnvironment = config.desktop.environment;
            inherit pkgsUnstable;
          };
          users.senti = import ./../users/senti/home.nix;
          backupFileExtension = "hm-bak";
        };
      }
    )
  ];
}
