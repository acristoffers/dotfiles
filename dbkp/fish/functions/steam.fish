function steam --description 'Run steam-bwrap found under /nix/store, resolved lazily'
    set -l bin (fd steam-bwrap /nix/store | rg -v drv | head -n 1)
    if test -z "$bin"
        echo "steam-bwrap not found under /nix/store" >&2
        return 1
    end
    eval $bin $argv
end
