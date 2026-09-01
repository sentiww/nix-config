{ pkgs, ... }:
let
  mainjs_url = "https://github.com/TfTHacker/obsidian42-brat/releases/download/2.0.4/main.js";
  mainjs_hash = "sha256-N3ymmpTXRQzodQVzDz9XdpjHwvYlT/SMmD1264zr+qY=";
  mainjs = pkgs.fetchurl {
    url = mainjs_url;
    hash = mainjs_hash;
  };
in
pkgs.stdenv.mkDerivation rec {
  pname = "obsidian42-brat";
  version = "2.0.4";

  src = pkgs.fetchFromGitHub {
    owner = "TfTHacker";
    repo = "obsidian42-brat";
    rev = version;
    hash = "sha256-2a0syztvxAw3kj5t4HRIa/BVZDx9fxWD8iaA6IvecIA=";
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
