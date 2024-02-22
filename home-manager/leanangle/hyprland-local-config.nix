{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/hypr/monitor.conf".text = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = HDMI-A-1, 3840x2160@59.997Hz, 0x0, 1.5
    '';
  };
}
