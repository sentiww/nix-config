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
      mkHost = import ./lib/mk-host.nix;

      pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = true;
        };
      };

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = true;
        };
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
        desktop = mkHost {
          inherit system nixpkgs pkgsUnstable home-manager sops-nix nix-index-database;
          hostPath = ./hosts/desktop;
          extraModules = [ ./features/hardware/nvidia.nix ];
        };

        laptop = mkHost {
          inherit system nixpkgs pkgsUnstable home-manager sops-nix nix-index-database;
          hostPath = ./hosts/laptop;
        };

        x1 = mkHost {
          inherit system nixpkgs pkgsUnstable home-manager sops-nix nix-index-database;
          hostPath = ./hosts/x1;
        };
      };
    };
}
