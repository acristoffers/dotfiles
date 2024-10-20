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

  environment.systemPackages = with pkgs; [
    auto-cpufreq
  ];

  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    LIBVA_DRIVER_NAME = "iHD";
  };

  services.fstrim.enable = true;
  services.thermald.enable = true;
  services.fwupd.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
        enable_thresholds = true;
        start_threshold = 20;
        stop_threshold = 80;
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  # Undo some hardening
  security.lockKernelModules = false;
  security.unprivilegedUsernsClone = true;
  security.allowSimultaneousMultithreading = true; # Allow hyperthreading
  services.power-profiles-daemon.enable = false;

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  nix.settings.secret-key-files = [ "/home/alan/.ssh/nix-store" ];
  nix.sshServe.enable = true;
  nix.sshServe.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEEfkBMu/0qcgSq3Er6pCR/BiVg+mv9p6Wi/N129f202 alan@Alan-NixOS-SteamDeck" ];
}
