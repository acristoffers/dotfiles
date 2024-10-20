{
  description = "My NixOS Configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
  };

  outputs = { nixpkgs, flake-utils, jovian, ... }:
    let
      nixosSystem = system: modules: nixpkgs.lib.nixosSystem {
        inherit modules;
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            packageOverrides = pkgs: {
              vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
            };
          };
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
          jovian.nixosModules.default
          ./machines/steamdeck.nix
        ];
        Alan-NixOS-Elemental = nixosSystem "x86_64-linux" [
          ./machines/elemental.nix
        ];
      };
    };
}
