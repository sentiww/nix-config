{
  description = "senti's NixOS flake";

  inputs = {
    # Base
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Secrets handling (SOPS)
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Prebuilt nix-index database
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      sops-nix,
      nix-index-database,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./modules/defaults.nix
            ./modules/system/nvidia.nix
            ./hosts/desktop

            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            nix-index-database.nixosModules.nix-index

            (
              { config, ... }:
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    desktopEnvironment = config.desktop.environment;
                  };
                  users.senti = import ./home/senti.nix;
                  backupFileExtension = "hm-bak";
                };
              }
            )
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./modules/defaults.nix
            ./hosts/laptop

            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            nix-index-database.nixosModules.nix-index

            {
              stylix.enable = false;
              stylix.image = ./wallpaper.png;
            }

            (
              { config, ... }:
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    desktopEnvironment = config.desktop.environment;
                  };
                  users.senti = import ./home/senti.nix;
                  backupFileExtension = "hm-bak";
                };
              }
            )
          ];
        };
      };
    };
}
