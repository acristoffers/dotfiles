function set-vars
  set -Ux LANG en_US.UTF-8
  set -Ux LC_CTYPE en_US.UTF-8
  set -Ux LC_NUMERIC pt_BR.UTF-8
  set -Ux LC_TIME pt_BR.UTF-8
  set -Ux LC_COLLATE pt_BR.UTF-8
  set -Ux LC_MONETARY fr_FR.UTF-8
  set -Ux LC_MESSAGES en_US.UTF-8
  set -Ux LC_PAPER pt_BR.UTF-8
  set -Ux LC_NAME fr_FR.UTF-8
  set -Ux LC_ADDRESS fr_FR.UTF-8
  set -Ux LC_TELEPHONE fr_FR.UTF-8
  set -Ux LC_MEASUREMENT fr_FR.UTF-8
  set -Ux LC_IDENTIFICATION fr_FR.UTF-8
  set -e LC_ALL

  set -Ux fish_greeting ""
  set -Ux LSCOLORS gxfxcxdxbxeggdbgagacad

  if not set -q IN_NIX_SHELL; or set -q FULL_NIX_SHELL
    if not set -q FULL_NIX_SHELL
      set -Ux PATH /bin
      set -Ux PKG_CONFIG_PATH $PKG_CONFIG_PATH ~/.nix-profile/share/pkgconfig ~/.nix-profile/lib/pkgconfig
    end

    fix-path
    add-to-path-if-exists /run/wrappers/bin
    add-to-path-if-exists /nix/var/nix/profiles/default/bin
    add-to-path-if-exists /run/current-system/sw/bin
    add-to-path-if-exists $HOME/.nix-profile/bin

    set -Ux XDG_CACHE_HOME $HOME/.cache
    set -Ux XDG_CONFIG_HOME $HOME/.config
    set -Ux XDG_DATA_HOME $HOME/.local/share
    set -Ux XDG_STATE_HOME $HOME/.local/state
    set -Ux GOPATH "$XDG_DATA_HOME"/go
    set -Ux GOMODCACHE "$XDG_CACHE_HOME"/go/mod
    set -Ux EDITOR (readlink -f (which nvim))
    set -Ux PYTHON (which python3)
    set -Ux JULIA_NUM_THREADS 8
    set -Ux FZF_DEFAULT_COMMAND 'ag --hidden -g "" .'
    set -Ux FZF_FIND_FILE_COMMAND 'ag --hidden -g "" $dir'
    set -Ux FZF_LEGACY_KEYBINDINGS 0
    set -Ux MANPAGER "$(which less) -R --use-color -Ddg -Du+y"
    set -Ux DOOMPAGER $MANPAGER
    set -Ux CARGO_HOME "$XDG_DATA_HOME"/cargo
    set -Ux GNUPGHOME "$XDG_DATA_HOME"/gnupg
    set -Ux NIXPKGS_ALLOW_UNFREE 1
    set -Ux PIP_PREFIX $HOME/.local/share/pip
    set -Ux PYTHONPATH $HOME/.local/share/pip/lib/python3.11/site-packages
    set -Ux XDG_DATA_DIRS $HOME/.nix-profile/share:$HOME/.local/share:$XDG_DATA_DIRS
    set -Ux MAILDIR $HOME/.local/share/mail
    set -Ux _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
    set -Ux JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME"/jupyter
    set -Ux JUPYTER_PLATFORM_DIRS 1
    set -Ux NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
    set -Ux RUSTUP_HOME "$XDG_DATA_HOME"/rustup
    set -Ux VIMINIT 'let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
    set -Ux LIBVIRT_DEFAULT_URI "qemu:///system"
    set -Ux MLSP_PATH "$HOME/Documents/MATLAB/Toolboxes/mosek-10/toolbox/r2017a:$HOME/Documents/MATLAB/Bin:$HOME/Documents/MATLAB:$HOME/Documents/MATLAB/Toolboxes/cvx/builtins:$HOME/Documents/MATLAB/Toolboxes/cvx/commands:$HOME/Documents/MATLAB/Toolboxes/cvx/functions:$HOME/Documents/MATLAB/Toolboxes/cvx/lib:$HOME/Documents/MATLAB/Toolboxes/cvx/structures:$HOME/Documents/MATLAB/Toolboxes/cvx:$HOME/Documents/MATLAB/Toolboxes/YALMIP:$HOME/Documents/MATLAB/Toolboxes/YALMIP/extras:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/bilevel:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/global:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/moment:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/parametric:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/robust:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/sos:$HOME/Documents/MATLAB/Toolboxes/YALMIP/operators:$HOME/Documents/MATLAB/Toolboxes/YALMIP/solvers:$HOME/Documents/MATLAB/Toolboxes/sedumi/examples:$HOME/Documents/MATLAB/Toolboxes/sedumi/conversion:$HOME/Documents/MATLAB/Toolboxes/sedumi:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/custom:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/dpvar:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal/DP:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal/processing:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal/sosprogramming:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal/sparsityandstructure:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal/symvar:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/multipoly:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/multipoly/doc:$HOME/Documents/MATLAB/Toolboxes/MBeautifier:$HOME/Documents/MATLAB/Toolboxes/matlab-schemer:$HOME/Documents/MATLAB/Toolboxes/latex_library:$HOME/Documents/MATLAB/Toolboxes/export_fig:$HOME/Documents/MATLAB/Toolboxes/matpower/lib:$HOME/Documents/MATLAB/Toolboxes/matpower/lib/t:$HOME/Documents/MATLAB/Toolboxes/matpower/most/lib:$HOME/Documents/MATLAB/Toolboxes/matpower/most/lib/t:$HOME/Documents/MATLAB/Toolboxes/matpower/mp-opt-model/lib:$HOME/Documents/MATLAB/Toolboxes/matpower/mp-opt-model/lib/t:$HOME/Documents/MATLAB/Toolboxes/matpower/mips/lib:$HOME/Documents/MATLAB/Toolboxes/matpower/mips/lib/t:$HOME/Documents/MATLAB/Toolboxes/SDPT3:$HOME/Documents/MATLAB/Toolboxes/SDPT3/Solver:$HOME/Documents/MATLAB/Toolboxes/SDPT3/HSDSolver:$HOME/Documents/MATLAB/Toolboxes/SDPT3/Solver/Mexfun"
    set -Ux LEDGER_FILE ~/.org/finances/(date +%Y).ledger
    set -Ux GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
    set -Ux XCOMPOSEFILE "$XDG_CONFIG_HOME"/X11/xcompose
    set -Ux NIX_PATH nixpkgs=$HOME/.nix-defexpr/channels/nixos

    add-to-path-if-exists $HOME/bin
    add-to-path-if-exists $HOME/.bin
    add-to-path-if-exists $HOME/.local/bin
    add-to-path-if-exists $HOME/.config/yarn/global/node_modules/.bin
    add-to-path-if-exists $XDG_DATA_HOME/cargo/bin
    add-to-path-if-exists $HOME/.pub-cache/bin
    add-to-path-if-exists $HOME/.config/emacs/bin
    add-to-path-if-exists $XDG_DATA_HOME/npm/bin
    add-to-path-if-exists "$HOME/.local/share/gem/ruby/*/bin"
    add-to-path-if-exists $HOME/.luarocks/bin
    add-to-path-if-exists $HOME/.cabal/bin
    add-to-path-if-exists $HOME/.bin/languagetool/5.5/bin
    add-to-path-if-exists $PIP_PREFIX/bin
    add-to-path-if-exists $GOPATH/bin

    for p in $LD_LIBRARY_EXTRA_PATH
      set -Ux LD_LIBRARY_PATH $LD_LIBRARY_PATH $p
    end

    # Prevents messages about degraded session in home-manager
    systemctl --user reset-failed

    any-nix-shell fish | source
    zoxide init fish --cmd j | source
  else
    set -l OLD_PATH $PATH
    set -x PATH /bin

    fix-path

    for p in $OLD_PATH
      if string match -rq "^/nix/store*" $p
        set -p PATH $p
      end
    end

    if test (uname -s) = Linux
      set -x LOCALE_ARCHIVE /usr/lib/locale/locale-archive
    end

    set -e LOCALE_ARCHIVE
  end

  fix-path-wrappers
  vardedup PATH XDG_DATA_DIRS LD_LIBRARY_PATH PKG_CONFIG_PATH fish_complete_path fish_user_paths
end
