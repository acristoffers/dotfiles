function restore
  block -l

  argparse p/public -- $argv

  if not test -d ~/Developer/GitHub/dotfiles
    mkdir ~/Developer/GitHub
    git clone --recurse-submodule https://github.com/acristoffers/dotfiles ~/Developer/GitHub/dotfiles
  else
    pushd ~/Developer/GitHub/dotfiles
    git pull
    popd
  end

  dbkp restore ~/Developer/GitHub/dotfiles/dbkp.toml

  if test -z "$_flag_public"
    if not test -d ~/Developer/GitHub/dotfiles-secrets
      mkdir ~/Developer/GitHub
      git clone --recurse-submodule https://github.com/acristoffers/dotfiles-secrets ~/Developer/GitHub/dotfiles-secrets
      or begin
        echo Error updating with git
        exit 1
      end
    else
      pushd ~/Developer/GitHub/dotfiles-secrets
      git pull
      or begin
        echo Error updating with git
        exit 1
      end
      popd
    end

    dbkp restore ~/Developer/GitHub/dotfiles-secrets/dbkp.toml
  end
end
