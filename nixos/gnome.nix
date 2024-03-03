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
    displayManager.gdm.enable = true; # GDM
    displayManager.gdm.autoSuspend = false; 
    displayManager.defaultSession = "gnome"; # Make gnome the default session
    desktopManager.gnome.enable = true; # GNOME 
    # adds these schemas for dconf and gsettings
    desktopManager.gnome.sessionPath = [
      pkgs.gnome.gnome-settings-daemon
      pkgs.gnome.gnome-tweaks
      pkgs.gnome.mutter # this is necessary to control fractional scaling
      pkgs.gnome.nautilus
    ];
  };
  services.gnome.games.enable = true; # install GNOME games
  services.gnome.core-developer-tools.enable = true; # install GNOME core dev tools

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
    pkgs.qgnomeplatform
    pkgs.qgnomeplatform-qt6
    pkgs.wev
  ];
}
