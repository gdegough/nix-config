{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.kdePackages.yakuake
  ];
  home.file = {
    ".config/autostart/org.kde.yakuake.desktop".text = ''
      [Desktop Entry]
      Categories=Qt;KDE;System;TerminalEmulator;
      Comment=A drop-down terminal emulator based on KDE Konsole technology.
      DBusActivatable=true
      Exec=yakuake
      GenericName=Drop-down Terminal
      Icon=yakuake
      Name=Yakuake
      Terminal=false
      Type=Application
      X-DBUS-ServiceName=org.kde.yakuake
      X-DBUS-StartupType=Unique
      X-KDE-StartupNotify=false
      NotShowIn=GNOME;hyprland;sway;cosmic;
    '';
  };
}
