{ inputs, pkgs, isLinux }:

let
  darwin = import ./darwin.nix pkgs;
  dicts = import ./dicts.nix pkgs;
  linux = import ./linux.nix { inherit pkgs; nix-matlab = inputs.nix-matlab; };
  nixpkgs = import ./nixpkgs.nix pkgs;
  perl5 = import ./perl.nix pkgs;
  python3 = import ./python.nix pkgs;
  ruby3 = import ./ruby.nix pkgs;
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
++ nixpkgs
++ flakes
++ [ perl5 python3 ruby3 ]
++ (if isLinux then linux else darwin)
++ [ (pkgs.hiPrio fish-fzf-fix) ]
