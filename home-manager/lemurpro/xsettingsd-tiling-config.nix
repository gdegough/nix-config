{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/xsettingsd/xsettingsd-tiling.conf".text = ''
        Gdk/UnscaledDPI 98304
        Gdk/WindowScalingFactor 1
        Gtk/ButtonImages 0
        Gtk/CursorThemeName "Adwaita"
        Gtk/CursorThemeSize 24
        Gtk/DecorationLayout "menu:minimize,close"
        Gtk/EnableAnimations 1
        Gtk/FontName "IBM Plex Sans 10"
        Gtk/MenuImages 1
        Net/IconThemeName "Adwaita"
        Net/SoundThemeName ""
        Net/ThemeName "Adwaita"
        Xft/Antialias 1
        Xft/DPI 98304
        Xft/Hinting 1
        Xft/HintStyle "hintslight"
        Xft/RGBA "none"
    '';
  };
}
