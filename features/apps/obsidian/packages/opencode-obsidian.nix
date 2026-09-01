{ pkgs, ... }:
let
  mainjs_url = "https://github.com/mtymek/opencode-obsidian/releases/download/v0.2.1/main.js";
  mainjs_hash = "sha256-i1rnCBRCkKjSh737HHkp6iOYcGc0iE5/gWkcq1HbFT4=";
  mainjs = pkgs.fetchurl {
    url = mainjs_url;
    hash = mainjs_hash;
  };
in
pkgs.stdenv.mkDerivation rec {
  pname = "opencode-obsidian";
  version = "0.2.1";

  src = pkgs.fetchFromGitHub {
    owner = "mtymek";
    repo = "opencode-obsidian";
    rev = "v${version}";
    hash = "sha256-gX9PCzuXi0vkiQzmnJrhPG/aedExPOvsVAXFUERIo0c=";
  };

  dontBuild = true;
  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out
    cp $src/manifest.json $out/manifest.json
    cp $src/styles.css $out/styles.css
    cp ${mainjs} $out/main.js
  '';
}
