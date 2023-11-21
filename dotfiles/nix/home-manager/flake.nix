{
  description = "Álan's Home Manager configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    flake-utils.url = github:numtide/flake-utils;

    home-manager.url = github:nix-community/home-manager/master;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = github:lnl7/nix-darwin;
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    zig.url = github:mitchellh/zig-overlay;
    zig.inputs.nixpkgs.follows = "nixpkgs";
    zig.inputs.flake-utils.follows = "flake-utils";

    zls.url = github:acristoffers/zls;
    # zls.inputs.nixpkgs.follows = "nixpkgs";
    # zls.inputs.flake-utils.follows = "flake-utils";
    # zls.inputs.zig-overlay.follows = "zig";

    zon2nix.url = github:nix-community/zon2nix;
    zon2nix.inputs.nixpkgs.follows = "nixpkgs";

    nvim.url = github:acristoffers/nvim-flake;
    nvim.inputs.nixpkgs.follows = "nixpkgs";
    nvim.inputs.flake-utils.follows = "flake-utils";

    remove-trash.url = github:acristoffers/remove-trash;
    remove-trash.inputs.nixpkgs.follows = "nixpkgs";
    remove-trash.inputs.flake-utils.follows = "flake-utils";
    remove-trash.inputs.zig-overlay.follows = "zig";

    void.url = github:acristoffers/void-rs;
    void.inputs.nixpkgs.follows = "nixpkgs";
    void.inputs.flake-utils.follows = "flake-utils";
    void.inputs.naersk.follows = "naersk";

    naersk.url = github:nix-community/naersk;
    naersk.inputs.nixpkgs.follows = "nixpkgs";

    nix-matlab.url = gitlab:doronbehar/nix-matlab;
    nix-matlab.inputs.nixpkgs.follows = "nixpkgs";

    matlab-beautifier.url = github:acristoffers/matlab-beautifier;
    matlab-beautifier.inputs.nixpkgs.follows = "nixpkgs";
    matlab-beautifier.inputs.flake-utils.follows = "flake-utils";
    matlab-beautifier.inputs.naersk.follows = "naersk";

    matlab-lsp.url = github:acristoffers/matlab-lsp;
    matlab-lsp.inputs.nixpkgs.follows = "nixpkgs";
    matlab-lsp.inputs.flake-utils.follows = "flake-utils";
    matlab-lsp.inputs.naersk.follows = "naersk";

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
      homeConfigForUser = username: inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit username; inherit inputs; isLinux = true; };
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
                  username = "alan";
                  inherit inputs;
                  isLinux = false;
                };
              }
            ];
          };
        };
      };
    }
  );
}
