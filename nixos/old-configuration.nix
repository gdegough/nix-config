# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ 
  config
  , lib
  , pkgs
  , modulesPath
  , ... 
}:
{
  imports = [ 
    ./hardware-configuration.nix
    ./plex.nix
    ./postfix.nix
    ./samba.nix
    ./sway.nix
    ./users.nix
  ];

  # bring in latest kernels
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use ZRAM as swap device
  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  services.power-profiles-daemon.enable = true;
  services.printing.enable = true; # Enable CUPS to print documents.

  # Disable sleep and hibernation. This system should be always on.
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
  
  # Polkit is used for controlling system-wide privileges
  security.polkit.enable = true;

  # Enable experimental features in nix
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bc
    btrbk
    efibootmgr
    gptfdisk
    libdvdcss
    lm_sensors
    mailutils
    php
    postgresql
    python3
    sysstat
    terminus_font
    unzip
    zip
  ];

  environment.pathsToLink = [ "/share/bash-completion" ];
}
