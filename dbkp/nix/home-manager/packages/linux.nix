{ pkgs }:

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
]
