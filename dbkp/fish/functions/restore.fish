function restore
  block -l

  argparse p/public -- $argv

  if not test -d ~/Developer/GitHub/dotfiles
    mkdir -p ~/Developer/GitHub
    git clone --recurse-submodule https://github.com/acristoffers/dotfiles ~/Developer/GitHub/dotfiles
  else
    pushd ~/Developer/GitHub/dotfiles
    git reset --hard HEAD
    git pull
    or begin
      echo Error updating with git in dotfiles
      return
    end
    popd
  end

  dbkp restore ~/Developer/GitHub/dotfiles/dbkp.toml

  if test -n "$_flag_public"
    return
  end

  if not test -d ~/Developer/GitHub/dotfiles-secrets
    mkdir -p ~/Developer/GitHub
    git clone --recurse-submodule https://github.com/acristoffers/dotfiles-secrets ~/Developer/GitHub/dotfiles-secrets
  else
    pushd ~/Developer/GitHub/dotfiles-secrets
    git reset --hard HEAD
    git pull
    or begin
      echo Error updating with git in dotfiles-secrets
      return
    end
    popd
  end

  dbkp restore ~/Developer/GitHub/dotfiles-secrets/dbkp.toml
end
