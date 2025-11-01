pkgs:

with pkgs; (ruby.withPackages (p: with p; [
  bundler
  neovim
  solargraph
]))
