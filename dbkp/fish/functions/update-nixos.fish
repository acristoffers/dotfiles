function update-nixos
  title Updating NixOS

  sudo nix-channel --update

  argparse --name=update-nix 'd/debug' -- $argv

  if test -z "$_flag_debug"
    sudo nixos-rebuild switch --upgrade-all --flake ~/.config/nix/nixos#
  else
    sudo nixos-rebuild switch --upgrade-all --flake ~/.config/nix/nixos# --show-trace
  end
end
