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
    ./displaymanager.nix
    ./icon-themes.nix
  ];

  services = {
    xserver = {
      desktopManager = {
        gnome = { ## GNOME 
          enable = true;
          ## add these schemas for dconf and gsettings
          sessionPath = [
            pkgs.nautilus
            pkgs.gnome-tweaks
            pkgs.gnome-settings-daemon
            pkgs.mutter ## this is necessary to control fractional scaling
          ];
        };
      };
    };
    gnome = {
      games.enable = true; ## install GNOME games 
      core-developer-tools.enable = true; ## install GNOME core dev tools
    };
  };

  ## make QT apps look similar to GNOME desktop
  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };

  ## Prefer seahorse's ssh-askpass. Resolves conflct with ksshaskpass if KDE is also installed 
  # programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.gnome.seahorse.out}/libexec/seahorse/ssh-askpass";
  ## OR
  ## Force git to use terminal to prompt for password
  programs.ssh.askPassword = "";

  ## List packages installed in system profile:
  environment.systemPackages = [
    pkgs.adwaita-qt
    pkgs.adwaita-qt6
    pkgs.adw-gtk3
    # pkgs.gnome.networkmanager-l2tp
    pkgs.gparted
    pkgs.gruvbox-gtk-theme
    pkgs.pinentry-gnome3
    pkgs.qgnomeplatform
    pkgs.qgnomeplatform-qt6
    pkgs.wev
  ];
}
