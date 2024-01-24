{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/hardware/network/broadcom-43xx.nix")
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "sd_mod"
    "usb_storage"
    "usbhid"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5031bd07-3042-48e4-9dbf-f6a0f12944c3";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-c4daa944-151b-4387-bde2-1fa3c40338b4".device = "/dev/disk/by-uuid/c4daa944-151b-4387-bde2-1fa3c40338b4";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/15A4-C6A4";
    fsType = "vfat";
    options = [ "umask=077" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/c256f8e6-9f12-4a36-ac9c-593dbba1f64d"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
