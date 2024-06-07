# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:

    # host-specific configs
    ./conky-package-and-local-config.nix
    # ./hyprland-local-config.nix
    ./sway-local-config.nix
    ./systemd-environment-local-config.nix
    ./waybar-config.nix
    # global optional configs
    ../audio-video-processing.nix
    # global common configs
    ../admin-utilities.nix
    ../alacritty-package-and-config.nix
    ../autostart-config.nix
    ../bash-config.nix 
    ../bitwarden.nix
    ../browsers.nix
    ../coding-utilities.nix
    ../common-multimedia.nix
    ../common-office.nix
    ../common-systemd-environment-config.nix
    ../dircolors-config.nix
    ../dunst-config.nix
    ../editors.nix
    ../fonts.nix
    ../foot-config.nix
    ../games.nix
    ../git-config.nix
    ../gnome-multimedia.nix
    ../gnome-office.nix
    ../gnome-packages-and-config.nix
    ../gnome-systemd-environment-config.nix
    ../gnome-terminal-config.nix
    ../graphic-art.nix
    ../htmltidy-config.nix
    # ../hyprland-config.nix
    ../i3blocks-package-and-config.nix
    ../java.nix
    ../megasync-package-and-config.nix
    ../music-composition.nix
    ../mutt-package-and-config.nix
    ../nushell-config.nix
    ../package-management-utilities.nix
    ../qalculate-gtk.nix
    ../readline-config.nix
    ../rofi-config.nix
    ../secure-messaging.nix
    ../sway-config.nix
    ../tmux-package-and-config.nix
    ../wofi-config.nix
    ../x-config.nix
    ../zsh-config.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
      # permittedInsecurePackages = [
      #   "freeimage-unstable-2021-11-01"
      # ];
    };
  };

  home = {
    username = "gmdegoug";
    homeDirectory = "/home/gmdegoug";
  };

  home.sessionVariables = {
    COUNTRY = "US";
    MAIL = "$HOME/.maildir";
    MAILPATH = "$HOME/.maildir";
    MOZ_USE_XINPUT2 = "1";
    PAGER = "less";
    PROMPT_DIRTRIM = 3;
    XCURSOR_THEME = "Adwaita";
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentryFlavor = "gnome3";
  };

  targets.genericLinux.enable = true;

  # Add stuff for your user as you see fit:
  home.packages = [
    pkgs.wget
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
