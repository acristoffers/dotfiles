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
  (flakePackage cgen "default")
  (flakePackage dbkp "default")
  (flakePackage ghostty "default")
  (flakePackage nixgl "nixGLIntel")
  (flakePackage nvim "default")
  (flakePackage remove-trash "default")
  (flakePackage tmux-tui "default")
  (flakePackage void "default")
])
