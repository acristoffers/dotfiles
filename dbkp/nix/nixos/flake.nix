{
  description = "My NixOS Configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";

    cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    cosmic.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, flake-utils, jovian, cosmic, ... }:
    let
      nixosSystem = system: modules: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = modules ++ [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          cosmic.nixosModules.default
        ];
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
