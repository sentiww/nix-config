{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vscode
    dotnet-sdk_9
    omnisharp-roslyn
  ];
}
