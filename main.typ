#import "./utils.typ": *

#set page(paper: "presentation-16-9")
#set text(size: 20pt, font: "DejaVu Sans")

#pdfpc.config(
  default-transition: (
    type: "push", duration-seconds: 0.2, angle: rtl, alignment: "vertical", direction: "outward",
  ),
)
#pdfpc.config(duration-minutes: 20)

#polylux-slide[
  #align(horizon + center)[
    = Introduction to Nix
    #image("./figures/nix-logo.svg", width: 150pt)
    Moritz Jörg | Simen Kirkvik

    29.10.2024
  ]
]

#set page(background: regular_page_design(), footer: default_footer())

#show heading.where(level: 3).or(heading.where(level: 2)): content => [
  #content
  #v(-20pt)
  #line(
    start: (0%, 0%), end: (97%, 0%), stroke: 2pt + gradient.linear(black, white),
  )
]

#polylux-slide[
== Table of Contents
#v(15pt)
- Nix the language
- NixOS
- Home-manager
- Flakes
- Specializations

#pdfpc.speaker-note(```md
- context -> What is nix ? - Why do we even use it? Is it just another linux distro?
    ```)
]

#include "./topics/context.typ"
#include "./topics/nix-lang.typ"
#include "./topics/nixos.typ"
#include "./topics/homemanager.typ"
#include "./topics/flakes.typ"
#include "./topics/specializations.typ"

#let slides = "https://github.com/mrtz-j/nix-workshop"

#polylux-slide[
	== Demos?

	They are here:#footnote(link(slides))

	You need to install Nix on your machine to run them.

	#qrcode(slides, options: (scale: 3.0))
]