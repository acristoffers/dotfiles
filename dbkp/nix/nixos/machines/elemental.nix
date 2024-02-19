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
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-7b41b757-fdb9-44cd-a0cf-f0da2923f49c".device = "/dev/disk/by-uuid/7b41b757-fdb9-44cd-a0cf-f0da2923f49c";
  boot.initrd.luks.devices."luks-7b41b757-fdb9-44cd-a0cf-f0da2923f49c".keyFile = "/crypto_keyfile.bin";

  environment.variables = {
    VDPAU_DRIVER = "va_gl";
  };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    intel-ocl
    intel-vaapi-driver
    libvdpau-va-gl
  ];

  security.unprivilegedUsernsClone = true;

  services.fstrim.enable = true;
  services.thermald.enable = true;
}
