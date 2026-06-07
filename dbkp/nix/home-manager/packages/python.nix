pkgs:

with pkgs; (python314.withPackages (p: with p; [
  argcomplete
  autopep8
  black
  flake8
  git-filter-repo
  ipython
  isort
  matplotlib
  neovim
  numpy
  pip
  pygobject-stubs
  pygobject3
  pyyaml
  scipy
  sympy
  twine
  wheel
]))
