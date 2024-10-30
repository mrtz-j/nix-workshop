# [29.10.2024] Introduction to Nix 

[![Build and Release](https://github.com/mrtz-j/nix-workshop/actions/workflows/build.yaml/badge.svg)](https://github.com/mrtz-j/nix-workshop/actions/workflows/build.yaml)

Slides and demos for our nix workshop at UiT.

## Starter

A starter project can be found in the [`starter`](./starter) directory. 

It contains a simple Nix project with a [`default.nix`](./starter/default.nix) and a [`shell.nix`](./starter/shell.nix) file.

## Examples

Can be found in the [`examples`](./examples) directories.

## Build

The slides can be built with:

```console
nix -Lv build -f . slides
```

or interactively with:

```console
nix -Lv develop -f . slides --command typst watch main.typ main.pdf
```
