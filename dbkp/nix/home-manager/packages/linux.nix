{ pkgs }:

with pkgs; [
  bibutils
  cloud-utils # for growpart
  dex # Excutes .desktop files
  gnupatch
  libnotify
  lsb-release
  openjdk21
  # texlive.combined.scheme-full
  wl-clipboard
  wl-clipboard-x11
  xdg-ninja
  xdg-utils
]
