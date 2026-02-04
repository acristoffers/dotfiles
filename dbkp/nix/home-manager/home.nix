{ config, inputs, pkgs, username, ... }:

let
  homeDirectory = "/home/${username}";
in
{
  nix.package = pkgs.nixVersions.latest;

  nix.settings = {
    extra-substituters = [ "https://ghostty.cachix.org" ];
    extra-trusted-public-keys = [ "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns=" ];
  };
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

  programs.home-manager.enable = true;
  news.display = "silent";
  news.json = pkgs.lib.mkForce { };
  news.entries = pkgs.lib.mkForce [ ];

  home.stateVersion = "22.11";
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.packages = import ./packages/common.nix {
    inherit inputs;
    inherit pkgs;
  };
  fonts.fontconfig.enable = true;

  home.file = {
    "${config.xdg.configHome}/btop/themes/catppuccin.theme".source = ./dotfiles/btop/themes/catppuccin.theme;
    "${config.xdg.configHome}/doom".source = ./dotfiles/doom;
    "${config.xdg.configHome}/gemrc".source = ./dotfiles/gemrc;
    "${config.xdg.configHome}/ghostty".source = ./dotfiles/ghostty;
    "${config.xdg.configHome}/git/config".source = ./dotfiles/git/config;
    "${config.xdg.configHome}/git/gitconfig.vitibot".source = ./dotfiles/git/gitconfig.vitibot;
    "${config.xdg.configHome}/git/ignore".source = ./dotfiles/git/ignore;
    "${config.xdg.configHome}/latexindent".source = ./dotfiles/latexindent;
    "${config.xdg.configHome}/npm".source = ./dotfiles/npm;
    "${config.xdg.configHome}/tmux".source = ./dotfiles/tmux;
    "${config.xdg.configHome}/tridactyl".source = ./dotfiles/tridactyl;
    "${homeDirectory}/.XCompose".source = ./dotfiles/XCompose;
  };

  programs = {
    bash = import ./programs/bash.nix { inherit config; inherit pkgs; };
    bat = import ./programs/bat.nix { inherit config; inherit pkgs; };
    btop = import ./programs/btop.nix { inherit config; inherit pkgs; };
    dircolors = import ./programs/dircolors.nix { inherit config; inherit pkgs; };
    eza = import ./programs/exa.nix { inherit config; inherit pkgs; };
    fzf = import ./programs/fzf.nix { inherit config; inherit pkgs; };
    kitty = import ./programs/kitty.nix { inherit config; inherit pkgs; };
    lazygit = import ./programs/lazygit.nix { inherit config; inherit pkgs; };
    nushell = import ./programs/nushell.nix { inherit config; inherit pkgs; inherit inputs; };
    tealdeer = import ./programs/tealdeer.nix { inherit config; inherit pkgs; };
    zoxide = import ./programs/zoxide.nix { inherit config; inherit pkgs; };
    zsh = import ./programs/zsh.nix { inherit config; inherit pkgs; };
    wezterm = import ./programs/wezterm.nix { inherit config; inherit pkgs; };
  };

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

  qt.enable = true;
  qt.platformTheme.name = "qtct";

  gtk = {
    enable = true;
    theme.name = "Adwaita";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-key-theme-name = "Emacs";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  systemd.user = {
    services."dropbox-client" = {
      Unit = {
        Description = "Dropbox client";
        After = [ "local-fs.target" "network.target" "graphical-session.target" ];
        Requires = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.flatpak}/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/dropbox com.dropbox.Client start";
      };
    };

    timers."dropbox-client" = {
      Unit = {
        Description = "Run dropbox-client every 10 minutes (graphical session only)";
      };
      Timer = {
        OnBootSec = "5min";
        OnUnitActiveSec = "10min";
        Unit = "dropbox-client.service";
        Persistent = true;
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };
}
