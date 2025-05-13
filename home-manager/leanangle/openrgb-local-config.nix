{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/autostart/OpenRGB.desktop".text = ''
      [Desktop Entry]
      Categories=Utility;
      Comment=OpenRGB for controlling RGB lighting.
      Icon=OpenRGB
      Name=OpenRGB
      StartupNotify=true
      Terminal=false
      Type=Application
      Exec=openrgb --client --startminimized --profile "lightning"
    '';
  };
}
