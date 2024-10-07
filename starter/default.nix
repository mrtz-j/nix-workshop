{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation {
  pname = "hello-nix";
  version = "0.1.0";
  src = ./.;

  buildInputs = [ pkgs.gcc ];

  buildPhase = "gcc -o hello hello.c";

  installPhase = ''
    mkdir -p $out/bin
    cp hello $out/bin/
  '';
}
