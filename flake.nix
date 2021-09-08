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

          buildInputs = with pkgs; [ zlib ];
          nativeBuildInputs = with pkgs; [ pkg-config ninja meson ];
        };
        defaultPackage = packages.libspng;

        checks.libspng = pkgs.stdenv.mkDerivation {
          pname = "libspng";
          name = "libspng";
          src = libspng-src;

          doCheck = true;

          mesonBuildType = "release";

          mesonFlags = [
            # this is required to enable testing
            # https://github.com/randy408/libspng/blob/bc383951e9a6e04dbc0766f6737e873e0eedb40b/tests/README.md#testing
            "-Ddev_build=true"
          ];

          outputs = [ "out" "dev" ];

          checkInputs = with pkgs; [ cmake libpng ];
          buildInputs = with pkgs; [ pkg-config zlib ];
          nativeBuildInputs = with pkgs; [ ninja meson ];
        };

        # `nix develop`
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ pkg-config zlib meson ninja cmake ];
        };
      });
}
