{
  config,
  pkgs,
  ...
}:
{
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = [
    pkgs.megasync
  ];
  home.file = {
    ".config/autostart/megasync-start.desktop".text = ''
      [Desktop Entry]
      Categories=Network;System;
      Comment[en_US]=Easy automated syncing between your computers and your MEGA cloud drive.
      Comment=Easy automated syncing between your computers and your MEGA cloud drive.
      Exec=sh -c "sleep 30;exec megasync --nogfx"
      #Exec=megasync --nogfx
      GenericName[en_US]=File Synchronizer
      GenericName=File Synchronizer
      Icon=mega
      MimeType=
      Name[en_US]=MEGASync
      Name=MEGASync
      Path=
      StartupNotify=false
      Terminal=false
      TerminalOptions=
      TryExec=megasync
      Type=Application
      Version=1.0
      X-DBUS-ServiceName=
      X-DBUS-StartupType=
      X-GNOME-Autostart-Delay=60
    '';
  };
}
