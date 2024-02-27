{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  services.xserver.desktopManager.gnome.enable = true; # GNOME 
  services.xserver.displayManager.gdm.enable = true; # GDM
  # services.xserver.displayManager.gdm.autoSuspend = true; 
  services.xserver.displayManager.defaultSession = "gnome"; # Make gnome the default session
  services.gnome.games.enable = true; # install GNOME games
  services.gnome.core-developer-tools.enable = true; # install GNOME core dev tools
  # adds these schemas for dconf and gsettings
  services.xserver.desktopManager.gnome.sessionPath = [
    pkgs.gnome.gnome-settings-daemon
    pkgs.gnome.gnome-tweaks
    pkgs.gnome.mutter # this is necessary to control fractional scaling
    pkgs.gnome.nautilus
  ];

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
