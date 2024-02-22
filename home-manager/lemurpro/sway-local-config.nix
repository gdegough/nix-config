{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/sway/monitor.conf".text = ''
      # Monitor definition
      output eDP-1 resolution 1920x1080 scale 1 position 0,0
   '';
  };
}
