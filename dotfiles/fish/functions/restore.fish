function restore
    block -l

    if not test -d ~/Developer/GitHub/dotfiles
        mkdir ~/Developer/GitHub
        git clone --recurse-submodule https://github.com/acristoffers/dotfiles ~/Developer/GitHub/dotfiles
    else
        pushd ~/Developer/GitHub/dotfiles
        git pull
        git submodule update --remote --merge
        popd
    end

    dbkp restore ~/Developer/GitHub/dotfiles/dbkp.json

    if not test -d ~/Developer/GitHub/dotfiles-secrets
        mkdir ~/Developer/GitHub
        git clone --recurse-submodule https://github.com/acristoffers/dotfiles-secrets ~/Developer/GitHub/dotfiles-secrets
    else
        pushd ~/Developer/GitHub/dotfiles-secrets
        git pull
        git submodule update --remote --merge
        popd
    end

    dbkp restore ~/Developer/GitHub/dotfiles-secrets/dbkp.json
end
