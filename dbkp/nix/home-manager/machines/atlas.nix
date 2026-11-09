{ config, pkgs, ... }:

{
  programs = {
    bash = import ../programs/bash.nix {
      inherit config;
      inherit pkgs;
    };
  };

  home.packages = import ../packages/gui.nix pkgs;
}
