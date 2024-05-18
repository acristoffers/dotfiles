{ config, pkgs }:

{
  enable = true;
  autosuggestion.enable = true;
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

      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

      eval "$(fzf --zsh)"
    '';
  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
  plugins = [ ];
  localVariables = {
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    VIMINIT = "let $MYVIMRC = !has(\"nvim\") ? \"$XDG_CONFIG_HOME/vim/vimrc\" : \"$XDG_CONFIG_HOME/nvim/init.lua\" | so $MYVIMRC";
    XCOMPOSEFILE = "$${XDG_CONFIG_HOME:=~/.config}/X11/xcompose";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
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
