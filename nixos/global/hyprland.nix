{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: 
let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of hyprland config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this restarts some user services to make sure they have the correct environment variables
  dbus-hyprland-environment = pkgs.writeTextFile {
    name = "dbus-hyprland-environment";
    destination = "/bin/dbus-hyprland-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland
      systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland
      systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland
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
  };
  security = {
    pam.services.swaylock = {};
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    blueman
    dbus-hyprland-environment
    dex
    glib
    grim
    kitty
    mako
    pasystray
    pavucontrol
    playerctl
    polkit_gnome
    rofi-wayland
    slurp
    swayidle
    swaylock
    waybar
    wayland
    wdisplays
    wev
    wl-clipboard
    xdg-utils
    xsettingsd
  ];
  # enable sway window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
