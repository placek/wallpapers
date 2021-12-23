{
  description = "Wallpapers from DT";

  inputs = {
    nixpkgs.url  = "github:NixOS/nixpkgs/9e86f5f7a19db6da2445f07bafa6694b556f9c6d";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs       = import nixpkgs { inherit system; };
      wallpapers = pkgs.stdenv.mkDerivation {
        name         = "wallpapers";
        version      = "test";
        src          = ./.;
        buildInputs  = [];
        buildPhase   = "";
        installPhase = ''
          mkdir -p $out/shared
          cp -r *.jpg $out/shared
        '';
      };
    in rec {
      # defaultApp     = flake-utils.lib.mkApp { drv = defaultPackage; };
      defaultPackage = wallpapers;
      devShell       = pkgs.mkShell { buildInputs = [ wallpapers ]; };
    }
  );
}
