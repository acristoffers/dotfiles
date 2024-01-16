pkgs:

with pkgs; (ruby_3_1.withPackages (p: with p; [
  bundler
  neovim
  solargraph
]))
