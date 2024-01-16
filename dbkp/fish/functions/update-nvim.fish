function update-nvim
    if not set -q IN_NIX_SHELL
        pushd ~/.config/global-nvim
        rm flake.lock
        rm result
        set -x FULL_NIX_SHELL true
        nix build
        nix develop --command fish -c 'update nvim; exit'
        popd
        return
    end

    title "Updating Neovim"

    if not type -q nvim
        echo "neovim not installed!"
        exit 1
    end

    if not opam switch | rg -q default
        opam init
    end

    nvim --headless +"TSInstallSync all" +quitall # &>/dev/null
    nvim --headless +"TSUpdateSync"      +quitall # &>/dev/null

    echo "Please quit after the update finishes" | nvim -c Mason
    echo
end
