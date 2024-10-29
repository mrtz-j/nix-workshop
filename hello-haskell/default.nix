{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation {
  pname = "hello-nix-haskell";
  version = "0.1.0";
  src = ./.;

  buildInputs = [ pkgs.ghc ];

  buildPhase = "ghc hello.hs";

  installPhase = ''
    mkdir -p $out/bin
    cp hello $out/bin/
  '';
}
