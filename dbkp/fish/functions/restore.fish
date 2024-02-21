function restore
  block -l

  argparse p/public -- $argv

  if not test -d ~/Developer/GitHub/dotfiles
    mkdir ~/Developer/GitHub
    git clone --recurse-submodule https://github.com/acristoffers/dotfiles ~/Developer/GitHub/dotfiles
  else
    pushd ~/Developer/GitHub/dotfiles
    git reset --hard HEAD
    git pull
    or begin
      echo Error updating with git in dotfiles
      exit 1
    end
    popd
  end

  dbkp restore ~/Developer/GitHub/dotfiles/dbkp.toml

  if test -n "$_flag_public"
    exit 0
  end

  if not test -d ~/Developer/GitHub/dotfiles-secrets
    mkdir ~/Developer/GitHub
    git clone --recurse-submodule https://github.com/acristoffers/dotfiles-secrets ~/Developer/GitHub/dotfiles-secrets
  else
    pushd ~/Developer/GitHub/dotfiles-secrets
    git reset --hard HEAD
    git pull
    or begin
      echo Error updating with git in dotfiles-secrets
      exit 1
    end
    popd
  end

  dbkp restore ~/Developer/GitHub/dotfiles-secrets/dbkp.toml
end
