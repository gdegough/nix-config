{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.impermanence.nixosModules.impermanence
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "uas" "sd_mod" "bcachefs" ];
  boot.initrd.kernelModules = [ "bcachefs" ];
  boot.kernelModules = [ "kvm-intel" "bcachefs" ];
  boot.supportedFilesystems = [ "bcachefs" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "tmpfs";
      fsType = "tmpfs";
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-partuuid/47daf2ae-8836-46aa-9021-776c5bd8a2c6";
      fsType = "vfat";
    };

  fileSystems."/nixos" =
    { device = "UUID=<UUID partition # here>";
      fsType = "bcachefs";
      options = [ "acl" "compression=zstd:3" ];
      neededForBoot = true;
    };

  fileSystems."/root" =
    { device = "/nixos/root";
      fsType = "none";
      options = [ "bind" ];
      neededForBoot = true;
    };

  fileSystems."/home" =
    { device = "UUID=<UUID partition # here>";
      fsType = "bcachefs";
      options = [ "acl" "compression=zstd:3" ];
      neededForBoot = true;
    };

  fileSystems."/persist" =
    { device = "/nixos/persist";
      fsType = "none";
      options = [ "bind" ];
      neededForBoot = true;
    };

  fileSystems."/nix" =
    { device = "/nixos/nix";
      fsType = "none";
      options = [ "bind" ];
      neededForBoot = true;
    };

  fileSystems."/etc/NetworkManager" =
    { device = "/nixos/networkmanager-config";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/mnt/backup/128Gext" =
    { device = "/dev/disk/by-uuid/82a75835-a541-4976-bc10-d643a69169b6";
      fsType = "btrfs";
      options = [ "subvol=@backup" "relatime" "discard=async" "compress=zstd" "noauto" ];
    };

  fileSystems."/mnt/backup/256Gext" =
    { device = "/dev/disk/by-uuid/7dcad2e8-e127-4a55-9a41-f73c46239e9b";
      fsType = "btrfs";
      options = [ "subvol=@backup" "relatime" "discard=async" "compress=zstd" "noauto" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/96cb2efb-a88e-4d79-b157-807ebfb10e16"; }
    ];

  nixpkgs.hostPlatform = "x86_64-linux";
  powerManagement.cpuFreqGovernor = "powersave";
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  # this folder is where the files will be stored (don't put it in tmpfs)
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/ssh"
      "/var/log"
      "/var/lib/cups"
      "/var/lib/fprint"
      "/var/db/sudo/lectured"
    ];
    files = [
      "/etc/machine-id"
      "/etc/nix/id_rsa"
      "/var/lib/logrotate.status"
    ];
  };
}
