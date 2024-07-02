{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/waybar/hyprland_config".text = ''
      {
          "layer": "top", // Waybar at top layer
          "position": "top", // Waybar position (top|bottom|left|right)
      //    "height": 30, // Waybar height (to be removed for auto height)
      //    "width": 1280, // Waybar width
          "spacing": 2, // Gaps between modules (2px)
          // Choose the order of the modules
          "modules-left": [
              "hyprland/workspaces", 
              "hyprland/submap" 
      //        "custom/media"
          ],
          "modules-center": [
              "custom/mediaplayer"
          ],
          "modules-right": [
              "tray",
      //        "mpd",
              "idle_inhibitor",
      //        "custom/pipewire",
      //        "pulseaudio",
      //        "network",
              "cpu",
              "memory",
              "temperature",
              "backlight",
      //        "keyboard-state",
              "battery",
      //        "battery#bat2",
              "clock"
      //        "custom/quit"
          ],
          // Modules configuration
          "hyprland/workspaces": {
              "tooltip": true,
              "all-outputs": true,
              "format": "{name} <span font='icon'>{icon}</span>",
              "format-icons": {
                  "urgent": "",
                  "active": "",
                  "default": ""
              }
          },
          "hyprland/submap": {
              "format": "<span style=\"italic\">{}</span>"
          },
          "keyboard-state": {
              "numlock": true,
              "capslock": true,
              "format": "{name} <span font='icon'>{icon}</span>",
              "format-icons": {
                  "locked": "",
                  "unlocked": ""
              }
          },
          "mpd": {
              "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
              "format-disconnected": "Disconnected ",
              "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
              "unknown-tag": "N/A",
              "interval": 2,
              "consume-icons": {
                  "on": " "
              },
              "random-icons": {
                  "off": "<span color=\"#f53c3c\"></span> ",
                  "on": " "
              },
              "repeat-icons": {
                  "on": " "
              },
              "single-icons": {
                  "on": "1 "
              },
              "state-icons": {
                  "paused": "",
                  "playing": ""
              },
              "tooltip-format": "MPD (connected)",
              "tooltip-format-disconnected": "MPD (disconnected)"
          },
          "idle_inhibitor": {
              "format": "<span font='icon'>{icon}</span>",
              "format-icons": {
                  "activated": "",
                  "deactivated": ""
              }
          },
          "tray": {
              // "icon-size": 21,
              "spacing": 10
          },
          "clock": {
              "timezone": "America/Kentucky/Monticello",
          //    "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
              "tooltip-format": "<tt>{calendar}</tt>",
              "format-alt": "{:%Y-%m-%d}"
          },
          "cpu": {
              "format": "{usage}% <span font='icon'></span>",
              "tooltip": true
          },
          "memory": {
              "tooltip": true,
              "format": "{}% <span font='icon'></span>"
          },
          "temperature": {
              "tooltip": false,
              "thermal-zone": 0,
              // "hwmon-path": "/sys/class/hwmon/hwmon6/temp1_input",
              "critical-threshold": 80,
              // "format-critical": "{temperatureC}°C <span font='icon'>{icon}</span>",
              "format": "{temperatureC}°C <span font='icon'>{icon}</span>",
              "format-icons": ["", "", ""]
          },
          "backlight": {
              "tooltip": false,
      //        "device": "acpi_video1",
              "format": "{percent}% <span font='icon'>{icon}</span>",
              "format-icons": ["", ""]
          },
      //    "backlight": {
      //          "device": "acpi_video1",
      //        "format": "{percent}% <span font='icon'>{icon}</span>",
      //        "format-icons": ["", "", "", "", "", "", "", "", ""]
      //    },
          "battery": {
              "states": {
                  // "good": 95,
                  "warning": 30,
                  "critical": 15
              },
              "format": "{capacity}% <span font='icon'>{icon}</span>",
              "format-charging": "{capacity}% ",
              "format-plugged": "{capacity}% ",
              "format-alt": "{time} <span font='icon'>{icon}</span>",
              // "format-good": "", // An empty format will hide the module
              // "format-full": "",
              "format-icons": ["", "", "", "", ""]
          },
          "battery#bat2": {
              "bat": "BAT2"
          },
          "network": {
              // "interface": "wlp2*", // (Optional) To force the use of this interface
              "format-wifi": "{essid} ({signalStrength}%) <span font='icon'></span>",
              "format-ethernet": "{ipaddr}/{cidr} <span font='icon'></span>",
              "tooltip-format": "{ifname} via {gwaddr} <span font='icon'></span>",
              "format-linked": "{ifname} (No IP) <span font='icon'></span>",
              "format-disconnected": "Disconnected <span font='icon'>⚠</span>",
              "format-alt": "{ifname}: {ipaddr}/{cidr}"
          },
          "pulseaudio": {
              // "scroll-step": 1, // %, can be a float
              "format": "{volume}% <span font='icon'>{icon}</span> {format_source}",
              "format-bluetooth": "{volume}% <span font='icon'>{icon}</span> {format_source}",
              "format-bluetooth-muted": "<span font='icon'></span> <span font='icon'>{icon}</span> {format_source}",
              "format-muted": "<span font='icon'></span> {format_source}",
              "format-source": "{volume}% ",
              "format-source-muted": "",
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
              "exec": "exec $HOME/.config/waybar/scripts/pw-volume-monitor"
          },
          "custom/media": {
              "format": "<span font='icon'>{icon}</span> {}",
              "return-type": "json",
              "max-length": 40,
              "format-icons": {
                  "spotify": "",
                  "default": "🎜"
              },
              "escape": true,
              "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null" // Script in resources folder
              // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
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
              "format": "<span font='icon'>⏻</span>",
              "on-click": "$HOME/.config/hypr/hyprland_exit_prompt"
          }
      }
    '';
    ".config/waybar/sway_config".text = ''
      {
          "layer": "top", // Waybar at top layer
          "position": "top", // Waybar position (top|bottom|left|right)
      //    "height": 30, // Waybar height (to be removed for auto height)
      //    "width": 1280, // Waybar width
          "spacing": 2, // Gaps between modules (2px)
          // Choose the order of the modules
          "modules-left": [
              "sway/workspaces", 
              "sway/mode" 
      //        "custom/media"
          ],
          "modules-center": [
              "custom/mediaplayer"
          ],
          "modules-right": [
              "tray",
      //        "mpd",
              "idle_inhibitor",
      //        "custom/pipewire",
      //        "pulseaudio",
      //        "network",
              "cpu",
              "memory",
              "temperature",
              "backlight",
      //        "keyboard-state",
              "battery",
      //        "battery#bat2",
              "clock"
      //        "custom/quit"
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
          "keyboard-state": {
              "numlock": true,
              "capslock": true,
              "format": "{name} <span font='icon'>{icon}</span>",
              "format-icons": {
                  "locked": "",
                  "unlocked": ""
              }
          },
          "mpd": {
              "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
              "format-disconnected": "Disconnected ",
              "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
              "unknown-tag": "N/A",
              "interval": 2,
              "consume-icons": {
                  "on": " "
              },
              "random-icons": {
                  "off": "<span color=\"#f53c3c\"></span> ",
                  "on": " "
              },
              "repeat-icons": {
                  "on": " "
              },
              "single-icons": {
                  "on": "1 "
              },
              "state-icons": {
                  "paused": "",
                  "playing": ""
              },
              "tooltip-format": "MPD (connected)",
              "tooltip-format-disconnected": "MPD (disconnected)"
          },
          "idle_inhibitor": {
              "format": "<span font='icon'>{icon}</span>",
              "format-icons": {
                  "activated": "",
                  "deactivated": ""
              }
          },
          "tray": {
              // "icon-size": 21,
              "spacing": 10
          },
          "clock": {
              "timezone": "America/Kentucky/Monticello",
          //    "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
              "tooltip-format": "<tt>{calendar}</tt>",
              "format-alt": "{:%Y-%m-%d}"
          },
          "cpu": {
              "format": "{usage}% <span font='icon'></span>",
              "tooltip": true
          },
          "memory": {
              "tooltip": true,
              "format": "{}% <span font='icon'></span>"
          },
          "temperature": {
              "tooltip": false,
              "thermal-zone": 0,
              // "hwmon-path": "/sys/class/hwmon/hwmon6/temp1_input",
              "critical-threshold": 80,
              // "format-critical": "{temperatureC}°C <span font='icon'>{icon}</span>",
              "format": "{temperatureC}°C <span font='icon'>{icon}</span>",
              "format-icons": ["", "", ""]
          },
          "backlight": {
              "tooltip": false,
      //        "device": "acpi_video1",
              "format": "{percent}% <span font='icon'>{icon}</span>",
              "format-icons": ["", ""]
          },
      //    "backlight": {
      //          "device": "acpi_video1",
      //        "format": "{percent}% <span font='icon'>{icon}</span>",
      //        "format-icons": ["", "", "", "", "", "", "", "", ""]
      //    },
          "battery": {
              "states": {
                  // "good": 95,
                  "warning": 30,
                  "critical": 15
              },
              "format": "{capacity}% <span font='icon'>{icon}</span>",
              "format-charging": "{capacity}% ",
              "format-plugged": "{capacity}% ",
              "format-alt": "{time} <span font='icon'>{icon}</span>",
              // "format-good": "", // An empty format will hide the module
              // "format-full": "",
              "format-icons": ["", "", "", "", ""]
          },
          "battery#bat2": {
              "bat": "BAT2"
          },
          "network": {
              // "interface": "wlp2*", // (Optional) To force the use of this interface
              "format-wifi": "{essid} ({signalStrength}%) <span font='icon'></span>",
              "format-ethernet": "{ipaddr}/{cidr} <span font='icon'></span>",
              "tooltip-format": "{ifname} via {gwaddr} <span font='icon'></span>",
              "format-linked": "{ifname} (No IP) <span font='icon'></span>",
              "format-disconnected": "Disconnected <span font='icon'>⚠</span>",
              "format-alt": "{ifname}: {ipaddr}/{cidr}"
          },
          "pulseaudio": {
              // "scroll-step": 1, // %, can be a float
              "format": "{volume}% <span font='icon'>{icon}</span> {format_source}",
              "format-bluetooth": "{volume}% <span font='icon'>{icon}</span> {format_source}",
              "format-bluetooth-muted": "<span font='icon'></span> <span font='icon'>{icon}</span> {format_source}",
              "format-muted": "<span font='icon'></span> {format_source}",
              "format-source": "{volume}% ",
              "format-source-muted": "",
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
              "exec": "exec $HOME/.config/waybar/scripts/pw-volume-monitor"
          },
          "custom/media": {
              "format": "<span font='icon'>{icon}</span> {}",
              "return-type": "json",
              "max-length": 40,
              "format-icons": {
                  "spotify": "",
                  "default": "🎜"
              },
              "escape": true,
              "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null" // Script in resources folder
              // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
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
  };
}
