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

  boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "sg" "coretemp" "nct6775" ];
  boot.supportedFilesystems = [ "btrfs" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "tmpfs";
      fsType = "tmpfs";
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "PARTUUID=0194752a-6d74-40fb-b576-e15b1706062d";
      fsType = "vfat";
      options = [ "umask=0077" ];
    };

  fileSystems."/home" =
    { device = "UUID=3c32a6a4-25a0-4e3c-b6ee-59f1b5c3776e";
      fsType = "btrfs";
      options = [ "relatime" "compress=zstd:6" "discard=async" "subvol=@home" ];
      neededForBoot = true;
    };

  fileSystems."/nixos" =
    { device = "UUID=8acf659f-8e2b-4aad-8bca-0f3f615dcbcd";
      fsType = "btrfs";
      options = [ "relatime" "compress=zstd:3" "discard=async" "subvol=@nix" ];
      neededForBoot = true;
    };

  fileSystems."/root" =
    { device = "/nixos/root";
      fsType = "none";
      options = [ "bind" ];
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

  fileSystems."/mnt/backup/internal" = 
    { device = "UUID=f578e5a8-bcc2-43bf-b8bb-e30aceab1b48";
      fsType = "btrfs";
      options = [ "relatime" "compress=zstd:10" "discard=async" "subvol=@backup" ];
      neededForBoot = true;
    };

  fileSystems."/var/lib/libvirt/images" = 
    { device = "UUID=b6b0fcee-d2b0-456f-a544-de5da204b32c";
      fsType = "btrfs";
      options = [ "relatime" "compress=zstd:3" "discard=async" "subvol=@vm-images" ];
      neededForBoot = true;
    };

  fileSystems."/mnt/backup/128Gext" = 
    { device = "UUID=2701a71a-e25d-4730-a420-dd9678a952c6";
      fsType = "btrfs";
      options = [ "relatime" "compress=zstd:10" "discard=async" "subvol=@backup" "noauto" ];
    };

  fileSystems."/mnt/backup/256Gext" = 
    { device = "UUID=431847a2-75b2-4cd9-bd2a-26d296d417b8";
      fsType = "btrfs";
      options = [ "relatime" "compress=zstd:10" "discard=async" "subvol=@backup" "noauto" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/0e844e47-9c6b-4df2-b14e-c056fcf12e2c"; }
    ];

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  # this folder is where the files will be stored (don't put it in tmpfs)
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/ssh"
      "/var/log"
      "/var/lib/AccountsService"
      "/var/lib/bluetooth"
      "/var/lib/cups"
      "/var/lib/fprint"
      "/var/lib/nixos"
      "/var/lib/libvirt"
      "/var/db/sudo/lectured"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
