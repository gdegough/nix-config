{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/hypr/monitor.conf".text = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = HDMI-A-3, 3840x2160@59.997Hz, 0x0, 1.5

      # unscale XWayland
      xwayland { 
        force_zero_scaling = true 
      }

      # toolkit-specific scale
      env = GDK_SCALE,2
      env = GDK_DPI_SCALE,0.6
      env = XCURSOR_SIZE,24
    '';
  };
}
