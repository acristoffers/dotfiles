{ lib, pkgs, ... }:

with lib;
rec {
  imports = [
    ./common.nix
    ../hardware-configuration/steamdeck.nix
  ];

  networking.hostName = "Alan-NixOS-SteamDeck";

  jovian.devices.steamdeck.enable = true;
  jovian.devices.steamdeck.enableSoundSupport = false;
  jovian.steam.enable = true;
  jovian.steam.autoStart = false;
  jovian.steam.user = "alan";
  jovian.steam.desktopSession = "gnome-wayland";

  services.xserver = {
    desktopManager.plasma5.enable = mkForce false;
    displayManager = {
      defaultSession = "gamescope-wayland";
      gdm.enable = mkForce false;
      sddm = {
        enable = mkForce (!jovian.steam.autoStart);
        theme = "breeze";
        wayland.enable = true;
        autoLogin.relogin = false;
        settings = {
          General = {
            InputMethod = "qtvirtualkeyboard";
          };
        };
      };
      autoLogin = {
        enable = true;
        user = "alan";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    jupiter-dock-updater-bin
    libsForQt5.kconfig
    libsForQt5.kconfigwidgets
    libsForQt5.kdeclarative
    libsForQt5.kirigami-addons
    libsForQt5.kirigami2
    libsForQt5.plasma-framework
    libsForQt5.plasma-workspace
    libsForQt5.qt5.qtvirtualkeyboard
    steamPackages.steam
    steamdeck-firmware
  ];

  # Remote build
  nix.distributedBuilds = false;
  nix.buildMachines = [{
    hostName = "builder";
    # if the builder supports building for multiple architectures,
    # replace the previous line by, e.g.,
    # systems = ["x86_64-linux" "aarch64-linux"];
    system = "x86_64-linux";
    protocol = "ssh-ng";
    maxJobs = 8;
    speedFactor = 2;
    supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    mandatoryFeatures = [ ];
    publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUpCV2N4Yi9CbGFxdDFhdU90RStGOFFVV3JVb3RpQzVxQkorVXVFV2RWQ2Igcm9vdEBuaXhvcwo=";
  }];
  # optional, useful when the builder has a faster internet connection than yours
  nix.extraOptions = "builders-use-substitutes = true";
  programs.ssh.extraConfig = ''
    Host builder
    HostName 10.145.25.67
    Port 31022
    User builder
    IdentitiesOnly yes
    IdentityFile /root/.ssh/builder_ed25519
  '';
}
