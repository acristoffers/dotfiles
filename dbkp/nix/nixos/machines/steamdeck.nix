{ lib, pkgs, ... }:

with lib;
rec {
  imports = [
    ./common.nix
    ../hardware-configuration/steamdeck.nix
  ];

  networking.hostName = "Alan-NixOS-SteamDeck";

  boot.loader.systemd-boot.consoleMode = "auto";

  jovian = {
    devices.steamdeck = {
      enable = true;
      enableSoundSupport = false;
    };
    steam = {
      enable = true;
      autoStart = false;
      user = "alan";
      desktopSession = "gnome-wayland";
    };
  };

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
  nix.distributedBuilds = true;
  nix.buildMachines = [{
    hostName = "Alan-NixOS-Elemental";
    system = "x86_64-linux";
    protocol = "ssh-ng";
    maxJobs = 10;
    speedFactor = 2;
    supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    mandatoryFeatures = [ ];
    publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUhrZzFmc2FGdlJlb2dYU0Y0cERFT0UxZ3NxSWRhbEFrL25XajJBbSszaHkgYWxhbkBBbGFuLU5peE9TLUVsZW1lbnRhbAo=";
  }];
  # optional, useful when the builder has a faster internet connection than yours
  nix.extraOptions = "builders-use-substitutes = true";
  programs.ssh.extraConfig = ''
    Host Alan-NixOS-Elemental
    HostName 192.168.0.14
    Port 31022
    User alan
    IdentitiesOnly yes
    IdentityFile /root/.ssh/nixos-builder
  '';
}

