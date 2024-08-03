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
      Comment=OpenRGB 0.9, for controlling RGB lighting.
      Icon=OpenRGB
      Name=OpenRGB
      StartupNotify=true
      Terminal=false
      Type=Application
      Exec=openrgb --client --device "ASUS TUF GAMING Z590-PLUS WIFI" --mode Direct --zone 0 --zone 1 --size 120 --zone 2 --size 120 --startminimized --profile "lightning"
    '';
  };
}
