{ lib, pkgs, ... }:

with lib;
rec {
  # Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" ];

  documentation.man.generateCaches = true;
  documentation.man.man-db.enable = true;

  environment.shells = with pkgs;  [ bashInteractive ];
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GNUPGHOME = "$XDG_DATA_HOME/gnupg";
  };

  fonts.enableDefaultPackages = true;
  fonts.enableGhostscriptFonts = true;
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs;  [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "Inconsolata" ]; })
    dejavu_fonts
    liberation_ttf
    lmmath
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    open-sans
    ubuntu_font_family
  ];

  hardware.bluetooth.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_CTYPE = "en_US.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
    LC_COLLATE = "pt_BR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
  };
  i18n.supportedLocales = [ "all" ];

  location.provider = "geoclue2";

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      appendNameservers = [ "9.9.9.9" "1.1.1.1" ];
    };
    enableIPv6 = false;
    nameservers = networking.networkmanager.appendNameservers;
    firewall = {
      enable = mkForce true;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
    };
  };

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.plasma5.enable = false;
    displayManager.gdm.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=1s
    TimeoutStopSec=1s
  '';

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  # Allows poweroff/reboot for users
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.wrappers = {
    ping = {
      owner = "root";
      group = "root";
      capabilities = "cap_net_raw+ep";
      source = "${pkgs.iputils.out}/bin/ping";
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alan = {
    isNormalUser = true;
    description = "Álan Crístoffer e Sousa";
    extraGroups = [ "libvirtd" "networkmanager" "render" "video" "wheel" ];
    packages = with pkgs; [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cloud-utils
    coreutils-full
    evolution-data-server-gtk4
    gnome3.gnome-tweaks
    gocryptfs
    iputils
    libsForQt5.breeze-icons
    libsForQt5.konsole
    libsForQt5.okular
    libsForQt5.qtstyleplugin-kvantum
    lsb-release
    parted
    plocate
    pulseaudioFull
    sirikali
    wget
    xorg.xhost
  ];

  programs.dconf.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };
  programs.bash.enableCompletion = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.htop.enable = true;
  programs.less.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.enable = true;
  programs.xwayland.enable = true;
  programs.virt-manager.enable = true;

  qt.enable = true;
  qt.platformTheme = "qt5ct";

  # List services that you want to enable:

  services.avahi.enable = true;
  services.flatpak.enable = true;
  services.locate = {
    enable = true;
    interval = "hourly";
    localuser = null;
    package = pkgs.plocate;
  };
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune = {
        enable = true;
        dates = "daily";
      };
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
    libvirtd.enable = true;
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;
  programs.ssh.askPassword = mkForce "${pkgs.gnome.seahorse}/libexec/seahorse/ssh-askpass";

  powerManagement.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.enable = false;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    allowed-users = [ "alan" ];
    trusted-users = [ "root" "alan" ];
  };

  # Hardening
  programs.firejail.enable = true;
  security.chromiumSuidSandbox.enable = true;
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
  systemd.coredump.enable = false;

  # Prevents core dump files
  security.pam.loginLimits = [{
    domain = "*";
    item = "core";
    type = "hard";
    value = "0";
  }];
  systemd.coredump.extraConfig = ''
    Storage=none
    ProcessSizeMax=0
  '';
}