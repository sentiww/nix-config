[![Flake Checks](https://github.com/sentiww/nix-config/actions/workflows/flake-check.yml/badge.svg)](https://github.com/sentiww/nix-config/actions/workflows/flake-check.yml)
[![Nix Formatting](https://github.com/sentiww/nix-config/actions/workflows/nix-format.yml/badge.svg)](https://github.com/sentiww/nix-config/actions/workflows/nix-format.yml)
[![Nix Linters](https://github.com/sentiww/nix-config/actions/workflows/nix-lints.yml/badge.svg)](https://github.com/sentiww/nix-config/actions/workflows/nix-lints.yml)

Install from remote:
```
sudo nixos-rebuild switch --flake github:sentiww/nix-config#desktop
```

Install locally:
```
git clone https://github.com/sentiww/nix-config
cd ./nix-config
sudo nixos-rebuild switch --flake ~/nix-config#desktop
```
