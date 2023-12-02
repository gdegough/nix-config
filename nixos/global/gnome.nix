{ 
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    # GNOME and gdm
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    adwaita-qt
    adwaita-qt6
    gnome.networkmanager-l2tp
    qgnomeplatform
    qgnomeplatform-qt6
    wev
  ];
}
