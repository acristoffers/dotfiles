umask 077
ulimit -n 2048

if status --is-interactive
  fish_config theme choose "Dracula Official"

  abbr doc "pushd ~/Documents/Dropbox/Universidade/Doutorado"
  abbr docs "pushd ~/Documents/Dropbox/Documentos"
  abbr fcfg "nvim ~/.config/fish/config.fish"
  abbr ncfg "nvim ~/.config/nix/home-manager/packages/common.nix"
  abbr nfcfg "nvim ~/.config/nix/home-manager/flake.nix"
  abbr nhcfg "nvim ~/.config/nix/home-manager/home.nix"
  abbr scfg "source ~/.config/fish/config.fish"
  abbr pbpaste "xclip -sel clip -out"

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

  _git_fetch_on_cd
  fzf_configure_bindings --directory=\ef
  ~/.nix-profile/bin/starship init fish | source

  if not set -q IN_NIX_SHELL; and not set -q FULL_NIX_SHELL
    set -e SSH_ASKPASS
  end
end

set -a fish_complete_path $HOME/.nix-profile/share/fish/completions

if test -f $XDG_DATA_HOME/secrets.fish
  source $XDG_DATA_HOME/secrets.fish
end

if not set -q fish_configuring
  fish_configuring=true fish -c set-vars &
end
