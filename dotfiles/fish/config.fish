umask 077
ulimit -n 2048

fish_config theme choose "Dracula Official"

alias lg    lazygit
alias v     nvim
alias vim   "nvim --noplugin"
alias e     ec
alias tm    "tmux; exit"
alias twine "twine --config-file $XDG_CONFIG_HOME/pypirc"
alias bell  "echo -e '\a'"
alias tree  "ls --tree"
alias clc   "clear" # fuck matlab
alias steam "eval 'fd steam-bwrap /nix/store | rg -v drv'"

abbr ncfg  "nvim ~/.config/nix/home-manager/packages/common.nix"
abbr nfcfg "nvim ~/.config/nix/home-manager/flake.nix"
abbr nhcfg "nvim ~/.config/nix/home-manager/home.nix"
abbr fcfg  "nvim ~/.config/fish/config.fish"
abbr scfg  "source ~/.config/fish/config.fish"
abbr doc   "pushd ~/Documents/Dropbox/Universidade/Doutorado"
abbr docs  "pushd ~/Documents/Dropbox/Documents"

set -x LANG              en_US.UTF-8
set -x LC_CTYPE          en_US.UTF-8
set -x LC_NUMERIC        pt_BR.UTF-8
set -x LC_TIME           pt_BR.UTF-8
set -x LC_COLLATE        pt_BR.UTF-8
set -x LC_MONETARY       fr_FR.UTF-8
set -x LC_MESSAGES       en_US.UTF-8
set -x LC_PAPER          pt_BR.UTF-8
set -x LC_NAME           fr_FR.UTF-8
set -x LC_ADDRESS        fr_FR.UTF-8
set -x LC_TELEPHONE      fr_FR.UTF-8
set -x LC_MEASUREMENT    fr_FR.UTF-8
set -x LC_IDENTIFICATION fr_FR.UTF-8
set -e LC_ALL

set -x fish_greeting ""
set -x LSCOLORS gxfxcxdxbxeggdbgagacad
set -x BAT_THEME Dracula

