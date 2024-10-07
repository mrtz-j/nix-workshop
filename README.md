# Introduction to Nix 29.10.2024

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

Slides and demos for our nix workshop at UiT.

## Starter

A starter project can be found in the [`starter`](./starter) directory. 

It contains a simple Nix project with a [`default.nix`](./starter/default.nix) and a [`shell.nix`](./starter/shell.nix) file.

## Examples

Can be found in the [`examples`](./examples) directories.

## Build

The slides can be built with:

```bash
nix -Lv build 
```

or interactively with:

```bash
nix -Lv develop --command typst watch main.typ main.pdf
```
