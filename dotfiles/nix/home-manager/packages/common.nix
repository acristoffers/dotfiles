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

  system = pkgs.system;
  flakes = with inputs; [
    dbkp.packages.${system}.default
    matlab-beautifier.packages.${system}.default
    matlab-lsp.packages.${system}.default
    nvim.packages.${system}.default
    remove-trash.packages.${system}.default
    void.packages.${system}.default
    zig.packages.${system}.master
    zls.packages.${system}.default
  ] ++ (if isLinux then with inputs; [
    moirai.packages.${system}.default
    webots.packages.${system}.default
  ] else [ ]);

  packages = with pkgs;
    [
      (nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "Inconsolata" ]; })
      (pkgs.hiPrio fish-fzf-fix)
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
      kotlin-language-server
      lazygit
      ledger
      less
      lua-language-server
      luarocks
      man-pages
      marksman
      mediainfo
      moreutils
      mysql
      ncurses
      neofetch
      nix
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
      perl5
      pipenv
      poetry
      poppler_utils
      pstree
      python3
      rage
      rebar3
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
      tealdeer # tldr
      termdown
      texlab
      tmatrix
      tmux
      tokei # counts code lines
      tree
      tree-sitter
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
      zlib
    ] ++ dicts ++ flakes ++ (if isLinux then linux else darwin);
in
packages
