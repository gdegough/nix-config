{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
#with lib.hm.gvariant;
{
  home.file = {
    ".config/waybar/hyprland_config".text = ''
      {
          "layer": "bottom", // Waybar at top layer
          "position": "top", // Waybar position (top|bottom|left|right)
          "height": 30, // Waybar height (to be removed for auto height)
          "spacing": 3, // Space between modules
          // Choose the order of the modules
          "modules-left": [
              "hyprland/workspaces", 
              "hyprland/submap" 
          ],
          "modules-center": [
              "custom/mediaplayer"
          ],
          "modules-right": [
              "tray",
              "idle_inhibitor",
              "custom/pipewire",
              "network", 
              "memory", 
              "cpu", 
              "temperature", 
              "backlight", 
              "battery",
      //        "custom/battery_time",
      //        "battery#bat2",
              "clock",
              "custom/quit"
          ],
          // Modules configuration
          "hyprland/submap": {
              "format": " {} "
          },
          "hyprland/window": {
              "tooltip": true,
              "max-length": 80
          },
          "hyprland/workspaces": {
              "tooltip": true,
              "all-outputs": true,
              "sort-by": "number",
              "format": "{name} <span font='icon'>{icon}</span>",
              "format-icons": {
                  "urgent": "",
                  "active": "",
                  "default": ""
              }
          },
          "idle_inhibitor": {
              "tooltip": false,
              "format": "<span font='icon'>{icon}</span> ",
              "format-icons": {
                  "activated": "",
                  "deactivated": ""
              } 
          },
          "tray": {
              "tooltip": false,
              "spacing": 5
          },
          "clock": {
              "tooltip": true,
      //        "timezone": "America/Kentucky/Monticello",
              "tooltip-format": "<tt><big>{:%Y %B}</big>\n<small>{calendar}</small></tt>",
              "format-alt": "{:%Y-%m-%d}"
          },
          "clock#date": {
              "tooltip": false,
              "format": "{:%a %d %b w:%V}"
          },
          "cpu": {
              "tooltip": true,
              "format": "<span font='icon'></span> {usage}%"
          },
          "memory": {
              "tooltip": true,
              "format": "<span font='icon'></span> {}%"
          },
          "temperature": {
              "tooltip": false,
              "thermal-zone": 0,
              "critical-threshold": 100,
              "interval": 2,
      //        "format-critical": "<span font='icon'>{icon}</span> {temperatureC}°C",
              "format": "<span font='icon'>{icon}</span> {temperatureC}°C",
              "format-icons": [
                  "", // Icon: temperature-empty
                  "", // Icon: temperature-quarter
                  "", // Icon: temperature-half
                  "", // Icon: temperature-three-quarters
                  ""  // Icon: temperature-full
              ]
          },
          "backlight": {
              "tooltip": false,
      //      "device": "acpi_video1",
              "format": "<span font='icon'>{icon}</span> {percent}%",
              "format-icons": ["", ""]
          },
          "battery": {
              "tooltip": true,
              "states": {
                  "good": 95,
                  "warning": 30,
                  "critical": 15
              },
              "bat":"BAT0",
              "format": "<span font='icon'>{icon}</span> {capacity}%",
      //        "format-charging": "<span font='icon'> </span>{capacity}%",
      //        "format-plugged": "<span font='icon'></span> {capacity}%",
      //        "format-discharging": "<span font='icon'></span> {capacity}%",
              "format-alt": "<span font='icon'>{icon}</span> {time}",
              "format-icons": ["", "", "", "", ""]
          },
          "custom/battery_time": {
              "format": "  {}",
              "exec": "acpi -b | cut -d ',' -f3 | awk '{print $1}' | cut -d ':' -f1,2",
              "interval": 30
          },
          "battery#bat2": {
              "bat": "BAT2"
          },
          "network": {
              "tooltip": true,
              "format-wifi": "<span font='icon'></span> {essid} ({signalStrength}%)",
              "format-ethernet": "<span font='icon'></span> {ifname}: {ipaddr}/{cidr}",
              "format-linked": "<span font='icon'></span> {ifname} (No IP)",
              "format-disconnected": "<span font='icon'>⚠</span> Disconnected",
              "tooltip-format": "{ifname}"
          },
          "custom/keyboard": {
              "format": " {}",
              "interval": 1,
              "exec": "$HOME/.config/waybar/scripts/get_kbdlayout.sh"
          },
          "pulseaudio": {
              "tooltip": true,
              // "scroll-step": 1, // %, can be a float
              "format": "{volume}% <span font='icon'>{icon}</span> {format_source}",
              "format-bluetooth": "{volume}% <span font='icon'>{icon}</span> {format_source}",
              "format-bluetooth-muted": "<span font='icon'> {icon}</span> {format_source}",
              "format-muted": "<span font='icon'></span> {format_source}",
              "format-source": "{volume}% <span font='icon'></span>",
              "format-source-muted": "<span font='icon'></span>",
              "format-icons": {
                  "headphone": "",
                  "hands-free": "",
                  "headset": "",
                  "phone": "",
                  "portable": "",
                  "car": "",
                  "default": ["", "", ""]
              },
              "on-click": "pavucontrol"
          },
          "custom/pipewire": {
              "tooltip": false,
              "max-length": 15,
              "restart-interval": 10,
              "exec": "exec bash $HOME/.config/waybar/scripts/pw-volume-monitor.bash"
          },
          "custom/mediaplayer": {
              "tooltip": false,
              "format": "<span font='icon'>{icon}</span> {}",
              "return-type": "json",
              "max-length": 64,
      //        "interval": 1,
              "format-icons": {
                  "spotify": "",
                  "default": "🎜"
              },
              "escape": true,
              "exec": "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}} ({{duration(position)}}/{{duration(mpris:length)}})\", \"tooltip\": \"{{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F"
          },
          "mpris": {
              "player": "tidal-hifi",
              "interval": 1,
              "format": "<span font='icon'>{player_icon}</span> <span font='icon'>{status_icon}</span> {dynamic}", 
              "status-icons": {
                  "playing": "",
                  "paused": "",
                  "stopped": ""
              },
              "player-icons": {
                  "spotify": "",
                  "default": "🎜"
              }
          },
          "custom/quit": {
              "tooltip": false,
              "format": "<span font='icon'>{icon}</span>",
              "format-icons": {
                  "default": ""
              },
              "on-click": "hyprctl dispatch exit"
          }
      }
    '';
    ".config/waybar/sway_config".text = ''
      {
          "layer": "bottom", // Waybar at top layer
          "position": "top", // Waybar position (top|bottom|left|right)
          "height": 30, // Waybar height (to be removed for auto height)
          "spacing": 3, // Space between modules
          // Choose the order of the modules
          "modules-left": [
              "sway/workspaces", 
              "sway/mode" 
          ],
          "modules-center": [
              "custom/mediaplayer"
          ],
          "modules-right": [
              "tray",
              "idle_inhibitor",
              "custom/pipewire",
              "network", 
              "memory", 
              "cpu", 
              "temperature", 
              "backlight", 
              "battery",
      //        "custom/battery_time",
      //        "battery#bat2",
              "clock",
              "custom/quit"
          ],
          // Modules configuration
          "sway/mode": {
              "format": " {} "
          },
          "sway/window": {
              "tooltip": true,
              "max-length": 80
          },
          "sway/workspaces": {
              "tooltip": true,
              "all-outputs": true,
              "disable-scroll": false,
              "format": "{name} <span font='icon'>{icon}</span>",
              "format-icons": {
                  "urgent": "",
                  "focused": "",
                  "default": ""
              }
          },
          "idle_inhibitor": {
              "tooltip": false,
              "format": "<span font='icon'>{icon}</span> ",
              "format-icons": {
                  "activated": "",
                  "deactivated": ""
              } 
          },
          "tray": {
              "tooltip": false,
              "spacing": 5
          },
          "clock": {
              "tooltip": true,
      //        "timezone": "America/Kentucky/Monticello",
              "tooltip-format": "<tt><big>{:%Y %B}</big>\n<small>{calendar}</small></tt>",
              "format-alt": "{:%Y-%m-%d}"
          },
          "clock#date": {
              "tooltip": false,
              "format": "{:%a %d %b w:%V}"
          },
          "cpu": {
              "tooltip": true,
              "format": "<span font='icon'></span> {usage}%"
          },
          "memory": {
              "tooltip": true,
              "format": "<span font='icon'></span> {}%"
          },
          "temperature": {
              "tooltip": false,
              "thermal-zone": 0,
              "critical-threshold": 100,
              "interval": 2,
      //        "format-critical": "<span font='icon'>{icon}</span> {temperatureC}°C",
              "format": "<span font='icon'>{icon}</span> {temperatureC}°C",
              "format-icons": [
                  "", // Icon: temperature-empty
                  "", // Icon: temperature-quarter
                  "", // Icon: temperature-half
                  "", // Icon: temperature-three-quarters
                  ""  // Icon: temperature-full
              ]
          },
          "backlight": {
              "tooltip": false,
      //      "device": "acpi_video1",
              "format": "<span font='icon'>{icon}</span> {percent}%",
              "format-icons": ["", ""]
          },
          "battery": {
              "tooltip": true,
              "states": {
                  "good": 95,
                  "warning": 30,
                  "critical": 15
              },
              "bat":"BAT0",
              "format": "<span font='icon'>{icon}</span> {capacity}%",
      //        "format-charging": "<span font='icon'> </span>{capacity}%",
      //        "format-plugged": "<span font='icon'></span> {capacity}%",
      //        "format-discharging": "<span font='icon'></span> {capacity}%",
              "format-alt": "<span font='icon'>{icon}</span> {time}",
              "format-icons": ["", "", "", "", ""]
          },
          "custom/battery_time": {
              "format": "  {}",
              "exec": "acpi -b | cut -d ',' -f3 | awk '{print $1}' | cut -d ':' -f1,2",
              "interval": 30
          },
          "battery#bat2": {
              "bat": "BAT2"
          },
          "network": {
              "tooltip": true,
              "format-wifi": "<span font='icon'></span> {essid} ({signalStrength}%)",
              "format-ethernet": "<span font='icon'></span> {ifname}: {ipaddr}/{cidr}",
              "format-linked": "<span font='icon'></span> {ifname} (No IP)",
              "format-disconnected": "<span font='icon'>⚠</span> Disconnected",
              "tooltip-format": "{ifname}"
          },
          "custom/keyboard": {
              "format": " {}",
              "interval": 1,
              "exec": "$HOME/.config/waybar/scripts/get_kbdlayout.sh"
          },
          "pulseaudio": {
              "tooltip": true,
              // "scroll-step": 1, // %, can be a float
              "format": "{volume}% <span font='icon'>{icon}</span> {format_source}",
              "format-bluetooth": "{volume}% <span font='icon'>{icon}</span> {format_source}",
              "format-bluetooth-muted": "<span font='icon'> {icon}</span> {format_source}",
              "format-muted": "<span font='icon'></span> {format_source}",
              "format-source": "{volume}% <span font='icon'></span>",
              "format-source-muted": "<span font='icon'></span>",
              "format-icons": {
                  "headphone": "",
                  "hands-free": "",
                  "headset": "",
                  "phone": "",
                  "portable": "",
                  "car": "",
                  "default": ["", "", ""]
              },
              "on-click": "pavucontrol"
          },
          "custom/pipewire": {
              "tooltip": false,
              "max-length": 15,
              "restart-interval": 10,
              "exec": "exec bash $HOME/.config/waybar/scripts/pw-volume-monitor.bash"
          },
          "custom/mediaplayer": {
              "tooltip": false,
              "format": "<span font='icon'>{icon}</span> {}",
              "return-type": "json",
              "max-length": 64,
      //        "interval": 1,
              "format-icons": {
                  "spotify": "",
                  "default": "🎜"
              },
              "escape": true,
              "exec": "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}} ({{duration(position)}}/{{duration(mpris:length)}})\", \"tooltip\": \"{{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F"
          },
          "mpris": {
              "player": "tidal-hifi",
              "interval": 1,
              "format": "<span font='icon'>{player_icon}</span> <span font='icon'>{status_icon}</span> {dynamic}", 
              "status-icons": {
                  "playing": "",
                  "paused": "",
                  "stopped": ""
              },
              "player-icons": {
                  "spotify": "",
                  "default": "🎜"
              }
          },
          "custom/quit": {
              "tooltip": false,
              "format": "<span font='icon'>{icon}</span>",
              "format-icons": {
                  "default": ""
              },
              "on-click": "swaynag -f 'IBM Plex Sans' -t warning -m 'Do you really want to exit sway?' -b 'Yes, exit sway' 'swaymsg exit'"
          }
      }
    '';
    ".config/waybar/config.orig".text = ''
      {
          "layer": "top", // Waybar at top layer
      //	"position": "bottom", // Waybar position (top|bottom|left|right)
          "height": 30, // Waybar height (to be removed for auto height)
      //	"width": 1280, // Waybar width
      //	"gtk-layer-shell": "false",
          // Choose the order of the modules
          "modules-left": [
              "sway/workspaces", 
              "sway/mode" 
          ],
      //	"modules-center": [
      //		"custom/media"
      //		"sway/window"
      //	],
          "modules-right": [
              "tray",
              "idle_inhibitor",
      //		"pulseaudio", 
              "custom/pipewire",
      //		"network", 
              "cpu", 
              "memory", 
              "temperature", 
              "backlight", 
              "battery", 
              "custom/battery_time",
      //		"battery#bat2",
      //		"custom/layout", 
      //		"clock#date", 
              "clock"
          ],
          "sway/mode": {
              "format": "<span font='icon'></span> {}"
          },
          "sway/window": {
              "tooltip": true,
              "max-length": 80
          },
          // Modules configuration
          "sway/workspaces": {
              "tooltip": true,
              "all-outputs": true,
              "disable-scroll": false,
              "format": "{name}: <span font='icon'>{icon}</span>",
              "format-icons": {
                  "urgent": "",
                  "focused": "",
                  "default": ""
              }
          },
          "idle_inhibitor": {
              "tooltip": false,
              "format": "<span font='icon'>{icon}</span> ",
              "format-icons": {
                  "activated": "",
                  "deactivated": ""
              } 
          },
          "tray": {
              "tooltip": false,
      //		"icon-size": 21,
              "spacing": 10
          },
              "clock": {
              "tooltip": true,
                      // "timezone": "America/New_York",
                      "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
                      "format-alt": "{:%Y-%m-%d}"
              },
          "clock#date": {
              "tooltip": false,
              "format": "{:%a %d %b w:%V}"
          },
          "cpu": {
              "tooltip": true,
              "format": "{usage}% <span font='icon'></span>"
          },
          "memory": {
              "tooltip": true,
              "format": "{}% <span font='icon'></span>"
          },
          "temperature": {
              "tooltip": false,
      //		"thermal-zone": 2,
      //		"hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
              "critical-threshold": 80,
      //		"format-critical": "{temperatureC}°C <span font='icon'>{icon}</span>",
              "format": "{temperatureC}°C <span font='icon'>{icon}</span>",
              "format-icons": [
                  "", // Icon: temperature-empty
                  "", // Icon: temperature-quarter
                  "", // Icon: temperature-half
                  "", // Icon: temperature-three-quarters
                  ""  // Icon: temperature-full
              ]
          },
          "backlight": {
              "tooltip": false,
              "device": "acpi_video1",
              "format": "{percent}% <span font='icon'>{icon}</span>",
              "format-icons": ["", ""]
          },
          "battery": {
              "tooltip": true,
              "states": {
      //			"good": 95,
                  "warning": 30,
                  "critical": 15
              },
              "format": "<span font='icon'>{icon}</span>",
              "format-charging": "<span font='icon'></span>",
              "format-plugged": "<span font='icon'></span>",
              "format-alt": "{capacity}% {time}",
              "format-icons": ["", "", "", "", ""]
          },
              "custom/battery_time": {
                      "format": "  {}",
                      "exec": "acpi -b | cut -d ',' -f3 | awk '{print $1}' | cut -d ':' -f1,2",
                      "interval": 30
              },
          "battery#bat2": {
              "bat": "BAT2"
          },
              "network": {
              "tooltip": true,
      //		  "interface": "wlp2*", // (Optional) To force the use of this interface
      //		  "format-wifi": "{essid} ({signalStrength}%) <span font='icon'></span>",
                      "format-wifi": "<span font='icon'></span>",
                      "format-ethernet": "{ifname}: {ipaddr}/{cidr} <span font='icon'></span>",
                      "format-linked": "{ifname} (No IP) <span font='icon'></span>",
                      "format-disconnected": "Disconnected <span font='icon'>⚠</span>",
              "tooltip-format": "{essid} ({signalStrength}%)"
      //		"format-alt": "{ifname} {essid} ({signalStrength}%)"
      //                "format-alt": "{ifname}: {ipaddr}/{cidr}"
              },
              "pulseaudio": {
              "tooltip": true,
                      // "scroll-step": 1, // %, can be a float
                      "format": "{volume}% <span font='icon'>{icon}</span> {format_source}",
                      "format-bluetooth": "{volume}% <span font='icon'>{icon}</span> {format_source}",
                      "format-bluetooth-muted": "<span font='icon'> {icon}</span> {format_source}",
                      "format-muted": "<span font='icon'></span> {format_source}",
                      "format-source": "{volume}% <span font='icon'></span>",
                      "format-source-muted": "<span font='icon'></span>",
                      "format-icons": {
                              "headphone": "",
                              "hands-free": "",
                              "headset": "",
                              "phone": "",
                              "portable": "",
                              "car": "",
                              "default": ["", "", ""]
                      },
                      "on-click": "pavucontrol"
              },
          "custom/pipewire": {
              "format": "  {percentage}% <span font='icon'>{icon}</span>",
              "return-type": "json",
              "signal": 8,
              "interval": "once",
              "format-icons": {
                  "mute": "",
                  "default": ["", "", ""],
              },
              "exec": "pw-volume status"
          },
          "custom/media": {
              "tooltip": false,
              "format": "<span font='icon'>{icon}</span> {}",
              "return-type": "json",
              "max-length": 40,
              "format-icons": {
                  "spotify": "",
                  "default": "🎜"
              },
              "escape": true,
              "exec": "$HOME/.config/waybar/mediaplayer.py --player Plexamp 2> /dev/null" // Script in resources folder
      //		"exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
          },
          "custom/layout": {
              "tooltip": false,
              "exec": "swaymsg -mrt subscribe '[\"input\"]' | jq -r --unbuffered \"select(.change == \\\"xkb_layout\\\") | .input | select(.type == \\\"keyboard\\\") | .xkb_active_layout_name | .[0:2]\""
          }
      }
    '';
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
    ".config/waybar/scripts/mediaplayer.py".executable = true;
    ".config/waybar/scripts/mediaplayer.py".text = ''
      #!env python3
      import argparse
      import logging
      import sys
      import signal
      import gi
      import json
      gi.require_version('Playerctl', '2.0')
      from gi.repository import Playerctl, GLib

      logger = logging.getLogger(__name__)


      def write_output(text, player):
          logger.info('Writing output')

          output = {'text': text,
                    'class': 'custom-' + player.props.player_name,
                    'alt': player.props.player_name}

          sys.stdout.write(json.dumps(output) + '\n')
          sys.stdout.flush()


      def on_play(player, status, manager):
          logger.info('Received new playback status')
          on_metadata(player, player.props.metadata, manager)

      def duration(micros):
          s = ""
          seconds=int(micros/1000000)%60
          minutes=int(micros/(1000000*60))%60
          hours=int(micros/(1000000*60*60))%24
          s = "%02i:%02i" % (minutes, seconds)
          return s
       
      def on_metadata(player, metadata, manager):
          logger.info('Received new metadata')
          track_info = '''

          if player.props.player_name == 'spotify' and \
                  'mpris:trackid' in metadata.keys() and \
                  ':ad:' in player.props.metadata['mpris:trackid']:
              track_info = 'AD PLAYING'
          elif player.get_artist() != ''' and player.get_title() != ''':
              track_info = '{artist} - {title}'.format(artist=player.get_artist(),
                                                       title=player.get_title())
          else:
              track_info = player.get_title()

          if 'mpris:length' in metadata.keys():
              track_info = track_info + ' ({position}/{length})'.format(
                                       position=duration(player.get_position()),
                                       length=duration(player.props.metadata['mpris:length']))

          if player.props.status != 'Playing' and track_info:
              track_info = ' ' + track_info
          write_output(track_info, player)


      def on_player_appeared(manager, player, selected_player=None):
          if player is not None and (selected_player is None or player.name == selected_player):
              init_player(manager, player)
          else:
              logger.debug("New player appeared, but it's not the selected player, skipping")


      def on_player_vanished(manager, player):
          logger.info('Player has vanished')
          sys.stdout.write('\n')
          sys.stdout.flush()


      def init_player(manager, name):
          logger.debug('Initialize player: {player}'.format(player=name.name))
          player = Playerctl.Player.new_from_name(name)
          player.connect('playback-status', on_play, manager)
          player.connect('metadata', on_metadata, manager)
          manager.manage_player(player)
          on_metadata(player, player.props.metadata, manager)


      def signal_handler(sig, frame):
          logger.debug('Received signal to stop, exiting')
          sys.stdout.write('\n')
          sys.stdout.flush()
          # loop.quit()
          sys.exit(0)


      def parse_arguments():
          parser = argparse.ArgumentParser()

          # Increase verbosity with every occurence of -v
          parser.add_argument('-v', '--verbose', action='count', default=0)

          # Define for which player we're listening
          parser.add_argument('--player')

          return parser.parse_args()


      def main():
          arguments = parse_arguments()

          # Initialize logging
          logging.basicConfig(stream=sys.stderr, level=logging.DEBUG,
                              format='%(name)s %(levelname)s %(message)s')

          # Logging is set by default to WARN and higher.
          # With every occurrence of -v it's lowered by one
          logger.setLevel(max((3 - arguments.verbose) * 10, 0))

          # Log the sent command line arguments
          logger.debug('Arguments received {}'.format(vars(arguments)))

          manager = Playerctl.PlayerManager()
          loop = GLib.MainLoop()

          manager.connect('name-appeared', lambda *args: on_player_appeared(*args, arguments.player))
          manager.connect('player-vanished', on_player_vanished)

          signal.signal(signal.SIGINT, signal_handler)
          signal.signal(signal.SIGTERM, signal_handler)

          for player in manager.props.player_names:
              if arguments.player is not None and arguments.player != player.name:
                  logger.debug('{player} is not the filtered player, skipping it'
                               .format(player=player.name)
                               )
                  continue

              init_player(manager, player)

          loop.run()


      if __name__ == '__main__':
          main()
    '';
    ".config/waybar/scripts/nowplaying.sh".executable = true;
    ".config/waybar/scripts/nowplaying.sh".text = ''
      #!env bash

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
    ".config/waybar/scripts/pw-volume-monitor.bash".executable = true;
    ".config/waybar/scripts/pw-volume-monitor.bash".text = ''
      #!env bash

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
      #    "exec": "exec $HOME/path-to/pw-volume-monitor.bash"
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
    ".config/waybar/style-kali-dark.css".text = ''
      * {
          border:                 none;
          border-radius:          0;
          font-family:            "IBM Plex Mono Text";
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

      #mode {
          margin:                 0px 5px 3px 5px;
          color:                  #fdf6e3;
          background-color:       #dc322f;
      }
    '';
    ".config/waybar/style-pop-os.css".text = ''
      * {
          border:                 none;
          border-radius:          0;
          font-family:            "IBM Plex Mono Text";
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
    ".config/waybar/style-solarized-dark.css".text = ''
      * {
          border:                 none;
          border-radius:          0;
          font-family:            "IBM Plex Mono Text";
          font-size:              14px;
          box-shadow:             none;
          text-shadow:            none;
          transition-duration:    0s;
      }

      tooltip {
          color:		            #93a1a1;
          background-color:	    #586e75;
          text-shadow:	        none;
      }

      window#waybar {
          color:                  #fdf6e3;
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
          color:                  #b58900;
          border-bottom:          2px solid #b58900;
      }

      #workspaces button.visible {
          color:                  #b58900;
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

      #mode {
          margin:                 0px 5px 3px 5px;
          color:                  #fdf6e3;
          background-color:       #dc322f;
      }
    '';
    ".config/waybar/style-standard.css".text = ''
      * {
          border:        none;
          border-radius: 0;
          font-family:   "IBM Plex Sans";
          font-size:     14px;
          box-shadow:    none;
          text-shadow:   none;
          transition-duration: 0s;
      }

      window#waybar {
          color: rgba(53, 185, 171, 1);
          background-color: rgba(23, 63, 79, 0.4);
          border-bottom: 2px solid rgba(53, 185, 171, 0.4);
      }

      window#waybar.solo {
          color: rgba(53, 185, 171, 1);
      }

      #workspaces {
          margin: 0 5px;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: rgba(53, 185, 171, 1);
          border-bottom: 2px solid transparent;
      }

      #workspaces button.focused {
          color: rgba(115, 186, 37, 1);
          border-bottom: 2px solid #BBBBBB;
      }

      #workspaces button.visible {
          color: rgba(115, 186, 37, 1);
      }

      #workspaces button.urgent {
          color: rgba(33, 164, 223, 1);
      }

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
          margin: 0px 6px 0px 10px;
      /*    min-width: 30px;*/
      }

      #clock {
          margin: 0px 6px 0px 10px;
          font-size: 15px;
          font-weight: bold;
      }

      #battery.warning {
         color: rgba(255, 210, 4, 1);
      }

      #battery.critical {
          color: rgba(238, 46, 36, 1);
      }

      #battery.charging {
          color: rgba(217, 216, 216, 1);
      }
    '';
  };
}
