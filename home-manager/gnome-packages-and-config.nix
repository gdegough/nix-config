{
  config,
  lib,
  pkgs,
  ...
}:
with lib.hm.gvariant;
{
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = [
    pkgs.dconf2nix
    pkgs.gcolor3
    pkgs.gnome.gnome-tweaks
    pkgs.chrome-gnome-shell
    pkgs.gnome-browser-connector
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.internet-radio
    pkgs.gnomeExtensions.lock-keys
  ];
  home.file = {
    ".config/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-application-prefer-dark-theme=true
    '';
    ".config/gtk-4.0/settings.ini".text = ''
        [Settings]
        gtk-application-prefer-dark-theme=true
    '';
  };
  dconf.settings = {
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      document-font-name = "IBM Plex Sans 11";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "IBM Plex Sans 11";
      gtk-enable-primary-paste = false;
      monospace-font-name = "IBM Plex Mono 11";
    };

    "org/gnome/desktop/media-handling" = {
      autorun-x-content-ignore = [];
      autorun-x-content-open-folder = [];
      autorun-x-content-start-app = [ "x-content/ostree-repository" ];
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.5891472868217054;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 900;
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      maximize = [];
      minimize = [ "<Super>comma" ];
      move-to-monitor-down = [];
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-monitor-up = [];
      move-to-workspace-left = [ "<Shift><Super>Up" ];
      move-to-workspace-right = [ "<Shift><Super>Down" ];
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-to-workspace-left = [ "<Control><Super>Up" ];
      switch-to-workspace-right = [ "<Control><Super>Down" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      toggle-maximized = [ "<Super>m" ];
      unmaximize = [];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,close";
      titlebar-font = "IBM Plex Sans Semi-Bold 11";
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
      experimental-features = [ "scale-monitor-framebuffer" "kms-modifiers" ];
    };

    "org/gnome/mutter/keybindings" = {
      switch-monitor = [ "XF86Display" ];
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 890 550 ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ 
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" 
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" 
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" 
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/" 
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/" 
      ];
      email = [ "<Super>e" ];
      help = [];
      home = [ "<Super>f" ];
      www = [ "<Super>b" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "gnome-terminal";
      name = "Launch terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>c";
      command = "qalculate-gtk";
      name = "Launch qalculate";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>p";
      command = "plexamp";
      name = "Launch mediaplayer";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "<Super>backslash";
      command = "easyeffects";
      name = "Launch easyeffects";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      binding = "<Super>z";
      command = "bitwarden";
      name = "Launch bitwarden";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 2;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = true;
      background-opacity = 0.8;
      click-action = "focus-minimize-or-previews";
      custom-theme-shrink = true;
      dash-max-icon-size = 48;
      disable-overview-on-startup = true;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      hot-keys = false;
      intellihide-mode = "ALL_WINDOWS";
      preferred-monitor = -2;
      preferred-monitor-by-connector = "HDMI-1";
      show-trash = false;
    };

    "org/gnome/shell/keybindings" = {
      toggle-message-tray = [];
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 140;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      view-type = "list";
      window-size = mkTuple [ 861 562 ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 155;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 26 23 ];
      window-size = mkTuple [ 1231 902 ];
    };
  };
}
