{ config, pkgs }:

{
  enable = true;
  theme = "Dracula";
  # This way, the configuration files are created, but the binary is not installed, which allows us
  # to use the system installed kitty. This is necessary because on non-NixOS systems you cannot
  # launch OpenGL applications.
  package = pkgs.emptyDirectory;
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

