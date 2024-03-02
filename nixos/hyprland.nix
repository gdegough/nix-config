{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of hyprland config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this restarts some user services to make sure they have the correct environment variables
  dbus-environment-hyprland = pkgs.writeTextFile {
    name = "dbus-environment-hyprland";
    destination = "/bin/dbus-environment-hyprland";
    executable = true;

    text = ''
      systemctl --user import-environment DISPLAY WAYLAND_DISPLAY
      dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland
      systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland
      systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland
    '';
  };

  # sh script to let help hyprland adjust volume using wireplumber
  volume-helper-hyprland = pkgs.writeTextFile {
    name = "volume-helper-hyprland";
    destination = "/bin/volume-helper-hyprland";
    executable = true;

    text = ''
      #!/usr/bin/env sh

      if ! command -v wpctl >/dev/null; then
          exit 0;
      fi

      # wpctl output depends on the current locale
      export LANG=C.UTF-8 LC_ALL=C.UTF-8

      DEFAULT_STEP=5
      LIMIT=''${LIMIT:-100}
      SINK="@DEFAULT_AUDIO_SINK@"

      clamp() {
          awk '$1<0{$1=0}$1>$2{$1=$2} {print $1}' <<<"$1 $LIMIT"
      }

      get_sink_volume() { # sink
          ret=$(wpctl get-volume "$1")
          # get first percent value
          ret=''${ret%%%*}
          ret=''${ret##* }
          ret=$(echo "$ret * 100" | `which bc`)
          ret=''${ret%%.??}
          echo "$ret"
          unset ret
      }

      CHANGE=""
      VOLUME=-1

      while true; do
          case $1 in
              --sink)
                  SINK=''${2:-$SINK}
                  shift;;
              -l|--limit)
                  LIMIT=''${2:-$LIMIT}
                  shift;;
              --set-volume)
                  VOLUME=$2
                  shift;;
              -i|--increase)
                  CHANGE=''${2:-$DEFAULT_STEP}
                  shift;;
              -d|--decrease)
                  CHANGE=-''${2:-$DEFAULT_STEP}
                  shift;;
              *)
                  break
                  ;;
          esac
          shift
      done

      if [ ! -z $CHANGE ]; then
          VOLUME=$(get_sink_volume "$SINK")
          VOLUME=$(( $VOLUME+$CHANGE ))
          wpctl set-volume "$SINK" "$(clamp "$VOLUME")%"
      else
          wpctl set-volume "$SINK" "$(clamp "$VOLUME")%"
      fi

      # Display desktop notification

      if ! command -v ${pkgs.libnotify}/bin/notify-send >/dev/null; then
          exit 0;
      fi

      VOLUME=$(get_sink_volume "$SINK")
      TEXT="Volume: ''${VOLUME}%"
      case $(wpctl get-volume "$SINK") in
          *[MUTED])
              TEXT="Volume: muted"
              VOLUME=0
              ;;
      esac

      ${pkgs.libnotify}/bin/notify-send \
          --app-name hyprland \
          --expire-time 800 \
          --hint string:x-canonical-private-synchronous:volume \
          --hint "int:value:$VOLUME" \
          --transient \
          "''${TEXT}"
    '';
  };

  # sh script to prompt user before exiting hyprland
  exit-prompt-hyprland = pkgs.writeTextFile {
    name = "exit-prompt-hyprland";
    destination = "/bin/exit-prompt-hyprland";
    executable = true;

    text = ''
      #!/usr/bin/env bash

      a=$(echo "No|Yes" | rofi -i -sep "|" -dmenu -p "Exit Hyprland? " -l 2 -only-match -location 0 -theme+window+width 10%)
      case $a in 
          "Yes")
              hyprctl dispatch exit 1
              ;;
          "No") 
              ;; 
      esac
    '';
  };
in
{
  security = {
    pam.services.swaylock = {};
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
#    pkgs.blueman
    pkgs.cliphist
    dbus-environment-hyprland
    pkgs.dex
    pkgs.dunst
    pkgs.glib
    pkgs.grim
    exit-prompt-hyprland
    pkgs.kitty
    pkgs.mako
    pkgs.pasystray
    pkgs.pavucontrol
    pkgs.playerctl
    pkgs.rofi-wayland
    pkgs.slurp
    pkgs.swayidle
    pkgs.swaylock
    volume-helper-hyprland
    pkgs.waybar
    pkgs.wayland
    pkgs.wdisplays
    pkgs.wev
    pkgs.wl-clipboard
    pkgs.xdg-utils
  ];
  # enable hyprland window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
