# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
#with lib.hm.gvariant;
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    #inputs.nix-colors.homeManagerModule
    #inputs.nixvim.homeManagerModules.nixvim

    # host-specific configs
    ./conky-package-and-local-config.nix
    ./sway-local-config.nix
    ./systemd-environment-local-config.nix
    # global common configs
    ../../../home-manager/admin-utilities.nix
    ../../../home-manager/alacritty-package-and-config.nix
    ../../../home-manager/autostart-config.nix
    ../../../home-manager/bash-config.nix 
    ../../../home-manager/bitwarden.nix
    ../../../home-manager/browsers.nix
    ../../../home-manager/coding-utilities.nix
    ../../../home-manager/dircolors-config.nix
    ../../../home-manager/editors.nix
    ../../../home-manager/fonts.nix
    ../../../home-manager/foot-config.nix
    ../../../home-manager/games.nix
    ../../../home-manager/git-config.nix
    ../../../home-manager/gnome-packages-and-config.nix
    ../../../home-manager/gnome-terminal-config.nix
    ../../../home-manager/graphic-art.nix
    ../../../home-manager/htmltidy-config.nix
    ../../../home-manager/i3blocks-package-and-config.nix
    ../../../home-manager/java-webstart.nix
    ../../../home-manager/megasync-package-and-config.nix
    ../../../home-manager/multimedia.nix
    ../../../home-manager/music-composition.nix
    ../../../home-manager/mutt-package-and-config.nix
    ../../../home-manager/office.nix
    ../../../home-manager/qalculate-gtk.nix
    ../../../home-manager/readline-config.nix
    ../../../home-manager/rofi-config.nix
    ../../../home-manager/secure-messaging.nix
    ../../../home-manager/sway-config.nix
    ../../../home-manager/systemd-environment-config.nix
    ../../../home-manager/tmux-package-and-config.nix
    ../../../home-manager/waybar-config.nix
    ../../../home-manager/wofi-config.nix
    ../../../home-manager/x-config.nix
    ../../../home-manager/xsettingsd-config.nix
    ../../../home-manager/zsh-config.nix
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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "gmdegoug";
    homeDirectory = "/home/${config.home.username}";
  };

  home.sessionVariables = {
      COUNTRY = "US";
      MAIL = "$HOME/.maildir";
      MAILPATH = "$HOME/.maildir";
      PAGER = "less";
      PROMPT_DIRTRIM = 3;
      QT_QPA_PLATFORMTHEME = "gnome";
      XCURSOR_THEME = "Adwaita";
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  targets.genericLinux.enable = true;

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [
    neofetch
    ranger
    wget
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
