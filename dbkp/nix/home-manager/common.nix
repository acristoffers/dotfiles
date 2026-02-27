{ config, inputs, pkgs, username, ... }:

rec {
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
  home.homeDirectory = "/home/${username}";
  home.packages = import ./packages/common.nix {
    inherit inputs;
    inherit pkgs;
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  fonts.fontconfig.enable = true;

  home.file = {
    "${home.homeDirectory}/.XCompose".source = ./dotfiles/XCompose;
  };

  xdg.configFile = {
    "btop/themes/catppuccin.theme".source = ./dotfiles/btop/themes/catppuccin.theme;
    "doom".source = ./dotfiles/doom;
    "gemrc".source = ./dotfiles/gemrc;
    "ghostty".source = ./dotfiles/ghostty;
    "git/config".source = ./dotfiles/git/home/config;
    "git/gitconfig.workstation".source = ./dotfiles/git/home/extra-config;
    "git/ignore".source = ./dotfiles/git/home/ignore;
    "latexindent".source = ./dotfiles/latexindent;
    "npm".source = ./dotfiles/npm;
    "tmux".source = ./dotfiles/tmux;
    "tridactyl".source = ./dotfiles/tridactyl;
    "hypr" = { source = ./dotfiles/hyprland; recursive = true; };
    "xdg-desktop-portal/hyprland-portals.conf".source = ./dotfiles/hyprland-portals.conf;
  };

  programs = {
    bat = import ./programs/bat.nix { inherit config; inherit pkgs; };
    btop = import ./programs/btop.nix { inherit config; inherit pkgs; };
    dircolors = import ./programs/dircolors.nix { inherit config; inherit pkgs; };
    eza = import ./programs/exa.nix { inherit config; inherit pkgs; };
    fzf = import ./programs/fzf.nix { inherit config; inherit pkgs; };
    kitty = import ./programs/kitty.nix { inherit config; inherit pkgs; };
    lazygit = import ./programs/lazygit.nix { inherit config; inherit pkgs; };
    nushell = import ./programs/nushell.nix { inherit config; inherit pkgs; };
    tealdeer = import ./programs/tealdeer.nix { inherit config; inherit pkgs; };
    wezterm = import ./programs/wezterm.nix { inherit config; inherit pkgs; };
    zoxide = import ./programs/zoxide.nix { inherit config; inherit pkgs; };
    zsh = import ./programs/zsh.nix { inherit config; inherit pkgs; };
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
      gtk-key-theme-name = "Emacs";
    };
  };

  systemd.user = {
    # services."dropbox-client" = {
    #   Unit = {
    #     Description = "Dropbox client";
    #     After = [ "local-fs.target" "network.target" "graphical-session.target" ];
    #     Requires = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     Type = "oneshot";
    #     ExecStart = "/run/current-system/sw/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/dropbox com.dropbox.Client start";
    #   };
    # };
    #
    # timers."dropbox-client" = {
    #   Unit = {
    #     Description = "Run dropbox-client every 10 minutes (graphical session only)";
    #   };
    #   Timer = {
    #     OnStartupSec = "30sec";
    #     OnCalendar = "*:00/10";
    #     Unit = "dropbox-client.service";
    #     Persistent = true;
    #   };
    #   Install = {
    #     WantedBy = [ "timers.target" ];
    #   };
    # };

    ################################################################################
    ##                                                                            ##
    ##                    Hyprland Systemd Activation Machinery                   ##
    ##                                                                            ##
    ################################################################################

    # hyprland config starts pre-hyprland-session.target
    # pre-hyprland-session.target triggers hyprland-wayland-socket.path
    # hyprland-wayland-socket.path triggers hyprland-ready.service when the socket appears
    # hyprland-ready.service starts hyprland-session.target
    # hyprland-session.target triggers dms.service

    targets."pre-hyprland-session" = {
      Unit = {
        Description = "Hyprland session starting (pre-ready)";
      };
    };

    targets."hyprland-session" = {
      Unit = {
        Description = "Hyprland Session Target";
        Requires = "pre-hyprland-session.target";
        After = "pre-hyprland-session.target";
        Wants = [ "dms.service" ];
      };
    };

    paths."hyprland-wayland-socket" = {
      Unit = {
        Description = "Watch for Wayland socket during Hyprland startup";
        Requires = [ "pre-hyprland-session.target" ];
        After = [ "pre-hyprland-session.target" ];
      };
      Path = {
        PathExistsGlob = "%t/wayland-*";
        Unit = "hyprland-ready.service";
      };
      Install = {
        WantedBy = [ "pre-hyprland-session.target" ];
      };
    };

    services."hyprland-ready" = {
      Unit = {
        Description = "Mark Hyprland session ready once Wayland socket exists";
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "systemctl --user start hyprland-session.target";
      };
    };
  };
}
