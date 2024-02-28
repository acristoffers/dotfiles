function _tide_item_nixshell
  if set -q FULL_NIX_SHELL
    _tide_print_item nix_shell $tide_nix_shell_icon' ' Flake
  else if set -q IN_NIX_SHELL
    _tide_print_item nix_shell $tide_nix_shell_icon' ' $IN_NIX_SHELL
  end
end
