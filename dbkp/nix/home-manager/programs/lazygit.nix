{ config, pkgs }:

{
  enable = true;
  settings = {
    gui = {
      nerdFontsVersion = "3";
    };
    promptToReturnFromSubprocess = false;
  };
}
