{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs_20
    nodePackages.pnpm
    nodePackages.yarn
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.live-server
  ];
}
