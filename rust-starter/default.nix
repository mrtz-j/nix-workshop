{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation {
  pname = "hello-nix-rust";
  version = "0.1.0";
  src = ./.;

  buildInputs = [ pkgs.rustc pkgs.cargo ];

  buildPhase = "cargo build --release";

  installPhase = ''
    mkdir -p $out/bin
    cp target/release/rust_cowsay $out/bin/
  '';
}
