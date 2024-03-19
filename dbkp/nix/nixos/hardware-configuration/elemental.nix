{ lib, modulesPath, pkgs, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.extraModulePackages = [ ];
  boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];

  boot.initrd.luks.devices = {
    "luks-bc6920fb-944d-48e5-8f73-3f57179ca527" = {
      device = "/dev/disk/by-uuid/bc6920fb-944d-48e5-8f73-3f57179ca527";
    };
    "luks-3a81fadd-3844-45c6-80fc-a7f0fcf537c8" = {
      device = "/dev/disk/by-uuid/3a81fadd-3844-45c6-80fc-a7f0fcf537c8";
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4401011e-b546-4582-b6aa-05476825f670";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E383-104D";
    fsType = "vfat";
    options = [ "umask=077" ];
  };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    intel-ocl
    vaapiVdpau
    libvdpau-va-gl
  ];

  swapDevices = [{ device = "/dev/disk/by-uuid/eb73c555-7f45-49c1-bcd9-805e4e43bc08"; }];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
