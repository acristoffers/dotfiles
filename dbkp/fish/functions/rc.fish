function rc
  if test (uname -s) = "Darwin"
    darwin-rebuild switch --flake $XDG_CONFIG_HOME/home-manager
  else
    home-manager switch --flake $XDG_CONFIG_HOME/nix/home-manager
  end
end
