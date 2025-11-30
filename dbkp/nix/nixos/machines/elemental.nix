{ pkgs, modulesPath, ... }:

{
  imports = [
    ./common.nix
    ../hardware-configuration/elemental.nix
    (modulesPath + "/profiles/hardened.nix")
  ];

  networking.hostName = "Alan-NixOS-Elemental";

  boot.kernelPackages = pkgs.linuxPackages_zen;
  environment.memoryAllocator.provider = "libc";

  services.desktopManager.cosmic.enable = false;

  environment.systemPackages = with pkgs; [
    # auto-cpufreq
  ];

  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    LIBVA_DRIVER_NAME = "iHD";
  };

  services.fstrim.enable = true;
  services.thermald.enable = true;
  services.fwupd.enable = true;
  # If auto-cpufreq is on, then power-profiles-daemon has to be off.
  # services.power-profiles-daemon.enable = false;
  # services.auto-cpufreq = {
  #   enable = true;
  #   settings = {
  #     battery = {
  #       governor = "powersave";
  #       turbo = "never";
  #       enable_thresholds = true;
  #       start_threshold = 20;
  #       stop_threshold = 80;
  #     };
  #     charger = {
  #       governor = "performance";
  #       turbo = "auto";
  #     };
  #   };
  # };

  # Undo some hardening
  security.lockKernelModules = false;
  security.unprivilegedUsernsClone = true;
  security.allowSimultaneousMultithreading = true; # Allow hyperthreading

  nix.settings.secret-key-files = [ "/home/alan/.ssh/nix-store" ];
  nix.sshServe.enable = true;
  nix.sshServe.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEEfkBMu/0qcgSq3Er6pCR/BiVg+mv9p6Wi/N129f202 alan@Alan-NixOS-SteamDeck" ];

  fileSystems = {
    "/mnt/backup" =
      {
        device = "/dev/disk/by-uuid/9dad1b34-2f0a-4cb5-b617-2ce83ae5b674";
        fsType = "btrfs";
        options = [ "x-systemd.automount" "defaults" "user" "nofail" "compress=zstd" "autodefrag" ];
      };
    # "/mnt/backup/thunderbird" =
    #   {
    #     device = "/dev/disk/by-uuid/9dad1b34-2f0a-4cb5-b617-2ce83ae5b674";
    #     fsType = "btrfs";
    #     options = [ "x-systemd.automount" "subvol=thunderbird" "defaults" "user" "nofail" "compress=zstd" "autodefrag" ];
    #   };
  };
}
