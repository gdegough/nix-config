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
  boot.kernelModules = [ "kvm-intel" "sg" "coretemp" "nct6775" ];
  boot.supportedFilesystems = [ "btrfs" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = { 
    device = "tmpfs";
    fsType = "tmpfs";
    neededForBoot = true;
  };

  fileSystems."/boot" = { 
    device = "PARTUUID=0194752a-6d74-40fb-b576-e15b1706062d";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };

  fileSystems."/nixos" = { 
    device = "UUID=3e8072b2-c417-4066-a7f5-ea71ffab8e35";
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
    device = "UUID=faa6088f-91ad-486c-b0ac-110a696a79f3";
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
    device = "UUID=2d5ce27f-7c30-49e1-90bb-a2012020cb6f";
    fsType = "ext4";
    neededForBoot = false;
  };

  fileSystems."/mnt/backup/256Gext" = { 
    device = "UUID=905ae989-490f-4a84-956c-6b61ad34715e";
    fsType = "ext4";
    neededForBoot = false;
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
      # "/var/lib/samba"
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
