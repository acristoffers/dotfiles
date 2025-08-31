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
    desktopManager.plasma6.enable = mkForce false;
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
    kdePackages.kconfig
    kdePackages.kconfigwidgets
    kdePackages.kdeclarative
    kdePackages.kirigami-addons
    kdePackages.plasma-workspace
    kdePackages.qtvirtualkeyboard
    libsForQt5.kirigami2
    libsForQt5.plasma-framework
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
