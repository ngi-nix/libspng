{
  description = "Simple, modern libpng alternative";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
    libspng-src = {
      url = "github:randy408/libspng";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, libspng-src }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
      in
      rec {
        # `nix build`
        packages.libspng = pkgs.stdenv.mkDerivation {
          pname = "libspng";
          name = "libspng";
          src = libspng-src;

          mesonBuildType = "release";

          outputs = [ "out" "dev" ];
          outputBin = "dev";

          buildInputs = with pkgs; [ zlib ];
          nativeBuildInputs = with pkgs; [ pkg-config ninja meson ];
        };
        defaultPackage = packages.libspng;

        # TODO checks

        # `nix develop`
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ pkg-config zlib meson ninja ];
        };
      });
}
