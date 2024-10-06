{
  inputs = {
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

  outputs =
    inputs@{
      parts,
      typst-packages,
      typst-nix,
      ...
    }:
    parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.pre-commit-hooks.flakeModule ];
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
          packages.default = typst-nix.lib.${system}.mkTypstDerivation {
            name = "nix-workshop";
            src = ./.;
            mainFile = "main.typ";
            outputFile = "main.pdf";
            typstPackages = {
              preview = "${typst-packages}/packages/preview";
            };
          };
          devShells.default = pkgs.mkShell {
            name = "nix-workshop";
            packages = with pkgs; [
              typst
              typstyle
              tinymist
              typos
            ];
            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };
        };
    };
}
