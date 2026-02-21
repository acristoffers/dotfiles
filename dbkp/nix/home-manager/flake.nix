{
  description = "Álan's Home Manager configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    # nixpkgs.url = "github:NixOS/nixpkgs";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    # home-manager.url = "github:nix-community/home-manager/master";
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

    cgen.url = "github:acristoffers/cgen";
    cgen.inputs.nixpkgs.follows = "nixpkgs";
    cgen.inputs.flake-utils.follows = "flake-utils";

    dbkp.url = "github:acristoffers/dbkp";
    dbkp.inputs.nixpkgs.follows = "nixpkgs";
    dbkp.inputs.flake-utils.follows = "flake-utils";

    bib-converter.url = "github:acristoffers/bib-converter";
    bib-converter.inputs.nixpkgs.follows = "nixpkgs";
    bib-converter.inputs.flake-utils.follows = "flake-utils";

    tmux-tui.url = "github:acristoffers/tmux-tui";
    tmux-tui.inputs.nixpkgs.follows = "nixpkgs";
    tmux-tui.inputs.flake-utils.follows = "flake-utils";

    nixgl.url = "github:nix-community/nixGL";
    ghostty.url = "github:ghostty-org/ghostty";

    nu-scripts.url = "github:nushell/nu_scripts";
    nu-scripts.flake = false;

    dms.url = "github:AvengeMedia/DankMaterialShell/stable";
    dms.inputs.nixpkgs.follows = "nixpkgs";

    hyprland-guiutils.url = "github:hyprwm/hyprland-guiutils";
    hyprland-guiutils.inputs.nixpkgs.follows = "nixpkgs";

    dms-plugins.url = "github:AvengeMedia/dms-plugins";
    dms-plugins.flake = false;

    dms-emoji-launcher.url = "github:devnullvoid/dms-emoji-launcher";
    dms-emoji-launcher.flake = false;

    dms-world-clock.url = "github:rochacbruno/WorldClock";
    dms-world-clock.flake = false;

    dms-grimblast.url = "github:TaylanTatli/dms-plugins";
    dms-grimblast.flake = false;
  };

  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        homeConfigForUser =
          username:
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              inputs.dms.homeModules.dank-material-shell
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
