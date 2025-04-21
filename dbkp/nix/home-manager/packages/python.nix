pkgs:

with pkgs; (python313.withPackages (p: with p; [
  argcomplete
  autopep8
  black
  flake8
  git-filter-repo
  ipython
  isort
  neovim
  numpy
  pip
  pipx
  pygobject-stubs
  pygobject3
  scipy
  twine
  wheel
]))
