{ pkgs, inputs }:

let
  flakePackage = flake: pkgName:
    if flake.packages ? ${pkgs.system} then
      flake.packages.${pkgs.system}.${pkgName}
    else
      null;
in
with inputs; builtins.filter (x: x != null) ([
  (flakePackage bib-converter "default")
  (flakePackage dbkp "default")
  (flakePackage nvim "default")
  (flakePackage remove-trash "default")
  (flakePackage tmux-tui "default")
  (flakePackage void "default")
  (flakePackage ghostty "ghostty-releasefast")
])
