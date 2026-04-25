{ config, lib, pkgs, ... }:

{
  programs.obsidian = {
    enable = true;

    vaults."Default" = {
      enable = true;
    };

    defaultSettings = {
      communityPlugins = [
        {
          pkg = pkgs.callPackage ../plugins/obsidian/brat.nix { };
        }
        {
          pkg = pkgs.callPackage ../plugins/obsidian/opencode-obsidian.nix { };
        }
      ];
    };
  };
}