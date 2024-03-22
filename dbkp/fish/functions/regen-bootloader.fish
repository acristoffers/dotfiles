function regen-bootloader
    sudo nix-collect-garbage -d
    nix-collect-garbage -d
    sudo nixos-rebuild boot --install-bootloader --flake ~/.config/nix/nixos#
    sudo nix-collect-garbage -d
    nix-collect-garbage -d
end
