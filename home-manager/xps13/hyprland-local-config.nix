{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/hypr/monitor.conf".text = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = eDP-1, 1920x1080, 0x0, 1
    '';
  };
}
