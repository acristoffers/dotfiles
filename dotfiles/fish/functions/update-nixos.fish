function update-nixos
    title Updating NixOS

    pushd ~/.config/nix/nixos
    sudo nixos-rebuild switch --upgrade-all --flake .#
    popd
end
