{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    flake-utils.url = github:numtide/flake-utils;

    jovian-nixos.url = github:Jovian-Experiments/Jovian-NixOS;
    jovian-nixos.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, flake-utils, jovian-nixos, ... }:
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
          jovian-nixos.nixosModules.default
          ./machines/steamdeck.nix
        ];
        Alan-NixOS-Elemental = nixosSystem "x86_64-linux" [
          ./machines/elemental.nix
        ];
      };
    };
}
