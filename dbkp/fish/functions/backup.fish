function backup
  block -l

  pushd ~/Developer/GitHub/dotfiles
  and dbkp backup
  and git add -A .
  and git commit -m (date)
  and git push
  and popd
  or return

  pushd ~/Developer/GitHub/dotfiles-secrets
  and dbkp backup
  and git add -A .
  and git commit -m (date)
  and git push
  and popd
  or return
end
