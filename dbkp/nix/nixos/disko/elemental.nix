{
  disko.devices = {
    disk = {
      vda = {
        type = "disk";
        device = "/dev/disk/by-diskseq/1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "128M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ ];
                settings = {
                  # if you want to use the key for interactive login be sure there is no trailing newline
                  # for example use `echo -n "password" > /tmp/secret.key`
                  keyFile = "/tmp/secret.key";
                  allowDiscards = true;
                };
                additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
            lvm_vg = {
              pool = {
                type = "lvm_vg";
                lvs = {
                  root = {
                    size = "100%";
                    content = {
                      type = "btrfs";
                      extraArgs = [ "-f" ]; # Override existing partition
                      subvolumes = {
                        "/root" = {
                          mountOptions = [ "compress=zstd" ];
                          mountpoint = "/";
                        };
                        "/home" = {
                          mountOptions = [ "compress=zstd" ];
                          mountpoint = "/home";
                        };
                        "/nix" = {
                          mountOptions = [ "compress=zstd" "noatime" ];
                          mountpoint = "/nix";
                        };
                        "/swap" = {
                          mountOptions = [ "noatime" ];
                          mountpoint = "/swap";
                          swap.swapfile.size = "16G";
                        };
                      };
                      mountpoint = "/root-partition";
                      swap.swapfile.size = "16G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
