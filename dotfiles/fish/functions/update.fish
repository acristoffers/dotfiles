function update -d "Updates many package managers."
    if test (count $argv) -gt 0
        for command in $argv
            if type -q "update-$command"
                fish -c "update-$command"
            else
                echo $command is not recognized >&2
            end
        end
        return
    end

    command remove-trash ~ >/dev/null &>/dev/null &
    if which cancel &>/dev/null
        cancel -a -x # Deletes cups temp files (it leaves shit around ¬¬)
    end

    update-apt
    update-dnf
    update-flatpak
    update-nix
    update-brew
    update-pip3
    update-tlmgr
    update-rustup
    update-flutter
    update-doom
    # update-nvim

    rm -rf $RUSTUP_HOME
    rustup default stable
    rustup component add rust-analyzer

    if test (date -u +%u) = 1
        nix-collect-garbage -d
    end
end
