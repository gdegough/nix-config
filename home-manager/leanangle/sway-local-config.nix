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
    ".config/sway/config.d/27-gtk-scratchpad.conf".text = ''
      # SwayWM scratchpad configuration. For detailed information type "man sway"
      #
      # Scratchpad:
      #
      # Sway has a "scratchpad", which is a bag of holding for windows.
      # You can send windows there and get them back later.

      # Password manager
      for_window [class="Bitwarden"] move window to scratchpad
      bindsym $mod+z [class="Bitwarden"] scratchpad show, move position center, resize set 900 600
      #exec "flatpak run --branch=stable --arch=x86_64 --command=bitwarden --file-forwarding com.bitwarden.desktop"
      exec "GDK_DPI_SCALE=0.6 bitwarden"

      # tidal-hifi
      #for_window [class="tidal-hifi"] move window to scratchpad
      #bindsym $mod+p [class="tidal-hifi"] scratchpad show, move position center, resize set 1280 800
      #exec "flatpak run --branch=stable --arch=x86_64 --command=com.mastermindzh.tidal-hifi com.mastermindzh.tidal-hifi"
      #exec "GDK_DPI_SCALE=0.6 tidal-hifi"

      # Plexamp
      for_window [class="Plexamp"] move window to scratchpad
      bindsym $mod+p [class="Plexamp"] scratchpad show, move position center, resize set 250 500
      #exec "flatpak run --branch=stable --arch=x86_64 --command=startplexamp com.plexamp.Plexamp"
      exec "GDK_DPI_SCALE=0.6 plexamp"
    '';
  };
}
