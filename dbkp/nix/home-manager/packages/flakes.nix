{ pkgs, inputs }:

let
  flakePackage = flake: pkgName:
    if flake.packages ? ${pkgs.stdenv.hostPlatform.system} then
      flake.packages.${pkgs.stdenv.hostPlatform.system}.${pkgName}
    else
      null;
in
with inputs; builtins.filter (x: x != null) ([
  (flakePackage bib-converter "default")
  (flakePackage cgen "default")
  (flakePackage dbkp "default")
  (flakePackage hyprland-guiutils "default")
  (flakePackage nixgl "nixGLIntel")
  (flakePackage nvim "default")
  (flakePackage remove-trash "default")
  (flakePackage tmux-tui "default")
  (flakePackage void "void-cli")
  (flakePackage void "void-gui")
  (flakePackage wbproto-formatter "default")
])
