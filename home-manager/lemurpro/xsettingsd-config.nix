{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/xsettingsd/xsettingsd.conf".text = ''
        Gdk/UnscaledDPI 98304
        Gdk/WindowScalingFactor 1
        Gtk/AutoMnemonics 1
        Gtk/ButtonImages 0
        Gtk/CanChangeAccels 0
        Gtk/ColorPalette "black:white:gray50:red:purple:blue:light blue:green:yellow:orange:lavender:brown:goldenrod4:dodger blue:pink:light green:gray10:gray30:gray75:gray90"
        Gtk/ColorScheme ""
        Gtk/CursorBlinkTimeout 10
        Gtk/CursorThemeName "Adwaita"
        Gtk/CursorThemeSize 24
        Gtk/DecorationLayout "menu:minimize,close"
        Gtk/DialogsUseHeader 1
        Gtk/EnableAnimations 1
        Gtk/EnablePrimaryPaste 0
        Gtk/FontName "IBM Plex Sans 11"
        Gtk/IMModule "ibus"
        Gtk/IMPreeditStyle "callback"
        Gtk/IMStatusStyle "callback"
        Gtk/KeynavUseCaret 0
        Gtk/KeyThemeName "Default"
        Gtk/MenuBarAccel "F10"
        Gtk/MenuImages 0
        Gtk/Modules ""
        Gtk/OverlayScrolling 1
        Gtk/RecentFilesEnabled 1
        Gtk/RecentFilesMaxAge -1
        Gtk/ShellShowsAppMenu 0
        Gtk/ShellShowsDesktop 0
        Gtk/ShowInputMethodMenu 0
        Gtk/ShowStatusShapes 0
        Gtk/ShowUnicodeMenu 0
        Gtk/TimeoutInitial 200
        Gtk/TimeoutRepeat 20
        Gtk/TitlebarDoubleClick "toggle-maximize"
        Gtk/TitlebarMiddleClick "none"
        Gtk/TitlebarRightClick "menu"
        Gtk/ToolbarIconSize "large"
        Gtk/ToolbarStyle "both-horiz"
        Net/CursorBlink 1
        Net/CursorBlinkTime 1200
        Net/DndDragThreshold 8
        Net/DoubleClickTime 400
        Net/EnableEventSounds 1
        Net/EnableInputFeedbackSounds 0
        Net/FallbackIconTheme "gnome"
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
