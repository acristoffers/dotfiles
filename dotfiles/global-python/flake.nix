{
  description = "Manage Python Packages";

  inputs =
    {
      nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
      flake-utils.url = github:numtide/flake-utils;
    };

  outputs =
    inputs@{ self
    , nixpkgs
    , flake-utils
    , ...
    }:
    let
      mkOutputsFor = system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          reqs = with pkgs; [
            cairo
            dasel
            libmysqlclient
            openblas
            pkg-config
            suitesparse
          ];
        in
        rec {
          formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
          packages.default = pkgs.stdenvNoCC.mkDerivation {
            name = "python-dependencies";
            version = "master";
            src = ./.;
            buildInputs = reqs;
            dontConfigure = true;
            dontInstall = true;
            buildPhase = ''
              mkdir -p $out
            '';
          };
          devShell = pkgs.mkShell {
            buildInputs = reqs;
          };
        };
    in
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ] mkOutputsFor;
}

