{ config, pkgs }:

{
  enable = true;
  enableBashIntegration = true;
  enableFishIntegration = false;
  enableZshIntegration = true;
  defaultCommand = "ag --hidden -g '' .";
  fileWidgetCommand = "ag --hidden -g '' $dir";
}
