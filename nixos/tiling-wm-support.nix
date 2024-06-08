{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
let
  # currently, there is some friction between sway/hyprland and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Adq-gtk3-dark'
    '';
  };
in
{
  # some systemd setup
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
      };
    };
    user.services.xsettingsd = {
      description = "XSETTINGS-protocol daemon";
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
          ExecStart = "${pkgs.xsettingsd}/bin/xsettingsd";
          Slice = "session.slice";
      };
    };
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    configure-gtk
    pkgs.polkit_gnome
    pkgs.xsettingsd
  ];
}
