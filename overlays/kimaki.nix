final: prev:
let
  kimaki = final.callPackage (
    {
      lib,
      fetchFromGitHub,
      bun,
      stdenv,
      makeWrapper,
    }:
    let
      pname = "kimaki";
      version = "0.7.0";
    in
    stdenv.mkDerivation {
      inherit pname version;

      nativeBuildInputs = [ makeWrapper ];

      unpackPhase = "true";
      installPhase = ''
        mkdir -p $out/bin
        makeWrapper ${bun}/bin/bun $out/bin/kimaki \
          --prefix PATH : ${bun}/bin \
          --add-flags "x kimaki@${version}"
      '';

      meta = {
        description = "Discord bot that lets you control OpenCode coding sessions from Discord";
        homepage = "https://kimaki.dev";
        license = lib.licenses.mit;
        platforms = lib.platforms.linux;
      };
    }
  ) { };
in
{
  inherit kimaki;
}
