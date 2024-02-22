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
      NotShowIn=GNOME;KDE;
      ShowIn=sway;hyprland;
    '';
  };
}
