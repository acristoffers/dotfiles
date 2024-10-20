pkgs:

with pkgs; (python312.withPackages (p: with p; [
  argcomplete
  autopep8
  black-macchiato
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
