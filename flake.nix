{
  description = "senti's NixOS flake";

  inputs = {
    # Base
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Secrets handling (SOPS)
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Prebuilt nix-index database
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      sops-nix,
      nix-index-database,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ./overlays/kimaki.nix)
        ];
      };
    in
    {
      legacyPackages.${system} = {
        inherit (pkgs) kimaki;
      };

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit pkgsUnstable;
            inherit pkgs;
          };

          modules = [
            ./modules/defaults.nix
            ./modules/system/nvidia.nix
            ./hosts/desktop

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
                  users.senti = import ./home/senti.nix;
                  backupFileExtension = "hm-bak";
                };
              }
            )
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit pkgsUnstable;
            inherit pkgs;
          };

          modules = [
            ./modules/defaults.nix
            ./hosts/laptop

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
                  users.senti = import ./home/senti.nix;
                  backupFileExtension = "hm-bak";
                };
              }
            )
          ];
        };

        x1 = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit pkgsUnstable;
            inherit pkgs;
          };

          modules = [
            ./modules/defaults.nix
            ./hosts/x1

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
