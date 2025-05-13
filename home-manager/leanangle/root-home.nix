## This is your home-manager configuration file
## Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  ## You can import other home-manager modules here
  imports = [
    ## If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    ## Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ## You can also split up your configuration and import pieces of it here:

    ## global optional configs
    # ../audio-video-processing.nix
    ## global common configs
    # ../admin-utilities-with_gui.nix
    ../admin-utilities-without_gui.nix
    # ../alacritty-package-and-config.nix
    # ../autostart-config.nix
    ../bash-config.nix 
    # ./bash-local-config.nix
    # ../bitwarden.nix
    # ../browsers.nix
    # ../coding-utilities.nix
    # ../common-multimedia.nix
    # ../common-office.nix
    # ./conky-package-and-local-config.nix
    ../dircolors-config.nix
    # ../dunst-config.nix
    # ../editors-with_gui.nix
    ../editors-without_gui.nix
    # ../fonts.nix
    # ../games.nix
    # ../git-config.nix
    # ../graphic-art.nix
    ../htmltidy-config.nix
    # ../java.nix
    # ../megasync-package-and-config.nix
    # ../music-composition.nix
    ../mutt-package-and-config.nix
    # ../nushell-config.nix
    # ./nushell-local-config.nix
    # ./openrgb-local-config.nix
    # ../package-management-utilities.nix
    # ../qalculate-gtk.nix
    ../readline-config.nix
    # ../secure-messaging.nix
    ../starship-root-config.nix
    ../systemd-environment-common-config.nix
    ./systemd-environment-local-config.nix
    ../tmux-package-and-config.nix
    # ../x-config.nix
    ../zsh-config.nix
    # ./zsh-local-config.nix

    ## GNOME
    # ../gnome-multimedia.nix
    # ../gnome-office.nix
    # ../gnome-packages-and-config.nix
    # ../gnome-systemd-environment-config.nix
    # ../gnome-terminal-config.nix

    ## KDE
    # ../kde-admin.nix
    # ../kde-devel.nix
    # ../kde-games.nix
    # ../kde-multimedia.nix
    # ../kde-office.nix
    # ../kde-utilities.nix
    # ../yakuake.nix

    ## Tiling WMs
    ## hyprland
    # ../hyprland-config.nix
    # ./hyprland-local-config.nix

    ## Sway
    # ../sway-config.nix
    # ./sway-local-config.nix

    ## Tiling WM common
    # ../i3blocks-package-and-config.nix
    # ../foot-config.nix
    # ../rofi-config.nix
    # ../waybar-config.nix
    # ./waybar-local-config.nix
    # ../wofi-config.nix
    # ./xsettingsd-tiling-config.nix
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
      ## Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
      # permittedInsecurePackages = [
      #   "freeimage-unstable-2021-11-01"
      # ];
    };
  };

  home = {
    username = "root";
    homeDirectory = "/root";
  };

  home.sessionVariables = {
    COUNTRY = "US";
    MAIL = "$HOME/Maildir";
    MAILPATH = "$HOME/Maildir";
    MOZ_USE_XINPUT2 = "1";
    PAGER = "less";
    PROMPT_DIRTRIM = 3;
    # XCURSOR_THEME = "Adwaita"; # GNOME
    # XCURSOR_THEME = "Breeze"; # KDE
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    # 24.11
    # pinentryPackage = pkgs.pinentry-curses; # curses
    # pinentryPackage = pkgs.pinentry-gnome3; # GNOME
    # pinentryPackage = pkgs.pinentry-qt; # KDE
    # 25.05
    pinentry.package = pkgs.pinentry-curses; # curses
    # pinentry.package = pkgs.pinentry-gnome3; # GNOME
    # pinentry.package = pkgs.pinentry-qt; # KDE
  };

  targets.genericLinux.enable = true;

  ## Add stuff for your user as you see fit:
  home.packages = [
    pkgs.wget
  ];

  ## Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  ## Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  ## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
