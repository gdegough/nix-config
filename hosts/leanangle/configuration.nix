# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: 
{
  # You can import other NixOS modules here
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    # other host-specific hardware
    ./networking.nix
    ./opengl.nix
    ./gdm-monitors.nix

    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # environmental specifics
    ../../nixos/global/locale.nix
    ../../nixos/global/pipewire.nix
    ../../nixos/global/postfix.nix
    # shells
    ../../nixos/global/zsh.nix
    # window managers
    ../../nixos/global/hyprland.nix
    ../../nixos/global/sway.nix
    ../../nixos/global/gnome.nix
    # optional apps
    ../../nixos/optional/plex.nix
    ../../nixos/optional/samba.nix
    ../../nixos/optional/vm-host.nix
    # users
    ../../users/root.nix
    ../../users/gmdegoug.nix
    ../../users/pdegough.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    package = pkgs.nix;
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bc
    btrbk
    efibootmgr
    exfatprogs
    gnupg
    gptfdisk
    lm_sensors
    mailutils
    php
    postgresql
    python3
    sops
    sysstat
    system76-keyboard-configurator
    terminus_font
    unzip
    zip
  ];

  # to put bash-completion files in path
  environment.pathsToLink = [ "/share/bash-completion" ];

  # This is using a rec (recursive) expression to set and access XDG_BIN_HOME within the expression
  # For more on rec expressions see https://nix.dev/tutorials/first-steps/nix-language#recursive-attribute-set-rec
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };

  # This sets up an SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    settings.PermitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    settings.PasswordAuthentication = false;
  };

  # users are defined in configuration
  users.mutableUsers = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
