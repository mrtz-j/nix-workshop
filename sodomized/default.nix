{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation {
  pname = "sodomized";
  version = "0.1.0";
  src = ./.;

  buildInputs = [ pkgs.neo-cowsay
  pkgs.lolcat
  pkgs.fortune
  ];

    installPhase = ''
    mkdir -p $out/bin
    # Create a script that runs the desired command
    echo '#!/bin/sh' > $out/bin/run-fortune-cowsay
    echo 'fortune | cowsay -f sodomized | lolcat' >> $out/bin/run-fortune-cowsay
    chmod +x $out/bin/run-fortune-cowsay
  '';

}
