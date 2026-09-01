{ pkgs, pkgsUnstable, ... }:
{
  home.packages = with pkgs; [
    dotnet-sdk_9
    omnisharp-roslyn
    nodejs_20
    nodePackages.pnpm
    nodePackages.yarn
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.typescript
    terraform
    act
    jetbrains.rider
    pkgsUnstable.opencode
  ];
}
