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
    # ../bitwarden.nix
    # ../browsers.nix
    # ../coding-utilities.nix
    # ../common-multimedia.nix
    # ../common-office.nix
    ../dircolors-config.nix
    # ../dunst-config.nix
    # ../editors-with_gui.nix
    ../editors-without_gui.nix
    # ../fonts.nix
    # ../foot-config.nix
    # ../games.nix
    # ../git-config.nix
    # ../gnome-multimedia.nix
    # ../gnome-office.nix
    # ../gnome-packages-and-config.nix
    # ../gnome-systemd-environment-config.nix
    # ../gnome-terminal-config.nix
    # ../graphic-art.nix
    ../htmltidy-config.nix
    # ../hyprland-config.nix
    # ../i3blocks-package-and-config.nix
    # ../java.nix
    # ../kde-admin.nix
    # ../kde-devel.nix
    # ../kde-games.nix
    # ../kde-multimedia.nix
    # ../kde-office.nix
    # ../kde-utilities.nix
    # ../megasync-package-and-config.nix
    # ../music-composition.nix
    ../mutt-package-and-config.nix
    ../nushell-config.nix
    # ../package-management-utilities.nix
    # ../qalculate-gtk.nix
    ../readline-config.nix
    # ../rofi-config.nix
    # ../secure-messaging.nix
    ../starship-root-config.nix
    # ../sway-config.nix
    ../systemd-environment-common-config.nix
    ../tmux-package-and-config.nix
    # ../wofi-config.nix
    # ../x-config.nix
    # ../yakuake.nix
    ../zsh-config.nix
    ## host-specific configs
    # ./bash-local-config.nix
    # ./conky-package-and-local-config.nix
    # ./hyprland-local-config.nix
    # ./nushell-local-config.nix
    # ./openrgb-local-config.nix
    # ./sway-local-config.nix
    ./systemd-environment-local-config.nix
    # ./waybar-config.nix
    # ./xsettingsd-tiling-config.nix
    # ./zsh-local-config.nix
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
    pinentryPackage = pkgs.pinentry-curses; # ncurses
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
  home.stateVersion = "24.05";
}
