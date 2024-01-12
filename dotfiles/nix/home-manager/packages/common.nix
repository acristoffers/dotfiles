{ inputs, pkgs, isLinux }:

let
  darwin = import ./darwin.nix pkgs;
  dicts = import ./dicts.nix pkgs;
  linux = import ./linux.nix { inherit pkgs; nix-matlab = inputs.nix-matlab; };
  perl5 = import ./perl.nix pkgs;
  python3 = import ./python.nix pkgs;
  ruby3 = import ./ruby.nix pkgs;

  fish-fzf-fix = pkgs.stdenv.mkDerivation {
    name = "fish-fzf-fix";
    system = builtins.currentSystem;
    src = ./.;
    postInstall = ''
      mkdir -p $out/share/fish/vendor_conf.d 
      echo "" > $out/share/fish/vendor_conf.d/load-fzf-key-bindings.fish
    '';
  };

  flakePackage = flake: pkgName:
    if flake.packages ? ${pkgs.system} then
      flake.packages.${pkgs.system}.${pkgName}
    else
      null;

  flakes = with inputs; builtins.filter (x: x != null) ([
    (flakePackage dbkp "default")
    (flakePackage matlab-beautifier "default")
    (flakePackage matlab-lsp "default")
    (flakePackage nvim "default")
    (flakePackage remove-trash "default")
    (flakePackage void "default")
    (flakePackage zig "master")
    (flakePackage zls "default")
    (flakePackage zon2nix "default")
  ] ++ (if isLinux then [
    (flakePackage moirai "default")
    (flakePackage webots "default")
  ] else [ ]));

  packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "Inconsolata" ]; })
    (pkgs.hiPrio fish-fzf-fix)
    albert
    any-nix-shell
    bibtool
    bitwarden-cli
    bun
    cacert
    ccls
    clang-tools
    coreutils-full
    cowsay
    curl
    dasel
    dogdns
    du-dust
    elixir
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-json
    elmPackages.elm-live
    emacs-all-the-icons-fonts
    emacs29-gtk3
    emacsPackages.cask
    epstool
    erlang
    fastfetch
    fd
    ffmpeg
    file
    findutils
    fish
    fishPlugins.fzf-fish
    fishPlugins.puffer
    fishPlugins.tide
    gawk
    gdrive
    gh
    ghostscript
    git
    git-lfs
    gnugrep
    gnumake
    gnupg
    gnused
    gnutar
    go
    gobject-introspection
    gradle
    gspell
    helix
    hjson # accepts broken json
    hledger
    hlint
    htop
    hunspell
    imagemagick
    ispell
    jq
    killall
    kotlin-language-server
    lazygit
    ledger
    less
    lua-language-server
    luarocks
    man-pages
    marksman
    mdcat
    mediainfo
    moreutils
    mysql
    ncurses
    nix
    nix-index
    nixpkgs-fmt
    nodePackages_latest.bash-language-server
    nodePackages_latest.js-beautify
    nodePackages_latest.npm-check-updates
    nodePackages_latest.prettier
    nodePackages_latest.sass
    nodePackages_latest.typescript-language-server
    nodePackages_latest.uglify-js
    nodePackages_latest.vim-language-server
    nodePackages_latest.vls
    nodePackages_latest.yarn
    nodejs_20
    ocaml
    ocamlPackages.ocaml-lsp
    opam
    openssl_3
    p7zip
    pandoc
    peaclock
    perl5
    pipenv
    poetry
    poppler_utils
    pstree
    python3
    rage
    rebar3
    renameutils
    ripgrep
    rnix-lsp
    rsync
    ruby3
    rustup
    shellcheck
    shfmt
    silver-searcher
    stylua
    stylua
    taplo
    tectonic
    termdown
    texlab
    tmatrix
    tmux
    tokei # counts code lines
    tree
    tree-sitter
    tridactyl-native
    uncrustify
    unzip
    upx
    vim
    wasmtime
    watch
    wget
    which
    yamlfmt
    youtube-dl
    yq
    zip
    zlib
  ] ++ dicts ++ flakes ++ (if isLinux then linux else darwin);
in
packages
