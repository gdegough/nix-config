{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/waybar/scripts/get_kbdlayout.sh".executable = true;
    ".config/waybar/scripts/get_kbdlayout.sh".text = ''
      language=$(swaymsg -r -t get_inputs | awk '/1:1:AT_Translated_Set_2_keyboard/;/xkb_active_layout_name/' | grep -A1 '\b1:1:AT_Translated_Set_2_keyboard\b'    | grep "xkb_active_layout_name" | awk -F '"' '{print $4}')
      echo $language
    '';
    ".config/waybar/scripts/get_media.sh".executable = true;
    ".config/waybar/scripts/get_media.sh".text = ''
      media=$(playerctl metadata -f "({{playerName}}) {{artist}} - {{title}}")
      player_status=$(playerctl status)

      if [[ $player_status = "Playing" ]]
      then
          song_status=''
      elif [[ $player_status = "Paused" ]]
      then
          song_status=''
      else
          song_status='Music stopped'
      fi

      echo -e "$song_status $media"
    '';
    ".config/waybar/scripts/get_network.sh".executable = true;
    ".config/waybar/scripts/get_network.sh".text = ''
      network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
      interface_easyname=$(dmesg | grep $network | grep renamed | awk 'NF>1{print $NF}')
      ping=$(ping -c 1 www.google.com | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)

      if ! [ $network ]
      then
         network_active="⛔"
      elif [[ $interface_easyname == *"wlan"* ]]
      then
         network_active=""
      else
         network_active=""
      fi

      echo "{\"text\": \""$network_active $interface_easyname \\n   \($ping ms\)"\"}"
    '';
    ".config/waybar/scripts/get_ping.sh".executable = true;
    ".config/waybar/scripts/get_ping.sh".text = ''
      ping=$(ping -c 1 www.google.com | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)
      echo "($ping ms)"
    '';
    ".config/waybar/scripts/mediaplayer.sh".executable = true;
    ".config/waybar/scripts/mediaplayer.sh".text = ''
      #!/usr/bin/env sh

      spotify_player_status=$(playerctl --player spotify status 2> /dev/null)
      plexamp_player_status=$(playerctl --player Plexamp status 2> /dev/null)

      if [ "$spotify_player_status" = "Playing" ]; then
          playerctl metadata --player spotify --format "{\"text\": \"{{artist}} - {{markup_escape(title)}} ({{markup_escape(duration(position))}}/{{markup_escape(duration(mpris:length))}})\", \"alt\": \"{{playerName}}\", \"tooltip\": \"{{markup_escape(title)}}\", \"class\": \"custom-{{playerName}}\"}"
      elif [ "$plexamp_player_status" = "Playing" ]; then
          playerctl metadata --player Plexamp --format "{\"text\": \"{{artist}} - {{markup_escape(title)}} ({{markup_escape(duration(position))}}/{{markup_escape(duration(mpris:length))}})\", \"alt\": \"{{playerName}}\", \"tooltip\": \"{{markup_escape(title)}}\", \"class\": \"custom-{{playerName}}\"}"
      else
          exit 1
      fi
    '';
    ".config/waybar/scripts/mediaplayer.py".executable = true;
    ".config/waybar/scripts/mediaplayer.py".text = ''
      #!/usr/bin/env python3
      import gi
      gi.require_version("Playerctl", "2.0")
      from gi.repository import Playerctl, GLib
      from gi.repository.Playerctl import Player
      import argparse
      import logging
      import sys
      import signal
      import gi
      import json
      import os
      from typing import List

      logger = logging.getLogger(__name__)

      def signal_handler(sig, frame):
          logger.info("Received signal to stop, exiting")
          sys.stdout.write("\n")
          sys.stdout.flush()
          # loop.quit()
          sys.exit(0)


      class PlayerManager:
          def __init__(self, selected_player=None, excluded_player=[]):
              self.manager = Playerctl.PlayerManager()
              self.loop = GLib.MainLoop()
              self.manager.connect(
                  "name-appeared", lambda *args: self.on_player_appeared(*args))
              self.manager.connect(
                  "player-vanished", lambda *args: self.on_player_vanished(*args))

              signal.signal(signal.SIGINT, signal_handler)
              signal.signal(signal.SIGTERM, signal_handler)
              signal.signal(signal.SIGPIPE, signal.SIG_DFL)
              self.selected_player = selected_player
              self.excluded_player = excluded_player.split(',') if excluded_player else []

              self.init_players()

          def init_players(self):
              for player in self.manager.props.player_names:
                  if player.name in self.excluded_player:
                      continue
                  if self.selected_player is not None and self.selected_player != player.name:
                      logger.debug(f"{player.name} is not the filtered player, skipping it")
                      continue
                  self.init_player(player)

          def run(self):
              logger.info("Starting main loop")
              self.loop.run()

          def init_player(self, player):
              logger.info(f"Initialize new player: {player.name}")
              player = Playerctl.Player.new_from_name(player)
              player.connect("playback-status",
                             self.on_playback_status_changed, None)
              player.connect("metadata", self.on_metadata_changed, None)
              self.manager.manage_player(player)
              self.on_metadata_changed(player, player.props.metadata)

          def get_players(self) -> List[Player]:
              return self.manager.props.players

          def write_output(self, text, player):
              logger.debug(f"Writing output: {text}")

              output = {"text": text,
                        "class": "custom-" + player.props.player_name,
                        "alt": player.props.player_name}

              sys.stdout.write(json.dumps(output) + "\n")
              sys.stdout.flush()

          def clear_output(self):
              sys.stdout.write("\n")
              sys.stdout.flush()

          def on_playback_status_changed(self, player, status, _=None):
              logger.debug(f"Playback status changed for player {player.props.player_name}: {status}")
              self.on_metadata_changed(player, player.props.metadata)

          def get_first_playing_player(self):
              players = self.get_players()
              logger.debug(f"Getting first playing player from {len(players)} players")
              if len(players) > 0:
                  # if any are playing, show the first one that is playing
                  # reverse order, so that the most recently added ones are preferred
                  for player in players[::-1]:
                      if player.props.status == "Playing":
                          return player
                  # if none are playing, show the first one
                  return players[0]
              else:
                  logger.debug("No players found")
                  return None

          def show_most_important_player(self):
              logger.debug("Showing most important player")
              # show the currently playing player
              # or else show the first paused player
              # or else show nothing
              current_player = self.get_first_playing_player()
              if current_player is not None:
                  self.on_metadata_changed(current_player, current_player.props.metadata)
              else:    
                  self.clear_output()

          def on_metadata_changed(self, player, metadata, _=None):
              logger.debug(f"Metadata changed for player {player.props.player_name}")
              player_name = player.props.player_name
              artist = player.get_artist()
              album = player.get_album()
              title = player.get_title()
              title = title.replace("&", "&amp;")

              track_info = ""
              if player_name == "spotify" and "mpris:trackid" in metadata.keys() and ":ad:" in player.props.metadata["mpris:trackid"]:
                  track_info = "Advertisement"
              elif artist is not None and album is not None and title is not None:
                  track_info = f"{artist} - {album} - {title}"
              elif artist is not None and title is not None:
                  track_info = f"{artist} - {title}"
              else:
                  track_info = title

              if track_info:
                  if player.props.status == "Playing":
                      track_info = "\u23f5 " + track_info
                  else:
                      track_info = "\u23f8 " + track_info
              # only print output if no other player is playing
              current_playing = self.get_first_playing_player()
              if current_playing is None or current_playing.props.player_name == player.props.player_name:
                  self.write_output(track_info, player)
              else:
                  logger.debug(f"Other player {current_playing.props.player_name} is playing, skipping")

          def on_player_appeared(self, _, player):
              logger.info(f"Player has appeared: {player.name}")
              if player.name in self.excluded_player:
                  logger.debug(
                      "New player appeared, but it's in exclude player list, skipping")
                  return
              if player is not None and (self.selected_player is None or player.name == self.selected_player):
                  self.init_player(player)
              else:
                  logger.debug(
                      "New player appeared, but it's not the selected player, skipping")

          def on_player_vanished(self, _, player):
              logger.info(f"Player {player.props.player_name} has vanished")
              self.show_most_important_player()

      def parse_arguments():
          parser = argparse.ArgumentParser()

          # Increase verbosity with every occurrence of -v
          parser.add_argument("-v", "--verbose", action="count", default=0)

          parser.add_argument("-x", "--exclude", "- Comma-separated list of excluded player")

          # Define for which player we"re listening
          parser.add_argument("--player")

          parser.add_argument("--enable-logging", action="store_true")

          return parser.parse_args()


      def main():
          arguments = parse_arguments()

          # Initialize logging
          if arguments.enable_logging:
              logfile = os.path.join(os.path.dirname(
                  os.path.realpath(__file__)), "media-player.log")
              logging.basicConfig(filename=logfile, level=logging.DEBUG,
                                  format="%(asctime)s %(name)s %(levelname)s:%(lineno)d %(message)s")

          # Logging is set by default to WARN and higher.
          # With every occurrence of -v it's lowered by one
          logger.setLevel(max((3 - arguments.verbose) * 10, 0))

          logger.info("Creating player manager")
          if arguments.player:
              logger.info(f"Filtering for player: {arguments.player}")
          if arguments.exclude:
              logger.info(f"Exclude player {arguments.exclude}")

          player = PlayerManager(arguments.player, arguments.exclude)
          player.run()


      if __name__ == "__main__":
          main()
    '';
    ".config/waybar/scripts/nowplaying".executable = true;
    ".config/waybar/scripts/nowplaying".text = ''
      #!/usr/bin/env bash

      set -euo pipefail

      title=$(playerctl metadata title)
      artist=$(playerctl metadata artist)
      player_status=$(playerctl status)

      if [ "$player_status" = "Playing" ]; then
          printf "%s by %s" "$title" "$artist" 2>/dev/null
      else
          printf "$player_status"
      fi
    '';
    ".config/waybar/scripts/pw-volume-monitor".executable = true;
    ".config/waybar/scripts/pw-volume-monitor".text = ''
      #!/usr/bin/env bash

      #
      # A script to display the pipewire/wireplumber volume in Waybar
      # 
      # This is an optimised bash script. wpctl is called once every $DELAY seconds 
      # to obtain the default sink volume. No other process is started. 
      #
      # The waybar configuration should look like that 
      # 
      # "custom/pipewire": {
      #    "tooltip": false,
      #    "max-length": 6,
      #    "restart-interval": 10,
      #    "exec": "exec $HOME/path-to/pw-volume-monitor"
      # },
      #

      # The script is not properly terminated when waybar is restarted.
      # This is probably because it is started via '/bin/sh -c "..."' and
      # /bin/sh does not always terminate its children processes when it dies.

      # A trick is to declare the waybar custom module with
      #     "exec": "exec path-to-this-script"
      # The second 'exec' is the builtin command that tells /bin/sh to terminate
      # and replace itself by the script. Consequently, waybar will send the
      # termination signal directly to the script.
      # That trick also save a bit of resources (one less process in the background)
      #

      # Another simple trick is to make the shell script terminate as soon as
      # a command fails. In that case, that the 'echo' commands will fail 
      # when STDOUT ceases to be valid.
      # Anyway, this is always a good idea to stop a script when something
      # goes wrong (e.g. wpctl or pipewire not working as expected)
      set -e

      # Snore is a pure bash implementation of 'sleep' that does not start any subprocess
      # https://blog.dhampir.no/content/sleeping-without-a-subprocess-in-bash-and-how-to-sleep-forever
      snore()
      {
          local IFS
          [[ -n "''${_snore_fd:-}" ]] || { exec {_snore_fd}<> <(:) && read -r -t 0 -u $_snore_fd; } 2>/dev/null
          read ''${1:+-t "$1"} -u $_snore_fd || :
      }


      # Delay in seconds between updates
      DELAY=0.5

      # ICON will be set to an array containing the speaker icons for mute, low, medium, high   
      # Multiple sets of text icons are possible: 

      # no icons
      SET0=("" "" "" "") 


      # From the Unicode subset 'Miscellaneous Symbols And Pictographs' (aka emojis).
      # On Linux, a few fonts such as Noto Emoji are providing them in full color. 
      # VS15 AND VS16 are variation selectors for emoji. If multiple fonts are providing
      # emojis, they could be used to select either a monochrome or a color version.
      VS15=$'\uFE0E'
      VS16=$'\uFE0F'
      VS=""  # replace by $VS15 or $VS16 if needed
      SET1=(
          $'\U0001F507'"$VS"
          $'\U0001F508'"$VS"
          $'\U0001F509'"$VS"
          $'\U0001F50A'"$VS"
      )

      # Those are FontAwesome icons. They use the Unicode private plane and so are non standard. 
      # See also the Nerd Fonts project:
      #    https://github.com/ryanoasis/nerd-fonts
      #    https://github.com/ryanoasis/nerd-fonts/releases/
      # Those can be a bit wider than other characters so a space can be needed 
      SET2=(
          $'''
          $'\uf026 '
          $'\uf027 ' 
          $'\uf028 ' 
      )

      # Choose here your favorite icon set.
      ICON=("''${SET1[@]}")

      while snore $DELAY ; do
       
          # Is it possible to get multiple lines with wpctl?
          # Not sure but lets assume that this is possible. 
          OUT="" 
          INPUT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
          while read LINE ; do
              #
              # The output of wpctl is of the form
              #   Volume: AAAAA.BB
              # or
              #   Volume: AAAAA.BB [MUTED]
              #
              # Where A and B are sequences of digits.
              #  --> B is always of length 2 and A is often of length 1.
              #      However, Pipewire can set the volume to more than 100%
              #      so A may be bigger. 
              #
              if [[ "$LINE" =~ ^Volume:.([0-9]+)\.([0-9]{2})(([[:blank:]]\[MUTED\])?)$ ]] ; then

                  if [[ -n "$OUT" ]] ; then
                      OUT+=" "
                  fi
                  # Bash stores the parts of the matched regular expression in BASH_REMATCH
                  # 
                  # [0] = the whole match
                  # [1] = the AAAAA part
                  # [2] = the BB part
                  # [3] = the MUTED part when found 
                  #            
                  if [[ -n "''${BASH_REMATCH[3]}" ]] ; then
                      OUT+="''${ICON[0]}(MUTE)"
                  else
                      # Numbers starting with 0 are interpeted in octal.
                      # That can be prevented by specifying a decimal base as in 10#033
                      # Remark: Do not use 'let' to do the math because the script will
                      #         terminate (because of 'set -e') when the value is 0
                      volume=$(( 10#''${BASH_REMATCH[1]}''${BASH_REMATCH[2]} ))
                      if [[ $volume -gt 50 ]]; then
                          OUT+="''${ICON[3]}($volume%%)"
                      elif [[ $volume -gt 25 ]]; then
                          OUT+="''${ICON[2]}($volume%%)"
                      elif [[ $volume -gt 0 ]]; then
                          OUT+="''${ICON[1]}($volume%%)"
                      else
                          OUT+="''${ICON[1]}(---)"
                      fi
                  fi
              else
                  echo "Warning: Failed to match output of wpctl: '$LINE'" >&2
                  exit 1
              fi
          done <<<"$INPUT"

          if [[ -n "$OUT" ]] ; then
             printf "$OUT\n"
          fi
      done

      exit 0
    '';
    ".config/waybar/styles/kali-dark.css".text = ''
      * {
          border:                 none;
          border-radius:          0;
          font-family:            "IBM Plex Mono";
          font-size:              14px;
          box-shadow:             none;
          text-shadow:            none;
          transition-duration:    0s;
      }

      tooltip {
          color:		            #e6e6e6;
          background-color:	    #303540;
          text-shadow:	        none;
      }

      window#waybar {
          color:                  #e6e6e6;
          background-color:       #1f2229;
          border-bottom:          2px solid #000000;
      }

      window#waybar.solo {
          color:                  #657b83;
      }

      #workspaces {
          margin:                 0 5px;
      }

      #workspaces button {
          padding:                0 5px;
          background:             transparent;
          color:                  #93a1a1; 
          border-bottom:          2px solid transparent;
      }

      #workspaces button.focused {
          color:                  #9755b3;
          border-bottom:          2px solid #9755b3;
      }

      #workspaces button.visible {
          color:                  #9755b3;
      }

      #workspaces button.urgent {
          color:                  #dc322f;
      }

      #battery, 
      #cpu, 
      #memory, 
      #network, 
      #pulseaudio, 
      #idle_inhibitor, 
      #temperature,
      #custom-layout,
      #custom-quit,
      #backlight {
          margin:                 0px 5px 0px 5px;
      /*    min-width:              30px; */
      }

      #clock {
          margin:                 0px 5px 0px 5px;
      /*    font-size:              16px; */
          font-weight:            bold;
      }

      #battery.warning {
         color:                   #b58900;
      }

      #battery.critical {
          color:                  #dc322f;
      }

      #battery.charging {
          color:                  #859900;
      }

      #submap,
      #mode {
          margin:                 0px 5px 3px 5px;
          color:                  #fdf6e3;
          background-color:       #dc322f;
      }
    '';
    ".config/waybar/styles/pop-os.css".text = ''
      * {
          border:                 none;
          border-radius:          0;
          font-family:            "IBM Plex Mono";
          font-size:              14px;
          box-shadow:             none;
          text-shadow:            none;
          transition-duration:    0s;
      }

      tooltip {
          color:		            rgba(255, 255, 255, 1);
          background-color:	    rgba(35, 33, 33, 1);
          text-shadow:	        none;
      }

      window#waybar {
          color:                  rgba(255, 255, 255, 1);
          background-color:       rgba(35, 33, 33, 1);
          border-bottom:          2px solid rgba(87, 79, 74, 0.5);
      }

      window#waybar.solo {
          color:                  rgba(255, 255, 255, 1);
      }

      #workspaces {
          margin:                 0 5px;
      }

      #workspaces button {
          padding:                0 5px;
          background:             transparent;
          color:                  rgba(136, 136, 136, 1);
          border-bottom:          2px solid transparent;
      }

      #workspaces button.focused {
          color:                  rgba(255, 173, 0, 1);
          border-bottom:          2px solid #FFAD00;
      }

      #workspaces button.visible {
          color:                  rgba(255, 173, 0, 1);
      }

      #workspaces button.urgent {
          color:                  rgba(220, 50, 47, 1);
      }

      #submap,
      #mode, 
      #battery, 
      #cpu, 
      #memory, 
      #network, 
      #pulseaudio, 
      #idle_inhibitor, 
      #temperature,
      #custom-layout,
      #backlight {
          margin:                 0px 5px 0px 5px;
      /*    min-width:              30px; */
      }

      #clock {
          margin:                 0px 5px 0px 5px;
          font-size:              16px;
          font-weight:            bold;
      }

      #battery.warning {
         color:                   rgba(181, 137, 0, 1);
      }

      #battery.critical {
          color:                  rgba(220, 50, 47, 1);
      }

      #battery.charging {
          color:                  rgba(133, 153, 0, 1);
      }

      #mode {
      /*    color:                  rgba(220, 50, 47, 1); */
          color:                  #fdf6e3;
          background-color:       #dc322f;
      }
    '';
    ".config/waybar/styles/solarized-dark.css".text = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: IBM Plex Mono, Hack, Fira Mono, Monospace, monospace;
          /* font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif; */
          font-size: 14px;
      }

      tooltip {
          color: #93a1a1;
          background-color: #586e75;
          text-shadow: none;
      }

      window#waybar {
          background-color: #1f2229;
          /* background-color: rgba(43, 48, 59, 0.5); */
          border-bottom: 2px solid #000000;
          /* border-bottom: 3px solid rgba(100, 114, 125, 0.5); */
          color: #fdf6e3;
          /* color: #ffffff; */
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      window#waybar.empty {
          /* background-color: transparent; */
      }
      window#waybar.solo {
          color: #ffffff;
          /* color: #657b83; */
          /* background-color: #FFFFFF; */
          background-color: #000000;
      }

      window#waybar.termite {
          background-color: #3F3F3F;
      }

      window#waybar.chromium {
          background-color: #000000;
          border: none;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: #93a1a1; 
          border-bottom: 2px solid transparent;
      }

      #workspaces button.focused {
          color: #b58900;
          border-bottom: 2px solid #b58900;
      }

      #workspaces button.visible {
          color: #b58900;
      }

      #workspaces button.urgent {
          color: #dc322f;
      }

      #submap,
      #mode {
          margin:                 0px 5px 3px 5px;
          color:                  #fdf6e3;
          background-color:       #dc322f;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #mpd {
          padding: 0 10px;
          color: #ffffff;
      }

      #window,
      #workspaces {
          margin: 0 5px;
          /* margin: 0 4px; */
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          /* background-color: #64727D; */
          font-weight: bold;
      }

      #battery {
          /* background-color: #ffffff; */
          /* color: #000000; */
          color: #ffffff;
      }

      #battery.charging, #battery.plugged {
          color: #ffffff;
          /* background-color: #26A65B; */
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }

      #battery.critical:not(.charging) {
          /* background-color: #f53c3c; */
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          /* background-color: #000000; */
      }

      #cpu {
          /* background-color: #2ecc71; */
          color: #FFFFFF;
      }

      #memory {
          /* background-color: #9b59b6; */
      }

      #disk {
          /* background-color: #964B00; */
      }

      #backlight {
          /* background-color: #90b1b1; */
      }

      #network {
          /* background-color: #2980b9; */
      }

      #network.disconnected {
          /* background-color: #f53c3c; */
      }

      #pulseaudio {
          /* background-color: #f1c40f; */
          /* color: #000000; */
          color: #FFFFFF;
      }

      #pulseaudio.muted {
          /* background-color: #90b1b1; */
          /* color: #2a5c45; */
          color: #FFFFFF;
      }

      #wireplumber {
          /* background-color: #fff0f5; */
          /* color: #000000; */
          color: #FFFFFF;
      }

      #wireplumber.muted {
          /* background-color: #f53c3c; */
      }

      #custom-media {
          /* background-color: #66cc99; */
          /* color: #2a5c45; */
          color: #FFFFFF;
          min-width: 100px;
      }

      #custom-media.custom-spotify {
          /* background-color: #66cc99; */
      }

      #custom-media.custom-vlc {
          /* background-color: #ffa000; */
      }

      #temperature {
          /* background-color: #f0932b; */
      }

      #temperature.critical {
          /* background-color: #eb4d4b; */
      }

      #tray {
          /* background-color: #2980b9; */
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          /* background-color: #eb4d4b; */
      }

      #idle_inhibitor {
          /* background-color: #2d3436; */
      }

      #idle_inhibitor.activated {
          /* background-color: #ecf0f1; */
          /* color: #2d3436; */
          color: #FFFFFF;
      }

      #mpd {
          background-color: #66cc99;
          color: #2a5c45;
      }

      #mpd.disconnected {
          background-color: #f53c3c;
      }

      #mpd.stopped {
          background-color: #90b1b1;
      }

      #mpd.paused {
          background-color: #51a37a;
      }

      #language {
          /* background: #00b093; */
          /* color: #740864; */
          color: #FFFFFF;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state {
          /* background: #97e1ad; */
          /* color: #000000; */
          color: #FFFFFF;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad.empty {
          background-color: transparent;
      }
    '';
    ".config/waybar/styles/gruvbox-dark.css".text = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: IBM Plex Mono, Hack, Fira Mono, Monospace, monospace;
          /* font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif; */
          font-size: 14px;
      }

      tooltip {
          background-color: #282828;
          border: none;
          text-shadow: none;
      }

      tooltip label {
          color: #ebdbb2;
      }

      window#waybar {
          background-color: #282828;
          /* background-color: rgba(43, 48, 59, 0.5); */
          border-bottom: 2px solid #000000;
          /* border-bottom: 3px solid rgba(100, 114, 125, 0.5); */
          color: #ebdbb2;
          /* color: #ffffff; */
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      window#waybar.empty {
          /* background-color: transparent; */
      }
      window#waybar.solo {
          color: #ebdbb2;
          /* color: #657b83; */
          /* background-color: #FFFFFF; */
          background-color: #282828;
      }

      window#waybar.termite {
          background-color: #282828;
      }

      window#waybar.chromium {
          background-color: #282828;
          border: none;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: #8ec07c; 
          border-bottom: 2px solid transparent;
      }

      #workspaces button.focused {
          color: #d79921;
          border-bottom: 2px solid #d79921;
      }

      #workspaces button.visible {
          color: #d79921;
      }

      #workspaces button.urgent {
          color: #cc241d;
      }

      #submap,
      #mode {
          margin:                 0px 5px 3px 5px;
          color:                  #ebdbb2;
          background-color:       #cc241d;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #mpd {
          padding: 0 10px;
          color: #ebdbb2;
      }

      #window,
      #workspaces {
          margin: 0 5px;
          /* margin: 0 4px; */
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          /* background-color: #64727D; */
          font-weight: bold;
      }

      #battery {
          /* background-color: #ffffff; */
          /* color: #000000; */
          color: #ebdbb2;
      }

      #battery.charging, #battery.plugged {
          color: #ebdbb2;
          /* background-color: #26A65B; */
      }

      @keyframes blink {
          to {
              background-color: #282828;
              color: #000000;
          }
      }

      #battery.critical:not(.charging) {
          /* background-color: #f53c3c; */
          color: #ebdbb2;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          /* background-color: #000000; */
      }

      #cpu {
          /* background-color: #2ecc71; */
          color: #ebdbb2;
      }

      #memory {
          /* background-color: #9b59b6; */
      }

      #disk {
          /* background-color: #964B00; */
      }

      #backlight {
          /* background-color: #90b1b1; */
      }

      #network {
          /* background-color: #2980b9; */
      }

      #network.disconnected {
          /* background-color: #f53c3c; */
      }

      #pulseaudio {
          /* background-color: #f1c40f; */
          /* color: #000000; */
          color: #ebdbb2;
      }

      #pulseaudio.muted {
          /* background-color: #90b1b1; */
          /* color: #2a5c45; */
          color: #ebdbb2;
      }

      #wireplumber {
          /* background-color: #fff0f5; */
          /* color: #000000; */
          color: #ebdbb2;
      }

      #wireplumber.muted {
          /* background-color: #f53c3c; */
      }

      #custom-media {
          /* background-color: #66cc99; */
          /* color: #2a5c45; */
          color: #ebdbb2;
          min-width: 100px;
      }

      #custom-media.custom-spotify {
          /* background-color: #66cc99; */
      }

      #custom-media.custom-vlc {
          /* background-color: #ffa000; */
      }

      #temperature {
          /* background-color: #f0932b; */
      }

      #temperature.critical {
          /* background-color: #eb4d4b; */
      }

      #tray {
          /* background-color: #2980b9; */
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          /* background-color: #eb4d4b; */
      }

      #idle_inhibitor {
          /* background-color: #2d3436; */
      }

      #idle_inhibitor.activated {
          /* background-color: #ecf0f1; */
          /* color: #2d3436; */
          color: #ebdbb2;
      }

      #mpd {
          /* background-color: #66cc99; */
          /* color: #2a5c45; */
          color: #ebdbb2;
      }

      #mpd.disconnected {
          /* background-color: #f53c3c; */
      }

      #mpd.stopped {
          /* background-color: #90b1b1; */
      }

      #mpd.paused {
          /* background-color: #51a37a; */
      }

      #language {
          /* background: #00b093; */
          /* color: #740864; */
          color: #ebdbb2;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state {
          /* background: #97e1ad; */
          /* color: #000000; */
          color: #ebdbb2;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0 5px;
      }

      #keyboard-state > label.locked {
          /* background: rgba(0, 0, 0, 0.2); */
          background: #FFFFFF;
      }

      #scratchpad {
          /* background: rgba(0, 0, 0, 0.2); */
          background: #FFFFFF;
      }

      #scratchpad.empty {
          background-color: transparent;
      }
    '';
    ".config/waybar/styles/original-style.css".text = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
      }

      window#waybar {
          background-color: rgba(43, 48, 59, 0.5);
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: #ffffff;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      /*
      window#waybar.empty {
          background-color: transparent;
      }
      window#waybar.solo {
          background-color: #FFFFFF;
      }
      */

      window#waybar.termite {
          background-color: #3F3F3F;
      }

      window#waybar.chromium {
          background-color: #000000;
          border: none;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #ffffff;
      }

      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.focused {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #submap,
      #mode {
          background-color: #64727D;
          border-bottom: 3px solid #ffffff;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #mpd {
          padding: 0 10px;
          color: #ffffff;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          background-color: #64727D;
      }

      #battery {
          background-color: #ffffff;
          color: #000000;
      }

      #battery.charging, #battery.plugged {
          color: #ffffff;
          background-color: #26A65B;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          background-color: #000000;
      }

      #cpu {
          background-color: #2ecc71;
          color: #000000;
      }

      #memory {
          background-color: #9b59b6;
      }

      #disk {
          background-color: #964B00;
      }

      #backlight {
          background-color: #90b1b1;
      }

      #network {
          background-color: #2980b9;
      }

      #network.disconnected {
          background-color: #f53c3c;
      }

      #pulseaudio {
          background-color: #f1c40f;
          color: #000000;
      }

      #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }

      #wireplumber {
          background-color: #fff0f5;
          color: #000000;
      }

      #wireplumber.muted {
          background-color: #f53c3c;
      }

      #custom-media {
          background-color: #66cc99;
          color: #2a5c45;
          min-width: 100px;
      }

      #custom-media.custom-spotify {
          background-color: #66cc99;
      }

      #custom-media.custom-vlc {
          background-color: #ffa000;
      }

      #temperature {
          background-color: #f0932b;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #tray {
          background-color: #2980b9;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #eb4d4b;
      }

      #idle_inhibitor {
          background-color: #2d3436;
      }

      #idle_inhibitor.activated {
          background-color: #ecf0f1;
          color: #2d3436;
      }

      #mpd {
          background-color: #66cc99;
          color: #2a5c45;
      }

      #mpd.disconnected {
          background-color: #f53c3c;
      }

      #mpd.stopped {
          background-color: #90b1b1;
      }

      #mpd.paused {
          background-color: #51a37a;
      }

      #language {
          background: #00b093;
          color: #740864;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state {
          background: #97e1ad;
          color: #000000;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad.empty {
          background-color: transparent;
      }
    '';
  };
}
