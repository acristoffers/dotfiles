{ lib, pkgs, ... }:

with lib;
rec {
  boot.loader.grub.enable = false;
  boot.loader.grub.configurationLimit = 5;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" ];

  documentation.man.generateCaches = true;
  documentation.man.man-db.enable = true;

  environment.shells = with pkgs; [ bashInteractive ];
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GNUPGHOME = "$XDG_DATA_HOME/gnupg";
  };
  environment.etc."profile.local".text = ''
    alias sudo=doas
    # export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.gcc.cc.lib}/lib
  '';

  fonts.enableDefaultPackages = true;
  fonts.enableGhostscriptFonts = true;
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    dejavu_fonts
    hunspellDicts.en-us-large
    hunspellDicts.fr-any
    liberation_ttf
    lmmath
    nerd-fonts.inconsolata
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    open-sans
    ubuntu-classic
  ];

  hardware.bluetooth.enable = true;
  hardware.graphics.enable = true;

  time.timeZone = "Europe/Paris";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "fr_FR.UTF-8/UTF-8"
      "pt_BR.UTF-8/UTF-8"
    ];
  };

  location.provider = "geoclue2";

  # users.extraGroups.networkmanager.members = [ "root" ];
  networking = {
    networkmanager = {
      enable = true;
      appendNameservers = [
        "9.9.9.9"
        "1.1.1.1"
      ];
      connectionConfig = {
        "connection.mdns" = 2;
      };
      plugins = [ pkgs.networkmanager-openvpn ];
    };
    enableIPv6 = false;
    nameservers = networking.networkmanager.appendNameservers;
    firewall = {
      enable = mkForce true;
      allowedTCPPorts = [
        22 # SSH
        # 53 # DNS server
        # 17500 # Dropbox
        # 7250 # Miracast
        # 8008
        # 8009
        # 8443 # Chromecast
      ];
      allowedUDPPorts = [
        5353 # mDNS
        # 53 # DNS server
        # 67 # DHCP server
        # 17500 # Dropbox
        # 1900 # SSDP for Chromecast
        # 1194 # VPN
      ];
      allowedUDPPortRanges = [
        {
          from = 32768;
          to = 61000;
        }
      ];
    };
  };

  services.desktopManager.gnome.enable = true;
  services.desktopManager.plasma6.enable = false;
  services.displayManager.gdm.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "intl";
    };
  };

  console.keyMap = "us-acentos";

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      # brlaser
      gutenprint
      gutenprintBin
      hplipWithPlugin
    ];
  };

  services.gnome = {
    tinysparql.enable = true;
    localsearch.enable = true;
  };

  services.samba.enable = true;
  services.samba.openFirewall = true;

  services.power-profiles-daemon.enable = true;

  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "1s";
    TimeoutStopSec = "1s";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  # Allows poweroff/reboot for users
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ( subject.isInGroup("users") && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        ) {
        return polkit.Result.YES;
      }
    });
    polkit.addRule(function(action, subject) {
      if (action.id.startsWith("org.freedesktop.Flatpak") && subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
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
  users.groups.alan = {};
  users.users.alan = {
    isNormalUser = true;
    description = "Álan Crístoffer e Sousa";
    group = "alan";
    extraGroups = [
      "libvirtd"
      "networkmanager"
      "render"
      "video"
      "wheel"
      "vboxusers"
    ];
    packages = [ ];
  };

  environment.systemPackages = with pkgs; [
    (pkgs.lowPrio coreutils-full) # only use the ones uutils doesn't have yet
    evolution-data-server-gtk4
    gnome-network-displays
    gnome-tweaks
    gocryptfs
    iputils
    kitty
    libsForQt5.breeze-icons
    libsForQt5.qtstyleplugin-kvantum
    parted
    plocate
    podman-compose
    pulseaudioFull
    qt6Packages.qtstyleplugin-kvantum
    uutils-coreutils-noprefix
    wget
    xorg.xhost
  ];

  programs.dconf.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
  programs.bash.completion.enable = true;
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

  services.flatpak.enable = true;
  services.locate = {
    enable = true;
    interval = "hourly";
    package = pkgs.plocate;
  };
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  services.resolved = {
    enable = true;
    extraConfig = "MulticastDNS=yes";
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
    spiceUSBRedirection.enable = true;
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  services.openssh.enable = true;
  programs.ssh.askPassword = mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

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
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-trusted-public-keys = [
      "jovian-nixos.cachix.org-1:mAWLjAxLNlfxAnozUjOqGj4AxQwCl7MXwOfu7msVlAo="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    extra-trusted-substituters = [
      "https://cache.nixos.org"
      "https://jovian-nixos.cachix.or"
      "https://nix-community.cachix.org"
    ];
    allowed-users = [ "alan" ];
    trusted-users = [
      "root"
      "alan"
    ];
  };
  nix.extraOptions = ''
    download-buffer-size = 209715200 # 200 MB
  '';

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true; # For wifi printers
    ipv4 = true;
    ipv6 = false;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  services.kanata = {
    enable = true;
    keyboards.default = {
      extraDefCfg = "process-unmapped-keys yes";
      config = ''
        (defsrc
          caps a s d f j k l ;)

        (defvar
          tap-time  150
          hold-time 200)

        (defalias
          a       (tap-hold $tap-time $hold-time a lsft)
          s       (tap-hold $tap-time $hold-time s lctl)
          d       (tap-hold $tap-time $hold-time d lalt)
          f       (tap-hold $tap-time $hold-time f lmet)
          j       (tap-hold $tap-time $hold-time j lmet)
          k       (tap-hold $tap-time $hold-time k lalt)
          l       (tap-hold $tap-time $hold-time l lctl)
          ;       (tap-hold $tap-time $hold-time ; lsft))

        (deflayer base
                  esc @a @s @d @f @j @k @l @;)
      '';
    };
  };

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = [ "alan" ];
      keepEnv = true;
      persist = true;
    }
  ];

  # Hardening
  programs.firejail.enable = true;
  security.chromiumSuidSandbox.enable = true;
  # services.clamav.daemon.enable = true;
  # services.clamav.updater.enable = true;
  systemd.coredump.enable = false;

  # Prevents core dump files
  security.pam.loginLimits = [
    {
      domain = "*";
      item = "core";
      type = "hard";
      value = "0";
    }
  ];
  systemd.coredump.extraConfig = ''
    Storage=none
    ProcessSizeMax=0
  '';
}
