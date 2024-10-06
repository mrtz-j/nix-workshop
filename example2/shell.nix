{
  # lib,
  # stdenv,
  pkgs,
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cargo
    rustc
    rustfmt
  ];
}
