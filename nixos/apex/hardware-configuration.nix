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
  boot.kernelModules = [ "kvm-intel" ];
  boot.supportedFilesystems = [ "btrfs" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = { 
    device = "tmpfs";
    fsType = "tmpfs";
    neededForBoot = true;
  };

  fileSystems."/boot" = { 
    device = "UUID=6E37-8984";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };

  fileSystems."/nixos" = { 
    device = "UUID=49c0fae2-1b2c-4997-a0c2-48b169f4ef8b";
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
    device = "UUID=e2a7cdff-15fd-4930-bd50-ed70366e365f";
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

  fileSystems."/var/lib/plex" = { 
    device = "UUID=5f9e8223-1be7-42eb-a42b-51c2376eed16";
    fsType = "ext4";
    neededForBoot = false;
  };

  fileSystems."/srv/public" = { 
    device = "UUID=3c97c3ba-2561-4cbe-bae7-f6eb143c4439";
    fsType = "btrfs";
    options = [ "subvol=@public" "relatime" "compress=zstd:10" "discard=async" ];
  };

  fileSystems."/srv/samba" = { 
    device = "UUID=3c97c3ba-2561-4cbe-bae7-f6eb143c4439";
    fsType = "btrfs";
    options = [ "subvol=@samba" "relatime" "compress=zstd:10" "discard=async" ];
  };

  fileSystems."/srv/sftp" = { 
    device = "UUID=3c97c3ba-2561-4cbe-bae7-f6eb143c4439";
    fsType = "btrfs";
    options = [ "subvol=@sftp" "relatime" "compress=zstd:10" "discard=async" ];
  };

  fileSystems."/srv/www" = { 
    device = "UUID=3c97c3ba-2561-4cbe-bae7-f6eb143c4439";
    fsType = "btrfs";
    options = [ "subvol=@www" "relatime" "compress=zstd:10" "discard=async" ];
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
    ];
    files = [
      "/etc/machine-id"
      # "/var/lib/logrotate.status"
    ];
  };
}
