{ pkgs, inputs, isLinux }:

let
  flakePackage = flake: pkgName:
    if flake.packages ? ${pkgs.system} then
      flake.packages.${pkgs.system}.${pkgName}
    else
      null;
in
with inputs; builtins.filter (x: x != null) ([
  (flakePackage dbkp "default")
  (flakePackage matlab-beautifier "default")
  (flakePackage matlab-lsp "default")
  (flakePackage moirai "default")
  (flakePackage nvim "default")
  (flakePackage remove-trash "default")
  (flakePackage void "default")
  (flakePackage webots "default")
  (flakePackage zig "master")
  (flakePackage zls "default")
  (flakePackage zon2nix "default")
])
