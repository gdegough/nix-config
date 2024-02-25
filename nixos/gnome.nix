{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  services.xserver = {
    enable = true;
    displayManager = {
      gdm.enable = true; # GDM
      gdm.autoSuspend = false;
      # defaultSession = "gnome"; # Make gnome the default session
    };
    desktopManager = {
      gnome.enable = true; # enable GNOME
      # adds these schemas for dconf and gsettings
      gnome.sessionPath = [ 
        pkgs.gnome.gnome-settings-daemon
        pkgs.gnome.gnome-tweaks
        pkgs.gnome.mutter # this is necessary to control fractional scaling
        pkgs.gnome.nautilus
      ];
    };
  };

  # Prefer seahorse's ssh-askpass. Resolves conflct with ksshaskpass if KDE is also installed 
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.gnome.seahorse.out}/libexec/seahorse/ssh-askpass";

  # List packages installed in system profile:
  environment.systemPackages = [
    pkgs.adwaita-qt
    pkgs.adwaita-qt6
    pkgs.adw-gtk3
    pkgs.gnome.networkmanager-l2tp
    pkgs.qgnomeplatform
    pkgs.qgnomeplatform-qt6
    pkgs.wev
  ];
}
