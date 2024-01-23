{ pkgs, nix-matlab }:

let
  matlab = pkgs.buildFHSUserEnv {
    name = "matlab";
    targetPkgs = ps: (nix-matlab.targetPkgs ps ++ [ pkgs.freetype ]);
    runScript = pkgs.writeScript "matlab" (nix-matlab.shellHooksCommon + ''
      exec $MATLAB_INSTALL_DIR/bin/matlab "$@"
    '');
    meta.description = "MATLAB in FHS environment";
  };
in
with pkgs; [
  bibutils
  cloud-utils # for growpart
  dex # Excutes .desktop files
  gnupatch
  gource # version control visualization
  libnotify
  libsForQt5.okular
  lsb-release
  openjdk21
  sirikali
  texlive.combined.scheme-full
  wl-clipboard
  wl-clipboard-x11
  xdg-ninja
  xdg-utils
] ++ (
  if pkgs.lib.hasPrefix "x86_64" pkgs.system then
    [
      (pkgs.hiPrio nix-matlab.packages.${pkgs.system}.matlab-mex)
      matlab
      nix-matlab.packages.${pkgs.system}.matlab-mlint
    ]
  else
    [ ]
)
