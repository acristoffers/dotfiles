{ config, pkgs, isNixOS }:

{
  enable = isNixOS;
  theme = "Dracula";
  font = {
    name = "JetBrainsMonoNL Nerd Font Mono";
    size = 12;
  };
  settings = {
    cursor_blink_interval = 0;
    cursor_shape = "block";
    enable_audio_bell = false;
    hide_window_decorations = true;
    remember_window_size = true;
    scrollback_lines = 10000;
    shell = "tmux";
    update_check_interval = 0;
  };
  shellIntegration = {
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}

