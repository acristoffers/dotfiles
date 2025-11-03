function update-nix
  title Updating Nix

  # use this to install
  # nix run home-manager/master -- init --switch ~/.config/nix/home-manager

  argparse 'd/debug' -- $argv

  nix-channel --update
  nix flake update --flake $XDG_CONFIG_HOME/nix/home-manager

  if test (uname -s) = "Darwin"
    darwin-rebuild switch --flake $XDG_CONFIG_HOME/nix/home-manager
  else
    if test -z "$_flag_debug"
      if type -q nom
        home-manager switch --flake $XDG_CONFIG_HOME/nix/home-manager &| nom
      else
        home-manager switch --flake $XDG_CONFIG_HOME/nix/home-manager
      end
    else
      home-manager switch --flake $XDG_CONFIG_HOME/nix/home-manager --show-trace
    end
  end
end
