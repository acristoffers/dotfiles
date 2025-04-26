{
  description = "Manage Python Packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    let
      mkOutputsFor = system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          reqs = with pkgs; [
            cairo
            cmake
            dasel
            libmysqlclient
            ninja
            openblas
            pkg-config
            python3
            suitesparse
            uv
          ];
        in
        {
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
            shellHook = ''
              export UV_PYTHON_DOWNLOADS=never
              export UV_PYTHON=$(which python3)
            '';
          };
        };
    in
    flake-utils.lib.eachDefaultSystem mkOutputsFor;
}
