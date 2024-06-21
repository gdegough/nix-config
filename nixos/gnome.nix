{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm = { # GDM
          enable = true;
          wayland = true;
          # autoSuspend = false; 
        };
      };
      desktopManager = {
        gnome = { # GNOME 
          enable = true;
          # add these schemas for dconf and gsettings
          sessionPath = [
            pkgs.gnome.gnome-settings-daemon
            pkgs.gnome.gnome-tweaks
            pkgs.gnome.mutter # this is necessary to control fractional scaling
            pkgs.gnome.nautilus
          ];
        };
      };
    };
    displayManager = {
      defaultSession = "gnome"; # Make gnome the default session;
    };
    gnome = {
      games.enable = true; # install GNOME games 
      core-developer-tools.enable = true; # install GNOME core dev tools
    };
  };

  # make QT apps look similar to GNOME desktop
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Prefer seahorse's ssh-askpass. Resolves conflct with ksshaskpass if KDE is also installed 
  # programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.gnome.seahorse.out}/libexec/seahorse/ssh-askpass";
  # OR
  # Force git to use terminal to prompt for password
  programs.ssh.askPassword = "";

  # List packages installed in system profile:
  environment.systemPackages = [
    pkgs.adwaita-qt
    pkgs.adwaita-qt6
    pkgs.adw-gtk3
    pkgs.gnome.networkmanager-l2tp
    pkgs.pinentry-gnome3
    pkgs.qgnomeplatform
    pkgs.qgnomeplatform-qt6
    pkgs.wev
  ];
}
