{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/0fcb98acb6633445764dafe180e6833eb0f95208.tar.gz") { },
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    zig
    zls
  ];
}
