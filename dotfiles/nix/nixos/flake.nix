{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

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
    in
    {
      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
        x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.nixpkgs-fmt;
        aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixpkgs-fmt;
        aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
      };
      nixosConfigurations = {
        Alan-NixOS-SteamDeck = nixosSystem "x86_64-linux" [
          jovian-nixos.nixosModules.default
          ./machines/steamdeck.nix
        ];
        Alan-NixOS-MacBookPro = nixosSystem "x86_64-linux" [
          ./machines/macbookpro.nix
        ];
      };
    };
}
