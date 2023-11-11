# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs
  , lib
  , config
  , pkgs
  , ...
}:
#with lib.hm.gvariant;
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./admin-utilities.nix
    ./alacritty-package-and-config.nix
    ./audio-video-processing.nix
    ./autostart-config.nix
    ./bash-config.nix 
    ./bitwarden.nix
    ./browsers.nix
    ./coding-utilities.nix
    ./conky-package-and-config.nix
    ./dircolors-config.nix
    ./editors.nix
    ./fonts.nix
    ./foot-config.nix
    ./games.nix
    ./git-config.nix
    ./gnome-packages-and-config.nix
    ./gnome-terminal-config.nix
    ./graphic-art.nix
    ./htmltidy-config.nix
    ./i3blocks-package-and-config.nix
    ./megasync-package-and-config.nix
    ./multimedia.nix
    ./music-composition.nix
    ./mutt-package-and-config.nix
    ./office.nix
    ./readline-config.nix
    ./rofi-config.nix
    ./secure-messaging.nix
    ./sway-config.nix
    ./systemd-environment-config.nix
    ./tmux-package-and-config.nix
    ./waybar-config.nix
    ./wofi-config.nix
    ./x-config.nix
    ./xsettingsd-config.nix
    ./zsh-config.nix
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
    homeDirectory = "/home/gmdegoug";
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
  home.stateVersion = "23.05";
}
