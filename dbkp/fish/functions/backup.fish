function backup
  block -l

  argparse 'p/public' -- $argv

  pushd ~/Developer/GitHub/dotfiles
  and dbkp backup
  and git add -A .
  and git commit -m (date)
  and git push
  and popd
  or return

  if test -n "$_flag_public"
    pushd ~/Developer/GitHub/dotfiles-secrets
    and dbkp backup
    and git add -A .
    and git commit -m (date)
    and git push
    and popd
    or return
  end
end
