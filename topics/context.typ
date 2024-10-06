#import "../utils.typ": *

#polylux-slide[
  == What is Nix?

  - just a programming language
  - functional
  - turing complete
  - made to configure environments
  #pdfpc.speaker-note(```md Notes here```)
]

#polylux-slide[
  == Definitions

  #columns(
    2,
    [
      #enum-one-by-one(mode: "transparent")[
        Nix: the package manager
      ][
        NixDSL: the programming language
      ][
        Nixpkgs: the Repository
      ][
        NixOS: the Linux Distribution
      ]
      #colbreak()
      #image("../figures/nix-three.png")
    ],
  )
  #pdfpc.speaker-note(```md Notes here```)
]
