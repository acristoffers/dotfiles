{ config, pkgs, inputs, flakePackage, ... }:

{
  programs = {
    bash = import ../programs/bash.nix { inherit config; inherit pkgs; };
  };

  home.packages = (with inputs; [
    (flakePackage ghostty "default")
  ]) ++ (import ../packages/gui.nix pkgs);
}
