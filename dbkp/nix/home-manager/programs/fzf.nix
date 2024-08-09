{ config, pkgs }:

{
  enable = true;
  enableBashIntegration = true;
  enableFishIntegration = false;
  enableZshIntegration = true;
  defaultCommand = "fd --type f --hidden --exclude .git";
  fileWidgetCommand = "fd --type f --hidden --exclude .git";
}
