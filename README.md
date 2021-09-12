# libspng

libspng (simple png) is a C library for reading and writing Portable Network
Graphics (PNG) format files with a focus on security and ease of use.

libspng is an alternative to libpng, the projects are separate and the APIs are
not compatible.

To use the library [install nix](https://nixos.org/download.html) and [enable flakes](https://nixos.wiki/wiki/Flakes#Installing_flakes)

To build the library run

```
$ nix build
```

to run the tests

```
$ nix flake check
```

To get a development environment run

```
$ nix develop
```
