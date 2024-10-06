{
  # stdenv,
  # lib,
  pkgs,
}:
pkgs.writeShellApplication {
  name = "moo";
  version = "0.0.1";
  runtimeInputs = [ pkgs.cowsay ];
  text = "cowsay moo";
}
