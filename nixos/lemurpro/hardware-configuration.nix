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

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "coretemp" ];
  boot.supportedFilesystems = [ "btrfs" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = { 
    device = "tmpfs";
    fsType = "tmpfs";
    neededForBoot = true;
  };

  fileSystems."/boot" = { 
    device = "PARTUUID=ecce0f8b-ee18-4b59-9124-29dec7c43dba";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };

  fileSystems."/nixos" = { 
    device = "UUID=776a2e04-c593-41a3-ac5c-2ad9d491dfdc";
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
    device = "UUID=c31d7491-8ffe-468b-9d6f-7be16d61fc7f";
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
    options = [ "defaults,noauto" ];
  };

  fileSystems."/mnt/backup/256Gext" = { 
    device = "UUID=905ae989-490f-4a84-956c-6b61ad34715e";
    fsType = "ext4";
    options = [ "defaults,noauto" ];
  };

  swapDevices = [ { 
	label = "SWAP";
  } ];

  nixpkgs.hostPlatform = "x86_64-linux";
  powerManagement.cpuFreqGovernor = "powersave";
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
