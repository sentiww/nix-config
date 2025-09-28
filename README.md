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