function update-nixos
  title Updating NixOS

  sudo nix-channel --update

  argparse 'd/debug' -- $argv
  argparse 's/switch' -- $argv

  if test -z "$_flag_switch"
    set action boot
  else
    set action switch
  end

  if test -z "$_flag_debug"
    sudo nixos-rebuild $action --upgrade-all --flake ~/.config/nix/nixos#
  else
    sudo nixos-rebuild $action --upgrade-all --flake ~/.config/nix/nixos# --show-trace
  end
end