if not set -q IN_NIX_SHELL; or set -q FULL_NIX_SHELL
    if not set -q FULL_NIX_SHELL
        set -x PATH /bin
        set -a PKG_CONFIG_PATH ~/.nix-profile/share/pkgconfig ~/.nix-profile/lib/pkgconfig
    end

    fix-path
    add-to-path-if-exists /run/wrappers/bin
    add-to-path-if-exists /nix/var/nix/profiles/default/bin
    add-to-path-if-exists /run/current-system/sw/bin
    add-to-path-if-exists $HOME/.nix-profile/bin

    set -x XDG_CACHE_HOME $HOME/.cache
    set -x XDG_CONFIG_HOME $HOME/.config
    set -x XDG_DATA_HOME $HOME/.local/share
    set -x XDG_STATE_HOME $HOME/.local/state
    set -x GOPATH "$XDG_DATA_HOME"/go
    set -x GOMODCACHE "$XDG_CACHE_HOME"/go/mod
    set -x EDITOR (readlink -f (which nvim))
    set -x PYTHON (which python3)
    set -x JULIA_NUM_THREADS 8
    set -x FZF_DEFAULT_COMMAND 'ag --hidden -g "" .'
    set -x FZF_FIND_FILE_COMMAND 'ag --hidden -g "" $dir'
    set -x FZF_LEGACY_KEYBINDINGS 0
    set -x MANPAGER "$(which less) -R --use-color -Ddg -Du+y"
    set -x DOOMPAGER $MANPAGER
    set -x CARGO_HOME "$XDG_DATA_HOME"/cargo
    set -x GNUPGHOME "$XDG_DATA_HOME"/gnupg
    set -x NIXPKGS_ALLOW_UNFREE 1
    set -x PIP_PREFIX $HOME/.local/share/pip
    set -x PYTHONPATH $HOME/.local/share/pip/lib/python3.11/site-packages
    set -x XDG_DATA_DIRS $HOME/.nix-profile/share:$HOME/.local/share:$XDG_DATA_DIRS
    set -x MAILDIR $HOME/.local/share/mail
    set -x _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
    set -x JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME"/jupyter
    set -x JUPYTER_PLATFORM_DIRS 1
    set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
    set -x RUSTUP_HOME "$XDG_DATA_HOME"/rustup
    set -x VIMINIT 'let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
    set -gx MLSP_PATH "$HOME/Documents/MATLAB/Toolboxes/mosek-10/toolbox/r2017a:$HOME/Documents/MATLAB/Bin:$HOME/Documents/MATLAB:$HOME/Documents/MATLAB/Toolboxes/cvx/builtins:$HOME/Documents/MATLAB/Toolboxes/cvx/commands:$HOME/Documents/MATLAB/Toolboxes/cvx/functions:$HOME/Documents/MATLAB/Toolboxes/cvx/lib:$HOME/Documents/MATLAB/Toolboxes/cvx/structures:$HOME/Documents/MATLAB/Toolboxes/cvx:$HOME/Documents/MATLAB/Toolboxes/YALMIP:$HOME/Documents/MATLAB/Toolboxes/YALMIP/extras:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/bilevel:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/global:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/moment:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/parametric:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/robust:$HOME/Documents/MATLAB/Toolboxes/YALMIP/modules/sos:$HOME/Documents/MATLAB/Toolboxes/YALMIP/operators:$HOME/Documents/MATLAB/Toolboxes/YALMIP/solvers:$HOME/Documents/MATLAB/Toolboxes/sedumi/examples:$HOME/Documents/MATLAB/Toolboxes/sedumi/conversion:$HOME/Documents/MATLAB/Toolboxes/sedumi:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/custom:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/dpvar:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal/DP:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal/processing:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal/sosprogramming:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal/sparsityandstructure:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/internal/symvar:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/multipoly:$HOME/Documents/MATLAB/Toolboxes/SOSTOOLS/multipoly/doc:$HOME/Documents/MATLAB/Toolboxes/MBeautifier:$HOME/Documents/MATLAB/Toolboxes/matlab-schemer:$HOME/Documents/MATLAB/Toolboxes/latex_library:$HOME/Documents/MATLAB/Toolboxes/export_fig:$HOME/Documents/MATLAB/Toolboxes/matpower/lib:$HOME/Documents/MATLAB/Toolboxes/matpower/lib/t:$HOME/Documents/MATLAB/Toolboxes/matpower/most/lib:$HOME/Documents/MATLAB/Toolboxes/matpower/most/lib/t:$HOME/Documents/MATLAB/Toolboxes/matpower/mp-opt-model/lib:$HOME/Documents/MATLAB/Toolboxes/matpower/mp-opt-model/lib/t:$HOME/Documents/MATLAB/Toolboxes/matpower/mips/lib:$HOME/Documents/MATLAB/Toolboxes/matpower/mips/lib/t:$HOME/Documents/MATLAB/Toolboxes/SDPT3:$HOME/Documents/MATLAB/Toolboxes/SDPT3/Solver:$HOME/Documents/MATLAB/Toolboxes/SDPT3/HSDSolver:$HOME/Documents/MATLAB/Toolboxes/SDPT3/Solver/Mexfun"

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

    if test (uname -s) = "Darwin"
        config-darwin
    else
        config-linux
    end

    any-nix-shell fish --info-right | source
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

    if test (uname -s) = "Linux"
        set -x LOCALE_ARCHIVE /usr/lib/locale/locale-archive
    end

    set -e LOCALE_ARCHIVE
end

if status --is-interactive; and not set -q IN_NIX_SHELL; and not set -q FULL_NIX_SHELL
    set -e SSH_ASKPASS
end

fix-path-wrappers
vardedup PATH XDG_DATA_DIRS LD_LIBRARY_PATH

bind \es fish_prepend_sudo
bind \cl fish_prepend_clear
bind \cb backward-bigword
bind \cf forward-bigword
bind \cg nextd-or-forward-word
bind \en fish_append_null_redirect
bind \cq "commandline -rt ''"
bind \ek "commandline -r  ''"
bind \er "commandline -rp ''"
bind \ej "commandline -rj ''"

if test -f $XDG_DATA_HOME/secrets.fish
    source $XDG_DATA_HOME/secrets.fish
end

_git_fetch_on_cd
fzf_configure_bindings --directory=\ef
