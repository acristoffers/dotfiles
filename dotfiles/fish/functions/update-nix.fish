function update-nix
    title Updating Nix

    # use this to install
    # nix run home-manager/master -- init --switch ~/.config/nix/home-manager
    # On macOS:
    # nix build ~/.config/nix/home-manager\#darwinConfigurations.recherche75.system
    # ./result/sw/bin/darwin-rebuild switch --flake ~/.config/nix/home-manager

    nix-channel --update
    nix flake update $XDG_CONFIG_HOME/nix/home-manager

    if test (uname -s) = "Darwin"
        darwin-rebuild switch --flake $XDG_CONFIG_HOME/nix/home-manager
    else
        home-manager switch --flake $XDG_CONFIG_HOME/nix/home-manager
    end

    if test (uname -s) = "Darwin" && test -d ~/.nix-profile/Applications
        for alias in (mdfind kMDItemKind="Alias" | grep /Applications)
            rm $alias
        end

        for app in ~/.nix-profile/Applications/*
            osascript -e "tell application \"Finder\" to make alias file to POSIX file \"$app\" at POSIX file \"/Applications\""
        end
    end
end
