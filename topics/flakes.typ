#import "../utils.typ": *

#polylux-slide[
== Flakes
#v(15pt)

- extension to nixos/homemanager
- removes the issue of hashes
  - enables easy updates of inputs
  - lock file
- technically an "experimental" feature
#pdfpc.speaker-note(```md
    ```)
]

#polylux-slide[
=== Example
#v(15pt)
#sourcecode(```nix
{
  description = "dots";
  inputs = {
      nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { ... }@inputs:
    let
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };
    in {
      nixosConfigurations."something" = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs pkgs;
          mod = ./hardware/something/base_config.nix;
        };
        modules = [ ./hardware/hardware.nix ]
      };
    };
}
```)
#pdfpc.speaker-note(```md
    ```)
]

#polylux-slide[
=== Overrides
#v(15pt)
#sourcecode(```nix
new: old:
{
  packages = old.packages.override {
    package = new.newpackage;
  };
}
```)
#pdfpc.speaker-note(```md
    ```)
]

