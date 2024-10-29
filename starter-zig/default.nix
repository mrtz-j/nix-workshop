{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/0fcb98acb6633445764dafe180e6833eb0f95208.tar.gz") { },
}:

pkgs.stdenv.mkDerivation {
  pname = "starter-zig";
  version = "0.1.0";
  src = ./.;

  nativeBuildInputs = [ pkgs.zig ];

  buildPhase = "zig build-exe ./src/main.zig --name starter-zig --cache-dir $TMPDIR/zig-cache --global-cache-dir $TMPDIR/zig-global-cache";

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 starter-zig $out/bin/starter-zig
  '';
}
