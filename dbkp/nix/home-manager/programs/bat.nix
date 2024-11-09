{ config, pkgs }:
{
  enable = true;
  config = {
    theme = "catppuccin";
  };
  extraPackages = with pkgs.bat-extras; [ /* batdiff */ batman batgrep batwatch batpipe prettybat ];
  themes = {
    dracula = {
      src = pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "sublime"; # Bat uses sublime syntax for its themes
        rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
        sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
      };
      file = "Dracula.tmTheme";
    };
    catppuccin = {
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "d2bbee4f7e7d5bac63c054e4d8eca57954b31471";
        sha256 = "x1yqPCWuoBSx/cI94eA+AWwhiSA42cLNUOFJl7qjhmw=";
      };
      file = "themes/Catppuccin Mocha.tmTheme";
    };
  };
}
