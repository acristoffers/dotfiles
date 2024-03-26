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
  (flakePackage moirai "default")
  (flakePackage nvim "default")
  (flakePackage remove-trash "default")
  (flakePackage void "default")
  (flakePackage webots "default")
])
