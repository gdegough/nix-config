{ 
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
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
  systemd = {
    # set gdm monitor configuration and link for ipsec l2tp secrets
    tmpfiles.rules = [
      ''f+ /run/gdm/.config/monitors.xml - gdm gdm - <monitors version="2"><configuration><logicalmonitor><x>0</x><y>0</y><scale>1</scale><primary>yes</primary><monitor><monitorspec><connector>eDP-1</connector><vendor>CMN</vendor><product>0x1408</product><serial>0x00000000</serial></monitorspec><mode><width>1920</width><height>1080</height><rate>60.000</rate></mode></monitor></logicalmonitor></configuration></monitors>''
    ];
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
