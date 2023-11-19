{ config, pkgs }:

{
  enable = true;
  enableCompletion = true;
  historySize = 10000;
  historyFile = "${config.xdg.dataHome}/bash/history";
  sessionVariables = {
    XCOMPOSEFILE = "$${XDG_CONFIG_HOME:=~/.config}/X11/xcompose";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    LD_LIBRARY_PATH = "$LD_LIBRARY_EXTRA_PATH:$LD_LIBRARY_PATH";
    # MOZ_ENABLE_WAYLAND = 1;
  };
}
