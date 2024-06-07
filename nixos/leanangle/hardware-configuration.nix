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

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "sg" ];
  boot.supportedFilesystems = [ "btrfs" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = { 
    device = "tmpfs";
    fsType = "tmpfs";
    neededForBoot = true;
  };

  fileSystems."/boot" = { 
    device = "UUID=3B78-F514";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."/nixos" = { 
    device = "UUID=57253a80-427e-4a23-a89f-81cec9218eba";
    fsType = "ext4";
    neededForBoot = true;
  };

  fileSystems."/root" = { 
    device = "/nixos/root";
    fsType = "none";
    options = [ "bind" ];
    neededForBoot = true;
  };

  fileSystems."/home" = { 
    device = "UUID=c1a13972-e303-445d-95c9-a94143ef1b26";
    fsType = "ext4";
    neededForBoot = true;
  };

  fileSystems."/persist" = { 
    device = "/nixos/persist";
    fsType = "none";
    options = [ "bind" ];
    neededForBoot = true;
  };

  fileSystems."/nix" = { 
    device = "/nixos/nix";
    fsType = "none";
    options = [ "bind" ];
    neededForBoot = true;
  };

  fileSystems."/mnt/backup/128Gext" = { 
    device = "/dev/disk/by-uuid/82a75835-a541-4976-bc10-d643a69169b6";
    fsType = "btrfs";
    options = [ "subvol=@backup" "relatime" "discard=async" "compress=zstd" "noauto" ];
  };

  fileSystems."/mnt/backup/256Gext" = { 
    device = "/dev/disk/by-uuid/7dcad2e8-e127-4a55-9a41-f73c46239e9b";
    fsType = "btrfs";
    options = [ "subvol=@backup" "relatime" "discard=async" "compress=zstd" "noauto" ];
  };

  fileSystems."/mnt/backup/internal" = { 
    device = "UUID=174c69f3-e1cd-4c29-98f1-a18dfd0c6d34";
    fsType = "ext4";
    neededForBoot = true;
  };

  swapDevices = [ ];

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
      "/var/db/sudo/lectured"
      "/etc/NetworkManager/system-connections"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      # "/var/lib/logrotate.status"
    ];
  };
}
