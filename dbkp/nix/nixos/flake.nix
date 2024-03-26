{
  description = "My NixOS Configuration";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    flake-utils = {
      follows = "chaotic/flake-utils";
      url = "github:numtide/flake-utils";
    };

    nixpkgs = {
      follows = "chaotic/nixpkgs";
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    jovian = {
      follows = "chaotic/jovian";
      url = "github:Jovian-Experiments/Jovian-NixOS";
    };
  };

  outputs = { nixpkgs, flake-utils, jovian, chaotic, ... }:
    let
      nixosSystem = system: modules: nixpkgs.lib.nixosSystem {
        inherit modules;
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays = (import ./nixpkgs-overlays.nix);
        };
      };

      perSystem = flake-utils.lib.eachDefaultSystem (system:
        let pkgs = import nixpkgs { inherit system; }; in
        { formatter = pkgs.nixpkgs-fmt; });
    in
    {
      formatter = perSystem.formatter;
      nixosConfigurations = {
        Alan-NixOS-SteamDeck = nixosSystem "x86_64-linux" [
          chaotic.nixosModules.default
          jovian.nixosModules.default
          ./machines/steamdeck.nix
        ];
        Alan-NixOS-Elemental = nixosSystem "x86_64-linux" [
          chaotic.nixosModules.default
          ./machines/elemental.nix
        ];
      };
    };
}
