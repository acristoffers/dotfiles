pkgs:

with pkgs; (perl.withPackages (p: with p; [
  FileHomeDir
  UnicodeLineBreak
  YAMLTiny
]))
