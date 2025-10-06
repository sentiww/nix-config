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
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./modules/defaults.nix
            ./modules/system/nvidia.nix
            ./hosts/desktop

            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.senti = import ./home/senti.nix;
              home-manager.backupFileExtension = "backup";
            }
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./modules/defaults.nix
            ./hosts/laptop

            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.senti = import ./home/senti.nix;
              home-manager.backupFileExtension = "backup";
            }
          ];
        };
      };
    };
}
