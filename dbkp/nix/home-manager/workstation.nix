{ config, pkgs, inputs, username, ... }:

let
  home = "/home/${username}";
  # Mock the activation so I can take only the configuration from DankMaterialShell.
  # This avoids installing applications that would screw the Fedora environment.
  mock = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [
      inputs.dms.homeModules.dank-material-shell
      (
        { ... }: {
          home.username = config.home.username;
          home.homeDirectory = config.home.homeDirectory;
          home.stateVersion = config.home.stateVersion;
          programs = {
            dank-material-shell = import ./programs/danklinuxshell.nix { inherit inputs; inherit config; inherit pkgs; systemd = false; };
          };
        }
      )
    ];
  };
in
{
  home.file = {
    "${home}/.bash_profile".text = ''
      if [ -f ~/.bashrc ]; then
          . ~/.bashrc
      fi
    '';
    "${home}/.bashrc".text = ''
      export EDITOR=nvim
      export PATH=$PATH:/opt/bin:$HOME/.nix-profile/bin:/usr/local/bin:/usr/bin
      [ -f /opt/ros/humble/setup.bash ] && source /opt/ros/humble/setup.bash
      [ -f /opt/ros/jazzy/setup.bash ] && source /opt/ros/jazzy/setup.bash
      [ -d /opt/bin ] && PATH=''${PATH}:/opt/bin
      alias v=nvim

      for file in ~/.local/share/vitibot/bash/completions/*; do
        source "$file"
      done

      source "$(blesh-share)/ble.sh"
      eval "$(starship init bash)"

      eval "$(fzf --bash)"
      source ~/.local/share/fzf-tab-completion/bash/fzf-bash-completion.sh
      [[ $- == *i* ]] && bind -x '"\t": fzf_bash_completion'

      [[ $- == *i* ]] && bind '"\C-x\C-e":edit-and-execute-command'
      [ -f /home/alan/.local/share/vitibot/bash/completions/rosdock.bash ] && source /home/alan/.local/share/vitibot/bash/completions/rosdock.bash
      [ -f /home/alan/.local/share/vitibot/bash/completions/webotdock.bash ] && source /home/alan/.local/share/vitibot/bash/completions/webotdock.bash
      [ -d /home/alan/.local/share/vitibot/bin ] && PATH=/home/alan/.local/share/vitibot/bin:''${PATH}
      [ -f /home/alan/.local/share/vitibot/bash/completions/ros2compose.bash ] && source /home/alan/.local/share/vitibot/bash/completions/ros2compose.bash
    '';
  };

  # Remove target= because nix will append ".config/" to it automatically if it exists, turning
  # ~/.config/path into ~/.config/.config/path
  xdg.stateFile = pkgs.lib.mapAttrs (_: inner: builtins.removeAttrs inner [ "target" ]) mock.config.xdg.stateFile;

  xdg.configFile = {
    "git/allowed_ssh_signers".source = pkgs.lib.mkForce ./dotfiles/git/workstation/allowed_ssh_signers;
    "git/attributes".source = pkgs.lib.mkForce ./dotfiles/git/workstation/attributes;
    "git/gitconfig.workstation".source = pkgs.lib.mkForce ./dotfiles/git/workstation/config;
    "tridactyl".source = pkgs.lib.mkForce ./dotfiles/tridactyl;
    "hypr/conf/host.conf".text = ''
      bind = $mod, S, exec, run-or-raise --launch com.slack.Slack.desktop --class com.slack.Slack
      bind = $mod, R, exec, run-or-raise --launch foxglove-studio.wayland.desktop --class Foxglove
      bind = $mod, T, exec, run-or-raise --launch webots-fhs.desktop --class Webots

      workspace = 1, persistent:true, monitor:HDMI-A-1
      workspace = 2, persistent:true, monitor:HDMI-A-1
      workspace = 3, persistent:true, monitor:HDMI-A-1
      workspace = 4, persistent:true, monitor:DP-3
      workspace = 5, persistent:true, monitor:eDP-1
    '';
  } // pkgs.lib.mapAttrs (_: inner: builtins.removeAttrs inner [ "target" ]) mock.config.xdg.configFile;

  programs = {
    lazygit = pkgs.lib.mkForce (import ./programs/workstation/lazygit.nix { inherit config; inherit pkgs; });
  };

  home.packages = [
    (pkgs.writeShellScriptBin "clang-format-18" ''exec ${pkgs.llvmPackages_18.clang-tools}/bin/clang-format "$@"'')
    pkgs.aria2
    pkgs.aspell
    pkgs.aspellDicts.en
    pkgs.aspellDicts.en-computers
    pkgs.datamash
    pkgs.foxglove-studio
    pkgs.nushellPlugins.formats
    pkgs.poetry
  ];

  xdg.desktopEntries."com.mitchellh.ghostty" = {
    name = "Ghostty";
    type = "Application";
    comment = "A terminal emulator";
    exec = "nixGLIntel ghostty";
    icon = "com.mitchellh.ghostty";
    terminal = false;
    startupNotify = true;
    categories = [ "System" "TerminalEmulator" ];
    settings = {
      Keywords = "terminal;tty;pty;";
      X-GNOME-UsesNotifications = "true";
      X-TerminalArgExec = "-e";
      X-TerminalArgTitle = "--title=";
      X-TerminalArgAppId = "--class=";
      X-TerminalArgDir = "--working-directory=";
      X-TerminalArgHold = "--wait-after-command";
    };
    actions = {
      new-window = {
        name = "New Window";
        exec = "nixGLIntel ghostty";
      };
    };
  };

  xdg.desktopEntries."foxglove-studio.wayland" = {
    name = "Foxglove Studio";
    type = "Application";
    comment = "Integrated robotics visualization and debugging";
    exec = "nixGLIntel foxglove-studio -enable-features=UseOzonePlatform --ozone-platform=wayland %U";
    icon = "foxglove-studio";
    terminal = false;
    startupNotify = true;
    categories = [ "Development" ];
  };
}
