{ inputs, pkgs }:

let
  dicts = import ./dicts.nix pkgs;
  linux = import ./linux.nix { inherit pkgs; };
  nixpkgs = import ./nixpkgs.nix pkgs;
  perl5 = import ./perl.nix pkgs;
  python3 = import ./python.nix pkgs;
  ruby3 = import ./ruby.nix pkgs;
  hyprland = import ./hyprland.nix pkgs;
  flakes = import ./flakes.nix { inherit pkgs inputs; };

  fish-fzf-fix = pkgs.stdenv.mkDerivation {
    name = "fish-fzf-fix";
    system = builtins.currentSystem;
    src = ./.;
    postInstall = ''
      mkdir -p $out/share/fish/vendor_conf.d
      echo "" > $out/share/fish/vendor_conf.d/load-fzf-key-bindings.fish
    '';
  };
in
dicts
++ [ (pkgs.lib.hiPrio fish-fzf-fix) ]
++ [ perl5 python3 ruby3 ]
++ flakes
++ hyprland
++ linux
++ nixpkgs
