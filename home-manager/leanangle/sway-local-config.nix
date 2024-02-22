{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/sway/monitor.conf".text = ''
      # Monitor definition
      output HDMI-A-1 resolution 3840x2160@59.997Hz scale 1.5 position 0,0
    '';
  };
}
