{ config, pkgs, ... }:

{
  home.file = {
    "${config.xdg.configHome}/git/allowed_ssh_signers".source = pkgs.lib.mkForce ./dotfiles/git/workstation/allowed_ssh_signers;
    "${config.xdg.configHome}/git/attributes".source = pkgs.lib.mkForce ./dotfiles/git/workstation/attributes;
    "${config.xdg.configHome}/git/gitconfig.workstation".source = pkgs.lib.mkForce ./dotfiles/git/workstation/config;
    "${config.xdg.configHome}/tridactyl".source = pkgs.lib.mkForce ./dotfiles/tridactyl;
  };

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
}
