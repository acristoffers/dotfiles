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
  dex # Excutes .desktop files
  droidcam
  flutter
  gcc
  gnupatch
  gource # version control visualization
  julia-bin
  jumpapp
  lfs # Better du
  nix-matlab.packages.${pkgs.system}.matlab-mlint
  openjdk19
  python311Packages.jupyter
  speechd
  stdenv.cc.cc.lib
  texlive.combined.scheme-full
  wl-clipboard
  wl-clipboard-x11
  xdg-ninja
  xdg-utils
  xorg.libXtst # For JavaFX
] ++ (
  if pkgs.lib.hasPrefix "x86_64" pkgs.system then
    [
      (pkgs.hiPrio nix-matlab.packages.${pkgs.system}.matlab-mex)
      matlab
    ]
  else
    [ ]
)
