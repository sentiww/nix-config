{ config, pkgs, ... }:
{
  home.username = "senti";
  home.homeDirectory = "/home/senti";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Day to day
    firefox
    thunderbird
    steam
    discord
    spotify
    gimp
    # .NET
    dotnet-sdk_9
    omnisharp-roslyn
    # JS
    nodejs_20
    nodePackages.pnpm
    nodePackages.yarn
    nodePackages.eslint
    nodePackages.prettier
    # nodePackages.vite
    nodePackages.typescript
    nodePackages.live-server
    # IAC
    terraform
    # IDE
    jetbrains.rider
    vscode
  ];

  programs.git = {
    enable = true;
    userName = "sentiww";
    userEmail = "wojciech.warwas01@gmail.com";
  };

  programs.fish = {
    enable = true;

    plugins = [
      # TODO: Fix ocmmand not found z, forgit
      { name = "z"; src = pkgs.fishPlugins.z; }
      { name = "fzf"; src = pkgs.fishPlugins.fzf-fish; }
      { name = "forgit"; src = pkgs.fishPlugins.forgit; }
      { name = "foreign-env"; src = pkgs.fishPlugins.foreign-env; }
    ];

    interactiveShellInit = ''
      set -gx EDITOR nvim
      set -gx PATH $HOME/.dotnet/tools $PATH
    '';
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      if [ -x "${pkgs.fish}/bin/fish" ] && [ -z "$__HM_SESSIONS_SHELL" ]; then
        export __HM_SESSIONS_SHELL=1
        exec ${pkgs.fish}/bin/fish
      fi
    '';
  };
}
