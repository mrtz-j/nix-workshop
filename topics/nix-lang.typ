#import "../utils.typ": *

#polylux-slide[
== What is Nix?
#v(15pt)

- just a programming language
- functional
  - lazy
  - everything is an expression
- turing complete
- made to configure environments
  - native paths
  - tooling for environments -> nixos etc
#pdfpc.speaker-note(```md
    ```)
]

#polylux-slide[
== Basics
#v(15pt)

#columns(2,[
- haskell interactive shell
  - nix repl
- evaluate code in file
  - nix-instantiate
- comments: \-\-
- function: argument:body
  - x: 5 + x
  - one argument only
  - more arguments == currying
#colbreak()
- native types
  - lists
  - attribute set
  - functions
  - numbers, strings, *paths*, etc
- inbuilt functionality
  - import
  - lib.toString
  - std.mkDerivation
])
#pdfpc.speaker-note(```md
    ```)
]

#polylux-slide[
== Tricks
#v(15pt)
#columns(3, [
=== let in
#sourcecode(```nix
let
  func = x: x * 2;
in {
  func 24
}
-- 48
```)
- *only in this scope*
#colbreak()
=== With
#sourcecode(```nix
let
  attrs = {
    x = 10;
    b = 55;
    c = 34;
  };
in with attrs; [
  x
  b
  c
];
```)
#colbreak()
=== inherit
#sourcecode(```nix
let
  x = 1;
  y = 2;
in
{
  inherit x y;
}
```)
- copies the values in let to the scope in the curly brackets
])

#pdfpc.speaker-note(```md
    ```)
]

#polylux-slide[
	== How it works

	#enum-one-by-one(mode: "transparent")[
		Evaluate the Nix code → Package
	][
		Fetch / Compile dependencies
	][
		Fetch / Build the package in a sandbox
	][
		Scan the output for runtime dependencies
	]

	#v(1em)

	#uncover(5)[
		Each package is installed in its own directory

		`/nix/store/{hash}-hello/`
	]

#pdfpc.speaker-note(```md
    ```)
]

#polylux-slide[
== Packages
#v(15pt)
#sourcecode(```nix
{ stdenv
, lib
, pkgs
, fetchFromGitLab
}:

pkgs.python3.pkgs.buildPythonApplication rec {
  pname = "pingpang";
  version = "0.0.1";

  src = fetchFromGitLab {
    domain = "gitlab.globi.org";
    owner = "globi";
    repo = pname;
    rev = version;
    sha256 = "sha.something";
  };

  nativeBuildInputs = with pkgs; [
    cargo
  ];

  buildInputs = with pkgs; [
    gtk
  ];

  meta = with lib; {
    -- homepage, architecture support, help page etc
  };
}
```)
#pdfpc.speaker-note(```md
    ```)
]
// https://nix.dev/tutorials/nix-language


