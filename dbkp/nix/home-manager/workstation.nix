{ config, pkgs, username, ... }:

let
  home = "/home/${username}";
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

  xdg.configFile = {
    "git/allowed_ssh_signers".source = pkgs.lib.mkForce ./dotfiles/git/workstation/allowed_ssh_signers;
    "git/attributes".source = pkgs.lib.mkForce ./dotfiles/git/workstation/attributes;
    "git/gitconfig.workstation".source = pkgs.lib.mkForce ./dotfiles/git/workstation/config;
    "tridactyl".source = pkgs.lib.mkForce ./dotfiles/tridactyl-workstation;
  };

  programs = {
    lazygit = pkgs.lib.mkForce (import ./programs/workstation/lazygit.nix { inherit config; inherit pkgs; });
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "clang-format-18" ''exec ${llvmPackages_18.clang-tools}/bin/clang-format "$@"'')
    aria2
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    brave
    datamash
    foxglove-studio
    nushellPlugins.formats
    poetry
  ];

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
