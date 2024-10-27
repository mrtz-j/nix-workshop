# Welcome to the Nix/Nixpkgs/NixOS Workshop!
#
# We are going through a set of examples 
# to see what is possible with Nix.
#
# Good resources to start out with Nix are:
# - https://nix.dev/
# - https://nixos.org/guides/nix-pills/
#
# Reference documentation:
# - https://nixos.org/learn/
#
# ----------------------------------------------------------------------------
#
# This file is written in the Nix language. Nix is more or less 
# "JSON with functions". 
# 
# The Nix language is used to describe how software is built ("derivations").
#
{
  # We use lock files to pin our dependencies.
  sources ? import ./nix,
  system ? builtins.currentSystem,
  # Nixpkgs is a collection of packages ("derivations") written in Nix.
  #
  # There are a lot of packages: https://repology.org/repositories/graphs
  pkgs ? import sources.nixpkgs {
    inherit system;
    config = { };
    overlays = [ ];
  },
  typst-packages ? sources.packages,
  mkTypstDerivation ? import sources.typst-nix { inherit pkgs typst-packages; },
  pre-commit ? (import sources.git-hooks).run {
    src = ./.;
    hooks = {
      statix.enable = true;
      deadnix.enable = false;
      nixfmt-rfc-style.enable = true;
      typos.enable = true;
      typstyle.enable = true;
    };
  },
}:
{
  # Basic packaging of a Typst application.
  slides = mkTypstDerivation {
    name = "nix-workshop";
    src = ./.;
    mainFile = "main.typ";
    outputFile = "main.pdf";
  };
  # Package your build and development environment with shell
  # environments.
  shell = pkgs.mkShell {
    name = "nix-workshop";
    # Common developer tools.
    packages = with pkgs; [
      typst
      typstyle
      tinymist
    ];
    # Hooks to run before the shell is started.
    shellHook = ''
      ${pre-commit.shellHook}
    '';
  };
}
