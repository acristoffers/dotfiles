{ config, pkgs }:

{
  enable = true;
  autosuggestion.enable = false;
  syntaxHighlighting.enable = false;
  dotDir = ".config/zsh";
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
  shellAliases = {
    lg = "lazygit";
    scfg = "source ~/.config/zsh/.zshrc";
  };
  initExtraFirst = ''
    umask 077;

    export GNUPGHOME="${config.xdg.dataHome}/gnupg";
    export VIMINIT="let $MYVIMRC = !has(\"nvim\") ? \"$XDG_CONFIG_HOME/vim/vimrc\" : \"$XDG_CONFIG_HOME/nvim/init.lua\" | so $MYVIMRC";
    export XCOMPOSEFILE="${config.xdg.configHome}/X11/xcompose";
    export XDG_CACHE_HOME="${config.xdg.cacheHome}";
    export XDG_CONFIG_HOME="${config.xdg.configHome}";
    export XDG_DATA_HOME="${config.xdg.dataHome}";
    export XDG_STATE_HOME="${config.xdg.stateHome}";

    ssh-add -A &> /dev/null
    unsetopt BEEP

    ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit"
    if [ ! -d "$ZINIT_HOME" ]; then
      git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    fi
    source "''${ZINIT_HOME}/zinit.zsh"

    zinit light romkatv/powerlevel10k
    zinit light dracula/powerlevel10k

    zinit light zsh-users/zsh-autosuggestions
    zinit light zsh-users/zsh-completions
    zinit light zsh-users/zsh-syntax-highlighting
    zinit light Aloxaf/fzf-tab

    zinit snippet OMZP::dnf
    zinit snippet OMZP::fzf
    zinit snippet OMZP::git
    zinit snippet OMZP::command-not-found

    autoload -Uz compinit && compinit
    zinit cdreplay -q

    source "${config.xdg.configHome}/p10k/p10k.zsh"

    bindkey -e # Emacs mode
    bindkey '^p' history-search-backward
    bindkey '^n' history-search-forward

    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

    alias ls="ls --color"
    alias v="nvim"

    HISTSIZE=10000
    HISTFILE="''${XDG_DATA_HOME}/zsh/history"
    SAVEHIST=$HISTSIZE
    HISTDUP=erase
    setopt appendhistory
    setopt share_history
    setopt hist_ignore_space
    setopt hist_ignore_all_dups
    setopt hist_save_no_dups
    setopt hist_ignore_dups
    setopt hist_find_no_dups

    eval "$(fzf --zsh)"
    eval "$(zoxide init --cmd j zsh)"

    if [[ -f "$HOME/.cargo/env" ]]; then
      source "$HOME/.cargo/env"
    fi
  '';
}
