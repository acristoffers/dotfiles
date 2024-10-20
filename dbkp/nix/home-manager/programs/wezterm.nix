{ config, pkgs }:

{
  enable = true;
  enableBashIntegration = true;
  enableZshIntegration = true;
  extraConfig = ''
    return {
      audible_bell = "Disabled",
      color_scheme = "Dracula",
      default_prog = { "tmux" },
      enable_tab_bar = false,
      exit_behavior = "Close",
      font = wezterm.font("JetBrainsMonoNL Nerd Font Mono"),
      font_size = 12.0,
      front_end = "WebGpu",
      window_decorations = "RESIZE",
      window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      }
    }
  '';
}
