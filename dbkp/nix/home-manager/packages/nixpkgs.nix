pkgs:

with pkgs; [
  (nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "Inconsolata" ]; })
  (pkgs.lowPrio coreutils-full) # only use the ones uutils doesn't have yet
  any-nix-shell
  bibtool
  blesh
  cacert
  cowsay
  curl
  dogdns
  du-dust
  duf
  elmPackages.elm
  elmPackages.elm-format
  elmPackages.elm-json
  elmPackages.elm-live
  emacs-all-the-icons-fonts
  emacs29-pgtk
  emacsPackages.cask
  epstool
  fastfetch
  fd
  ffmpeg
  file
  findutils
  fish
  fishPlugins.fzf-fish
  fishPlugins.puffer
  gawk
  gh
  ghostscript
  git
  git-lfs
  glab
  gnome-extensions-cli
  gnome-sound-recorder
  gnugrep
  gnumake
  gnupg
  gnused
  gnutar
  go
  gspell
  hjson # accepts broken json
  hledger
  htop
  hunspell
  imagemagick
  inkscape
  ispell
  jq
  killall
  ledger
  less
  man-pages
  mdcat
  mediainfo
  moreutils
  nix-index
  nixVersions.latest
  nixpkgs-fmt
  nodePackages_latest.sass
  nodePackages_latest.yarn
  nodejs_22
  openssl
  p7zip
  pandoc
  peaclock
  poetry
  pstree
  rage
  renameutils
  ripgrep
  rsync
  rustup
  shellcheck
  shfmt
  starship
  taplo
  termdown
  texlab
  tmux
  tokei # counts code lines
  tree
  tridactyl-native
  uglify-js
  unzip
  uutils-coreutils-noprefix
  watch
  wget
  which
  yamlfmt
  yq # for a tmux plugin
  zip
  zlib
]
