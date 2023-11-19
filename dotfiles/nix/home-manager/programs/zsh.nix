{ config, pkgs }:

{
  enable = true;
  enableAutosuggestions = true;
  syntaxHighlighting.enable = true;
  dotDir = ".config/zsh";
  oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "fzf"
      "fzf-tab"
      "pip"
      "perl"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
      "dnf"
    ];
    custom = "$XDG_DATA_HOME/oh-my-zsh/custom";
    theme = "powerlevel10k/powerlevel10k";
    extraConfig = ''
      function silent_clone() {
        if [ ! -d "$2" ]; then
          git clone "$1" "$2"
        fi
      }

      export ZSH_CUSTOM="$XDG_DATA_HOME/oh-my-zsh/custom"
      silent_clone https://github.com/romkatv/powerlevel10k.git             $ZSH_CUSTOM/themes/powerlevel10k
      silent_clone https://github.com/dracula/powerlevel10k.git             $ZSH_CUSTOM/themes/dracula-p10k
      silent_clone https://github.com/zsh-users/zsh-autosuggestions.git     $ZSH_CUSTOM/plugins/zsh-autosuggestions
      silent_clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
      silent_clone https://github.com/Aloxaf/fzf-tab.git                    $ZSH_CUSTOM/plugins/fzf-tab
    '';
  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
  plugins = [ ];
  localVariables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CACHE_HOME = "$HOME/.cache";
    VIMINIT = "let $MYVIMRC = !has(\"nvim\") ? \"$XDG_CONFIG_HOME/vim/vimrc\" : \"$XDG_CONFIG_HOME/nvim/init.lua\" | so $MYVIMRC";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_DIRS = "";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    LD_LIBRARY_PATH = "$LD_LIBRARY_EXTRA_PATH:$LD_LIBRARY_PATH";
    # MOZ_ENABLE_WAYLAND = 1;
  };
  shellAliases = {
    ls = "ls --color=auto";
    lg = "lazygit";
    scfg = "source ~/.zshrc";
  };
  initExtraFirst = ''
    umask 077;

    source "${config.xdg.configHome}/p10k/promptline.sh"
    source "${config.xdg.configHome}/p10k/p10k.zsh"

    ssh-add -A &> /dev/null
    unsetopt BEEP

    if [[ -f "$HOME/.cargo/env" ]]; then
      source "$HOME/.cargo/env"
    fi
  '';
}
