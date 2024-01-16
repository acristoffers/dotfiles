function backup
    block -l
    pushd ~/Developer/GitHub/dotfiles || exit
    dbkp backup dbkp.json
    git submodule update --remote --merge
    git add -A .
    git commit -m (date)
    git push
    popd

    pushd ~/Developer/GitHub/dotfiles-secrets || exit
    dbkp backup dbkp.json
    git submodule update --remote --merge
    git add -A .
    git commit -m (date)
    git push
    popd
end
