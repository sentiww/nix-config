#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./scripts/run-lints.sh [options]

Options:
  --statix-arg <arg>     Append an argument for statix (repeatable).
  --deadnix-arg <arg>    Append an argument for deadnix (repeatable).
  --skip-statix          Skip running statix.
  --skip-deadnix         Skip running deadnix.
  -h, --help             Show this help message.

By default, statix runs `statix check` and deadnix runs with
`--fail --exclude hosts/*/hardware-configuration.nix`.
EOF
}

run_statix=true
run_deadnix=true
statix_args=()
deadnix_args=(
  --fail
  --exclude ./hosts/laptop/hardware-configuration.nix ./hosts/desktop/hardware-configuration.nix
)

while [[ $# -gt 0 ]]; do
  case "$1" in
    --statix-arg)
      shift
      [[ $# -gt 0 ]] || { echo "Missing value for --statix-arg" >&2; exit 1; }
      statix_args+=("$1")
      ;;
    --deadnix-arg)
      shift
      [[ $# -gt 0 ]] || { echo "Missing value for --deadnix-arg" >&2; exit 1; }
      deadnix_args+=("$1")
      ;;
    --skip-statix)
      run_statix=false
      ;;
    --skip-deadnix)
      run_deadnix=false
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

if [[ $run_statix == false && $run_deadnix == false ]]; then
  echo "Skipping statix and deadnix; nothing to do."
  exit 0
fi

if [[ $run_statix == true ]]; then
  nix run nixpkgs#statix -- check "${statix_args[@]}"
fi

if [[ $run_deadnix == true ]]; then
  nix run nixpkgs#deadnix -- "${deadnix_args[@]}"
fi
