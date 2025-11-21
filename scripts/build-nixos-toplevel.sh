#!/usr/bin/env bash
set -euo pipefail

configs=("$@")
if [[ ${#configs[@]} -eq 0 ]]; then
  configs=(desktop laptop)
fi

for config in "${configs[@]}"; do
  echo "Building nixosConfigurations.${config}"
  nix build ".#nixosConfigurations.${config}.config.system.build.toplevel"
done
