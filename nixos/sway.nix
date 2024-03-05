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
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-environment-sway = pkgs.writeTextFile {
    name = "dbus-environment-sway";
    destination = "/bin/dbus-environment-sway";
    executable = true;

    text = ''
      systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
      dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # sh script to grab config files from multiple locations
  layered-include = pkgs.writeTextFile {
    name = "layered-include";
    destination = "/bin/layered-include";
    executable = true;

    text = ''
      #!/usr/bin/env python3
      """
      A helper for doing the config layering with sway style `include` expressions
      (which are pretty much just shell/wordexp(3) patterns).

      The script is meant to be invoked from sway (i3?) config as following
      ```
      include '$(/path/to/the/script "/path1/*.conf" "/path2/*.conf" ...)'
      ```
      (note the quoting, it is important), expand each expression to a list of files
      and layer them in a way that the files with the same name matched by a later
      patterns loaded over the earlier matches.
      """

      import os
      import sys
      from hashlib import sha256
      from glob import iglob
      from os.path import basename, expandvars, join as join_paths


      def wordexp(value: str):
          """A very bad wordexp(3) approximation"""
          value = expandvars(value)
          return iglob(value)


      configs: dict[str, str] = {}

      for arg in sys.argv[1:]:
          # Expand the expression and collect the paths while overwriting previously
          # collected entries with the same filename.
          # Our internal wordexp is quite incomplete, but the calling wordexp should
          # do all the heavy lifting and expand the variables.
          for inc in wordexp(arg):
              configs[basename(inc)] = inc

      # Write collected paths as an include directives to a temporary file.
      # This step is required because the filenames may contain $IFS characters
      # (whitespaces — I don't expect this to happen, but can't exclude the
      # possibility), and wordexp(3) will handle that quite bad.
      dirname = join_paths(os.environ['XDG_RUNTIME_DIR'], 'sway')
      os.makedirs(dirname, exist_ok=True)
      fnhash = sha256("\n".join(sys.argv).encode("UTF-8"))
      fname = join_paths(dirname, f"layered-include-{str(fnhash.hexdigest())}.conf")
      fd = os.open(fname, os.O_CREAT | os.O_TRUNC | os.O_WRONLY, mode=0o600)
      with open(fd, mode="w", encoding="UTF-8") as file:
          for key in sorted(configs):
              file.write(f"include '{configs[key]}'\n")
      # Send the temporary file name back to a calling wordexp
      print(fname)
    '';
  };

  # sh script to let help sway adjust volume using wireplumber
  volume-helper-sway = pkgs.writeTextFile {
    name = "volume-helper-sway";
    destination = "/bin/volume-helper-sway";
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
          --app-name sway \
          --expire-time 800 \
          --hint string:x-canonical-private-synchronous:volume \
          --hint "int:value:$VOLUME" \
          --transient \
          "''${TEXT}"
    '';
  };
  # sh script to prompt user before exiting sway
  exit-prompt-sway = pkgs.writeTextFile {
    name = "exit-prompt-sway";
    destination = "/bin/exit-prompt-sway";
    executable = true;

    text = ''
      #!/usr/bin/env bash

      a=$(echo "No|Yes" | rofi -i -sep "|" -dmenu -p "Exit Sway? " -l 2 -only-match -location 0 -theme+window+width 10%)
      case $a in 
          "Yes")
              swaymsg exit
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
    dbus-environment-sway
    pkgs.dex
    pkgs.dunst
    exit-prompt-sway
    pkgs.feh
    pkgs.foot
    pkgs.glib
    pkgs.grim
    layered-include
    pkgs.mako
    pkgs.pasystray
    pkgs.pavucontrol
    pkgs.playerctl
    pkgs.rofi-wayland
    pkgs.slurp
    pkgs.swayidle
    pkgs.swaylock
    volume-helper-sway
    pkgs.waybar
    pkgs.wayland
    pkgs.wdisplays
    pkgs.wev
    pkgs.wl-clipboard
    pkgs.xdg-utils
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
