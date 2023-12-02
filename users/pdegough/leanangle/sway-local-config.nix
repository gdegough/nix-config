{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/sway/outputs.conf".text = ''
      # SwayWM outputs configuration. For detailed information type "man sway"
      # For a list of devices run: swaymsg -t get_outputs

      # Monitor definition
      output HDMI-A-1 resolution 3840x2160@59.997Hz scale 1.5 position 0,0
    '';
  };
}
