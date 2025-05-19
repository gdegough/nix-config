{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/autostart/pasystray.desktop".text = ''
      [Desktop Entry]
      Version=1.0
      Name=PulseAudio System Tray
      GenericName=
      Comment=An Applet for PulseAudio
      Exec=pasystray
      Icon=pasystray
      StartupNotify=true
      Type=Application
      Categories=AudioVideo;Audio;
      Keywords=pulseaudio;tray;system tray;applet;volume;
      NotShowIn=GNOME;KDE;cosmic;
      ShowIn=sway;hyprland;
    '';
    ".config/autostart/nm-applet.desktop".text = ''
      [Desktop Entry]
      Name=NetworkManager Applet
      Comment=Manage your network connections
      Icon=nm-device-wireless
      Exec=nm-applet
      Terminal=false
      Type=Application
      NoDisplay=true
      NotShowIn=KDE;GNOME;COSMIC;
      X-GNOME-UsesNotifications=true
    '';
    ".config/autostart/blueman.desktop".text = ''
      Name=Blueman Applet
      Comment=Blueman Bluetooth Manager
      Icon=blueman
      Exec=blueman-applet
      Terminal=false
      Type=Application
      Categories=
      NotShowIn=GNOME;COSMIC;KDE;
    '';
  };
}
