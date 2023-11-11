{ 
  inputs
  , config
  , lib
  , pkgs
  , modulesPath
  , ...
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
      ''f+ /run/gdm/.config/monitors.xml - gdm gdm - <monitors version="2"><configuration><logicalmonitor><x>0</x><y>0</y><scale>1</scale><primary>yes</primary><monitor><monitorspec><connector>HDMI-1</connector><vendor>AUS</vendor><product>ASUS VG289Q1A</product><serial>0x0001afc5</serial></monitorspec><mode><width>3840</width><height>2160</height><rate>59.997</rate></mode></monitor></logicalmonitor></configuration></monitors>''
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
