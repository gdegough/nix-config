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
    desktopManager.plasma5.enable = true; # KDE
    desktopManager.plasma5.useQtScaling = true; # Enable HiDPI scaling in Qt
    displayManager.sddm.enable = false; # sddm
    # displayManager.defaultSession = "plasmawayland"; # Make plasma-wayland the default session
  };

  # make QT apps look similar to GNOME desktop
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  programs.dconf.enable = true; # Enable gtk themes, etc., in Wayland apps

  environment.systemPackages = [
    pkgs.adwaita-qt
    pkgs.adwaita-qt6
    pkgs.adw-gtk3
    pkgs.qgnomeplatform
    pkgs.qgnomeplatform-qt6
    pkgs.wev
  ];
}
