function update-pip3
  if not set -q IN_NIX_SHELL
    title Updating Python
    pushd ~/.config/global-python
    rm flake.lock
    rm result
    set -x FULL_NIX_SHELL
    nix build
    nix develop --command fish -c 'update pip3; exit'
    popd
    return
  end

  if not type -q pip3
    echo "pip3 not found"
    exit 1
  end

  echo Fixing poetry
  rm -rf ~/.local/share/pip
  pip3 install -qq --ignore-installed poetry

  if not type -q poetry
    echo "poetry not found"
    exit 1
  end

  if not test -d ~/.config/global-python
    echo "~/.config/global-python does not exist."
    echo "Create a poetry project with all desired global packages there."
    exit
  end

  pushd ~/.config/global-python
  echo Updating with poetry...
  poetry up --latest -qn
  poetry update --lock -q
  poetry export --without-hashes --format=requirements.txt >requirements.txt
  rm -rf ~/.local/share/pip
  echo ...updating pip...
  pip3 install -qq --ignore-installed --upgrade pip
  pip3 install -qq --ignore-installed -r requirements.txt
  echo ...done!
  popd
end
