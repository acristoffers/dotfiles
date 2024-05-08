{
  description = "Álan's Home Manager configuration";

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

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvim.url = "github:acristoffers/nvim-flake";
    nvim.inputs.nixpkgs.follows = "nixpkgs";
    nvim.inputs.flake-utils.follows = "flake-utils";

    remove-trash.url = "github:acristoffers/remove-trash";
    remove-trash.inputs.nixpkgs.follows = "nixpkgs";
    remove-trash.inputs.flake-utils.follows = "flake-utils";

    void.url = "github:acristoffers/void-rs";
    void.inputs.nixpkgs.follows = "nixpkgs";
    void.inputs.flake-utils.follows = "flake-utils";

    nix-matlab.url = "gitlab:doronbehar/nix-matlab";
    nix-matlab.inputs.nixpkgs.follows = "nixpkgs";

    moirai.url = "github:acristoffers/moirai";
    moirai.inputs.flake-utils.follows = "flake-utils";

    webots.url = "github:acristoffers/webots-flake";
    webots.inputs.nixpkgs.follows = "nixpkgs";
    webots.inputs.flake-utils.follows = "flake-utils";

    dbkp.url = "github:acristoffers/dbkp";
    dbkp.inputs.nixpkgs.follows = "nixpkgs";
    dbkp.inputs.flake-utils.follows = "flake-utils";

    bib-converter.url = "github:acristoffers/bib-converter";
    bib-converter.inputs.nixpkgs.follows = "nixpkgs";
    bib-converter.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import inputs.nixpkgs { inherit system; config.allowUnfree = true; };
      homeConfigForUser = username: inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.chaotic.homeManagerModules.default
          ./home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit username;
        };
      };
    in
    {
      formatter = pkgs.nixpkgs-fmt;
      packages = {
        homeConfigurations = {
          alan = homeConfigForUser "alan";
          lidei = homeConfigForUser "lidei";
        };
      };
    }
  );
}
