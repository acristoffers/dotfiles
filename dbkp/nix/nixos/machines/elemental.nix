{ pkgs, modulesPath, ... }:

rec {
  imports = [
    ./common.nix
    ../hardware-configuration/elemental.nix
    (modulesPath + "/profiles/hardened.nix")
  ];

  networking.hostName = "Alan-NixOS-Elemental";

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.initrd.kernelModules = [ "i915" ];
  boot.initrd.luks.devices."luks-3a81fadd-3844-45c6-80fc-a7f0fcf537c8" = {
    device = "/dev/disk/by-uuid/3a81fadd-3844-45c6-80fc-a7f0fcf537c8";
  };

  environment.systemPackages = with pkgs; [
    auto-cpufreq
  ];

  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    LIBVA_DRIVER_NAME = "iHD";
  };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    intel-ocl
    intel-vaapi-driver
    libvdpau-va-gl
  ];

  services.fstrim.enable = true;
  services.thermald.enable = true;
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

  security.lockKernelModules = false;
  security.unprivilegedUsernsClone = true;

  nix.sshServe.enable = true;
  nix.sshServe.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEEfkBMu/0qcgSq3Er6pCR/BiVg+mv9p6Wi/N129f202 alan@Alan-NixOS-SteamDeck" ];
}
