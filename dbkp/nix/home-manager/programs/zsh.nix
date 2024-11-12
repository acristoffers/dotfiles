{ config, pkgs }:

{
  enable = true;
  autosuggestion.enable = false;
  syntaxHighlighting.enable = false;
  enableCompletion = false;
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

    zinit snippet OMZP::command-not-found
    zinit snippet OMZP::dnf
    zinit snippet OMZP::git

    zinit light zsh-users/zsh-completions
    zinit light marlonrichert/zsh-autocomplete
    zinit light zsh-users/zsh-autosuggestions
    zinit light zsh-users/zsh-syntax-highlighting
    zinit light Aloxaf/fzf-tab

    autoload -Uz colors && colors

    bindkey -e   # Emacs mode
    bindkey '^p' history-search-backward
    bindkey '^n' history-search-forward
    bindkey '^U' backward-kill-line
    bindkey 'k' kill-whole-line

    zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
    zstyle ':completion:*:git-checkout:*' sort false
    zstyle ':completion:*' fzf-search-display true

    alias ls="eza --group-directories-first --git --icons"
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
    setopt glob_star_short
    setopt menucomplete

    if [[ $- == *i* ]]; then
      eval "$(zoxide init --cmd j zsh)"
      eval "$(starship init zsh)"
    fi

    if [[ -f "$HOME/.cargo/env" ]]; then
      source "$HOME/.cargo/env"
    fi

    return
  '';
}
