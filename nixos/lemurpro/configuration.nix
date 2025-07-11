## This is your system's configuration file.
## Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  ## You can import other NixOS modules here
  imports = [
    ## If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    ## Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    ## Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    ## Host-specific configurations
    ./admin-scripts.nix
    # ./gdm-monitors.nix
    ./networking.nix
    ./multimedia-firewall.nix
    ./graphics.nix

    ## Global configurations
    ../locale.nix ## environment
    ../pipewire.nix ## sound
    ../postfix.nix ## MTA

    ## shells
    ../nushell.nix ## nushell
    ../zsh.nix ## ZSH

    ## DEs
    # ../cosmic.nix # System76 COSMIC desktop environment
    ../gnome.nix ## GNOME desktop environment
    # ../hyprland.nix ## Hyprland WM
    # ../kde.nix ## KDE desktop environment
    ../sway.nix ## Sway WM
    ../tiling-wm-support.nix ## common tiling WM support

    ## Optional server apps
    # ../vm-host.nix # virtual machine hosting

    ## users
    ../root.nix
    ../gmdegoug.nix
    ../pdegough.nix
  ];

  nixpkgs = {
    ## You can add overlays here
    overlays = [
      ## Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.unstable-packages

      ## You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      ## Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    ## Configure your nixpkgs instance
    config = {
      ## Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  ## This will add each flake input as a registry
  ## To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  ## This will additionally add your inputs to the system's legacy channels
  ## Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    ## Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    ## Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  ## bring in latest kernels
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ## Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "auto";
    };
    timeout = 10;
    efi.canTouchEfiVariables = true;
  };

  ## Use ZRAM as swap device
  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = false; ## conflicts with system76-power service
  services.printing.enable = true; ## Enable CUPS to print documents.

  ## Bcachefs workaround
  # systemd.services.mnt-srv = {
  #   wantedBy = [ "local-fs.target" ];
  #   description = "Mount srv partition";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = ''${pkgs.bcachefs-tools}/bin/mount.bcachefs UUID=5c46fec0-dd3b-409c-95fb-cff9ec5302dc -o compression=zstd:10 /srv'';
  #   };
  # };

  ## Polkit is used for controlling system-wide privileges
  security.polkit.enable = true;

  ## System76
  hardware.system76.enableAll = true;

  # local groups I use for media servers
  users.groups.media.gid = 901;
  users.groups.shared-files.gid = 902;

  ## List packages installed in system profile:
  environment.systemPackages = [
    pkgs.bc
    pkgs.btop
    pkgs.brightnessctl
    pkgs.btrfs-progs
    pkgs.cifs-utils
    pkgs.efibootmgr
    pkgs.exfatprogs
    pkgs.git
    pkgs.gnupg
    pkgs.gptfdisk
    pkgs.home-manager
    pkgs.lm_sensors
    pkgs.lynx
    pkgs.mailutils
    pkgs.parted
    pkgs.pinentry-curses
    pkgs.python3
    pkgs.sysstat
    pkgs.system76-firmware
    pkgs.system76-keyboard-configurator
    pkgs.terminus_font
    pkgs.unzip
    pkgs.zip
  ];

  ## to put bash-completion files in path
  environment.pathsToLink = [ "/share/bash-completion" ];

  ## This is using a rec (recursive) expression to set and access XDG_BIN_HOME within the expression
  ## For more on rec expressions see https://nix.dev/tutorials/first-steps/nix-language#recursive-attribute-set-rec
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    ## Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };

  ## This sets up a SSH server. Very important if you're setting up a headless system.
  ## Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      ## Forbid root password login through SSH.
      PermitRootLogin = "prohibit-password";
      PubKeyAuthentication = true;
      PasswordAuthentication = true;
    };
  };

  ## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
