# Introduction to nix 29.10.2024

Slides and demos for our nix workshop at UiT.

## Demos

Can be found in the `demos` directory.

You will need Nix to run them ;)

## Build

The slides can be built with:

```bash
nix -Lv build 
```

or interactively with:

```bash
nix -Lv develop typst watch main.typ main.pdf
```
