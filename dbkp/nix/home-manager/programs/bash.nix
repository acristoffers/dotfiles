{ config, pkgs }:

{
  enable = true;
  enableCompletion = true;
  historySize = 10000;
  historyFile = "${config.xdg.dataHome}/bash/history";
  sessionVariables = {
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    XCOMPOSEFILE = "$${XDG_CONFIG_HOME:=~/.config}/X11/xcompose";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };
  bashrcExtra = ''
    if [[ $- == *i* ]]; then
      bind "\C-w":unix-filename-rubout "\C-q":unix-word-rubout
      source "$(blesh-share)/ble.sh"
      eval "$(starship init bash)"
    fi
  '';
}
