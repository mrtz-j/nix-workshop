{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell { buildInputs = with pkgs; [ neo-cowsay lolcat fortune ]; }
