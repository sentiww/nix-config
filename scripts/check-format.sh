#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./scripts/check-format.sh [options] [-- <nixfmt args>]

Options:
  --check            Run nixfmt in check mode (default).
  --format           Apply formatting (omit --check).
  -h, --help         Show this help message.

Additional arguments (or anything after `--`) are forwarded to nixfmt.
Runs on every tracked .nix file except hardware-configuration.nix.
EOF
}

mode="check"
formatter_args=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --check)
      mode="check"
      ;;
    --format|--write|--apply)
      mode="format"
      ;;
    --)
      shift
      formatter_args+=("$@")
      break
      ;;
    *)
      formatter_args+=("$1")
      ;;
  esac
  shift
done

if [[ $mode == "check" ]]; then
  formatter_args=(--check "${formatter_args[@]}")
fi

mapfile -d '' nix_files < <(git ls-files -z '*.nix')

filtered=()
for path in "${nix_files[@]}"; do
  if [[ "$path" == *"hardware-configuration.nix" ]]; then
    continue
  fi
  filtered+=("$path")
done

if [[ ${#filtered[@]} -eq 0 ]]; then
  echo "No .nix files found to format."
  exit 0
fi

nix run nixpkgs#nixfmt-rfc-style -- "${formatter_args[@]}" "${filtered[@]}"
