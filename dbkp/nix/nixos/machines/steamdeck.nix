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
    displayManager.gdm.enable = mkForce false;
  };

  services.displayManager = {
    defaultSession = "gamescope-wayland";
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
    steam-unwrapped
    steamdeck-firmware
  ];

  nix.settings.extra-trusted-substituters = [ "ssh://alan@Alan-NixOS-Elemental.local" ];

  # Remote build
  nix.distributedBuilds = true;
  nix.buildMachines = [{
    hostName = "Alan-NixOS-Elemental";
    system = "x86_64-linux";
    protocol = "ssh-ng";
    maxJobs = 12;
    speedFactor = 2;
    supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    mandatoryFeatures = [ ];
  }];
  # optional, useful when the builder has a faster internet connection than yours
  nix.extraOptions = "builders-use-substitutes = true";
  programs.ssh.extraConfig = ''
    Host Alan-NixOS-Elemental
    HostName Alan-NixOS-Elemental.local
    Port 22
    User alan
    IdentitiesOnly yes
    IdentityFile /root/.ssh/nixos-builder
  '';
}
