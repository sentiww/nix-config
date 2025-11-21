{ pkgs, ... }:
let
  codexExtension = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "chatgpt";
      publisher = "openai";
      version = "0.5.43";
      sha256 = "sha256-K3SyDMXYc46EN5YgK3nTJItzltsFEpBfsLU7Lh9Mc78=";
    }
  ];

  dotnetMarketplaceExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;

    profiles = {
      default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
      };

      dotnet = {
        extensions =
          with pkgs.vscode-extensions;
          [
            ms-dotnettools.csharp
            ms-dotnettools.vscode-dotnet-runtime
            ms-azuretools.vscode-docker
            editorconfig.editorconfig
          ]
          ++ codexExtension
          ++ dotnetMarketplaceExtensions;

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
        extensions =
          with pkgs.vscode-extensions;
          [
            dbaeumer.vscode-eslint
            esbenp.prettier-vscode
            bradlc.vscode-tailwindcss
            formulahendry.auto-rename-tag
          ]
          ++ codexExtension;

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
        extensions =
          with pkgs.vscode-extensions;
          [
            jnoortheen.nix-ide
            mkhl.direnv
            tamasfe.even-better-toml
          ]
          ++ codexExtension;
      };
    };
  };
}
