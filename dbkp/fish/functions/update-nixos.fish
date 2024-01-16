function update-nixos
    title Updating NixOS

    sudo nix-channel --update

    pushd ~/.config/nix/nixos
    sudo nixos-rebuild switch --upgrade-all --flake .#
    popd
end
