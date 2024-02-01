{
  description = "Álan's Home Manager configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    flake-utils.url = github:numtide/flake-utils;

    home-manager.url = github:nix-community/home-manager/master;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = github:lnl7/nix-darwin;
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nvim.url = github:acristoffers/nvim-flake;
    nvim.inputs.nixpkgs.follows = "nixpkgs";
    nvim.inputs.flake-utils.follows = "flake-utils";

    remove-trash.url = github:acristoffers/remove-trash;
    remove-trash.inputs.nixpkgs.follows = "nixpkgs";
    remove-trash.inputs.flake-utils.follows = "flake-utils";

    void.url = github:acristoffers/void-rs;
    void.inputs.nixpkgs.follows = "nixpkgs";
    void.inputs.flake-utils.follows = "flake-utils";

    nix-matlab.url = gitlab:doronbehar/nix-matlab;
    nix-matlab.inputs.nixpkgs.follows = "nixpkgs";

    moirai.url = github:acristoffers/moirai;
    moirai.inputs.nixpkgs.follows = "nixpkgs";
    moirai.inputs.flake-utils.follows = "flake-utils";

    webots.url = github:acristoffers/webots-flake;
    webots.inputs.nixpkgs.follows = "nixpkgs";
    webots.inputs.flake-utils.follows = "flake-utils";

    dbkp.url = github:acristoffers/dbkp;
    dbkp.inputs.nixpkgs.follows = "nixpkgs";
    dbkp.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import inputs.nixpkgs { inherit system; config.allowUnfree = true; };
      isNixOS = builtins.pathExists "/etc/nixos";
      homeConfigForUser = username: inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit inputs;
          inherit isNixOS;
          inherit username;
          isLinux = true;
        };
      };
    in
    {
      formatter = inputs.nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      packages = {
        homeConfigurations = {
          alan = homeConfigForUser "alan";
          lidei = homeConfigForUser "lidei";
        };
        darwinConfigurations = rec {
          recherche75 = MacBook-Air-de-Alan;
          MacBook-Air-de-Alan = inputs.darwin.lib.darwinSystem {
            inherit pkgs;
            system = "aarch64-darwin";
            modules = [
              ./darwin.nix
              inputs.home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.alan = ./home.nix;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  isLinux = false;
                  isNixOS = false;
                  username = "alan";
                };
              }
            ];
          };
        };
      };
    }
  );
}
