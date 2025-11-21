{ pkgs, ... }:
let
  basePackages = with pkgs; [
    # Day to day
    firefox
    thunderbird
    steam
    discord
    spotify
    gimp
    kitty
    blender
    teams-for-linux
    bitwarden-desktop
    networkmanagerapplet
    pamixer
    playerctl
    libnotify
    pavucontrol
    brightnessctl
    cava

    # .NET
    dotnet-sdk_9
    omnisharp-roslyn
    # JS
    nodejs_20
    nodePackages.pnpm
    nodePackages.yarn
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.live-server
    # IAC
    terraform
    act
    # IDE
    jetbrains.rider
  ];

in
{
  imports = [
    ./desktop-selection.nix
  ];

  home = {
    username = "senti";
    homeDirectory = "/home/senti";
    stateVersion = "25.05";
    packages = basePackages;
  };

  programs = {
    git = {
      enable = true;
      userName = "sentiww";
      userEmail = "wojciech.warwas01@gmail.com";
    };

    vscode =
    let
      codexExtension =
        pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "chatgpt";
            publisher = "openai";
            version = "0.5.43";
            sha256 = "sha256-K3SyDMXYc46EN5YgK3nTJItzltsFEpBfsLU7Lh9Mc78=";
          }
        ];

      dotnetMarketplaceExtensions =
        pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "csdevkit";
            publisher = "ms-dotnettools";
            version = "1.81.7";
            sha256 = "sha256-pCq1xUmxn2nSk6aKisXA6+89UFjMEYZjNGXxOKuoQoE=";
          }
          {
            name = "intellij-idea-keybindings";
            publisher = "k--kato";
            version = "1.7.6";
            sha256 = "sha256-eSt4iT/o4mp17Dasr0gDr3SsQHX3R6jGmW4V/2KymnY=";
          }
        ];
    in
    {
      enable = true;
      package = pkgs.vscode;
      mutableExtensionsDir = false;

      profiles = {
        default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
        };

        dotnet = {
          extensions = with pkgs.vscode-extensions; [
            ms-dotnettools.csharp
            ms-dotnettools.vscode-dotnet-runtime
            ms-azuretools.vscode-docker
            editorconfig.editorconfig
          ] ++ codexExtension ++ dotnetMarketplaceExtensions;

          userSettings = {
            "[csharp]" = {
              "editor.defaultFormatter" = "ms-dotnettools.csharp";
              "editor.formatOnSave" = true;
            };
            "workbench.editor.enablePreview" = false;
            "editor.inlineSuggest.enabled" = true;
            "editor.codeLens" = true;
            "omnisharp.enableDecompilationSupport" = true;
            "omnisharp.enableRoslynAnalyzers" = true;
            "omnisharp.enableEditorConfigSupport" = true;
            "omnisharp.organizeImportsOnFormat" = true;
            "omnisharp.useModernNet" = true;
          };
        };

        react = {
          extensions = with pkgs.vscode-extensions; [
            dbaeumer.vscode-eslint
            esbenp.prettier-vscode
            bradlc.vscode-tailwindcss
            formulahendry.auto-rename-tag
          ] ++ codexExtension;

          userSettings = {
            "[javascript]" = {
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
              "editor.formatOnSave" = true;
            };
            "[javascriptreact]" = {
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
              "editor.formatOnSave" = true;
            };
            "[typescript]" = {
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
              "editor.formatOnSave" = true;
            };
            "[typescriptreact]" = {
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
              "editor.formatOnSave" = true;
            };
            "eslint.validate" = [
              "javascript"
              "javascriptreact"
              "typescript"
              "typescriptreact"
            ];
            "editor.codeActionsOnSave" = {
              "source.fixAll" = true;
              "source.organizeImports" = true;
            };
          };
        };

        nix = {
          extensions = with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
            mkhl.direnv
            tamasfe.even-better-toml
          ] ++ codexExtension;
        };
      };
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [
        # Enable a plugin (here grc for colorized command output) from nixpkgs
        { name = "grc"; inherit (pkgs.fishPlugins.grc) src; }
      ];
    };

    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        mouse_hide_wait = "-1.0";
        window_padding_width = 10;
        background_opacity = "0.5";
        background_blur = 5;
        symbol_map = let
          mappings = [
            "U+23FB-U+23FE"
            "U+2B58"
            "U+E200-U+E2A9"
            "U+E0A0-U+E0A3"
            "U+E0B0-U+E0BF"
            "U+E0C0-U+E0C8"
            "U+E0CC-U+E0CF"
            "U+E0D0-U+E0D2"
            "U+E0D4"
            "U+E700-U+E7C5"
            "U+F000-U+F2E0"
            "U+2665"
            "U+26A1"
            "U+F400-U+F4A8"
            "U+F67C"
            "U+E000-U+E00A"
            "U+F300-U+F313"
            "U+E5FA-U+E62B"
          ];
        in
          (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font";
      };
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
