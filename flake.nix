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
# This file is a Nix "Flake", a self-contained description of
# software. Everytime it is built it will produce the same output.

{
  inputs = {
    # Nixpkgs is a collection of packages ("derivations") written in Nix.
    #
    # There are a lot of packages: https://repology.org/repositories/graphs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typst-packages = {
      url = "github:typst/packages";
      flake = false;
    };
    typst-nix = {
      url = "github:misterio77/typst-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.typst-packages.follows = "typst-packages";
    };
  };
  # We use lock files to pin our dependencies.

  # ----------------------------------------------------------------------------
  outputs =
    inputs@{
      parts,
      typst-packages,
      typst-nix,
      ...
    }:
    parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.pre-commit-hooks.flakeModule ];
      # Environments we will use.
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        {
          pkgs,
          config,
          system,
          ...
        }:
        {
          pre-commit = {
            check.enable = true;
            settings.hooks = {
              statix.enable = true;
              deadnix.enable = true;
              nixfmt-rfc-style.enable = true;
              typos.enable = true;
              typstyle.enable = true;
            };
          };
          ### Basic packaging of a Typst application.
          packages.slides = typst-nix.lib.${system}.mkTypstDerivation {
            name = "nix-workshop";
            src = ./.;
            mainFile = "main.typ";
            outputFile = "main.pdf";
            typstPackages = {
              preview = "${typst-packages}/packages/preview";
            };
          };
          # Package your build and development environment with shell
          # environments.
          devShells.default = pkgs.mkShell {
            name = "nix-workshop";

            # Common developer tools.
            packages = with pkgs; [
              typst
              typstyle
              tinymist
            ];
            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };
        };
    };
}
