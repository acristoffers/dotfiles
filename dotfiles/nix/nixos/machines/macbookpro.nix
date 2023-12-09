{ pkgs, modulesPath, ... }:

rec {
  imports = [
    ./common.nix
    ../hardware-configuration/macbookpro.nix
    (modulesPath + "/profiles/hardened.nix")
  ];

  networking.hostName = "Alan-NixOS-MacBookPro";

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-7b41b757-fdb9-44cd-a0cf-f0da2923f49c".device = "/dev/disk/by-uuid/7b41b757-fdb9-44cd-a0cf-f0da2923f49c";
  boot.initrd.luks.devices."luks-7b41b757-fdb9-44cd-a0cf-f0da2923f49c".keyFile = "/crypto_keyfile.bin";

  hardware.facetimehd.enable = true;
  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  services.mbpfan.enable = true;

  security.unprivilegedUsernsClone = true;

  # Disable XHC1 wakeup signal to avoid resume getting triggered some time
  # after suspend. Reboot required for this to take effect.
  services.udev.extraRules = ''SUBSYSTEM=="pci", KERNEL=="0000:00:14.0", ATTR{power/wakeup}="disabled"'';
  services.fstrim.enable = true;
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
