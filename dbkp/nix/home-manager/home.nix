{ config, pkgs, inputs, ... }:

let
  flakePackage = flake: pkgName:
    if flake.packages ? ${pkgs.stdenv.hostPlatform.system} then
      flake.packages.${pkgs.stdenv.hostPlatform.system}.${pkgName}
    else
      null;
in
{
  xdg.configFile."hypr/conf/host.conf".text = ''
    bind = $mod, D, exec, run-or-raise --launch com.discordapp.Discord.desktop --class discord
    bind = $mod, N, exec, run-or-raise --launch org.signal.Signal.desktop --class org.signal.Signal
    bind = $mod, R, exec, run-or-raise --launch org.gnome.Fractal.desktop --class org.gnome.Fractal
    bind = $mod, T, exec, run-or-raise --launch org.telegram.desktop.desktop --class org.telegram.desktop
    bind = $mod, U, exec, run-or-raise --launch org.keepassxc.KeePassXC.desktop --class org.keepassxc.KeePassXC
  '';

  programs = {
    bash = import ./programs/bash.nix { inherit config; inherit pkgs; };
    dank-material-shell = import ./programs/danklinuxshell.nix { inherit inputs; inherit config; inherit pkgs; systemd = true; };
  };

  home.packages = with inputs; [
    (flakePackage ghostty "default")
    (flakePackage hyprland-guiutils "default")
  ];
}
