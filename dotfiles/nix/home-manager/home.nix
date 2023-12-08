{ config, inputs, pkgs, username, isLinux, ... }:

let
  homeDirectory = if isLinux then "/home/" + username else "/Users/alan";
in
{
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.packages = import ./packages/common.nix {
    inherit inputs;
    inherit isLinux;
    inherit pkgs;
  };
  fonts.fontconfig.enable = true;

  home.file = {
    "${config.xdg.configHome}/doom".source = ./dotfiles/doom;
    "${config.xdg.configHome}/gemrc".source = ./dotfiles/gemrc;
    "${config.xdg.configHome}/git/config".source = if isLinux then ./dotfiles/git/config-linux else ./dotfiles/git/config-darwin;
    "${config.xdg.configHome}/hammerspoon".source = ./dotfiles/hammerspoon;
    "${config.xdg.configHome}/helix".source = ./dotfiles/helix;
    "${config.xdg.configHome}/latexindent".source = ./dotfiles/latexindent;
    "${config.xdg.configHome}/npm".source = ./dotfiles/npm;
    "${config.xdg.configHome}/p10k".source = ./dotfiles/p10k;
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
    nushell = import ./programs/nushell.nix { inherit config; inherit pkgs; };
    zoxide = import ./programs/zoxide.nix { inherit config; inherit pkgs; };
    zsh = import ./programs/zsh.nix { inherit config; inherit pkgs; };
    tealdeer = import ./programs/tealdeer.nix { inherit config; inherit pkgs; };
    kitty = import ./programs/kitty.nix { inherit config; inherit pkgs; };
  };

  qt.enable = isLinux;
  qt.platformTheme = "qtct";

  gtk.enable = isLinux;
  gtk.theme.name = "Adwaita-dark";
}
