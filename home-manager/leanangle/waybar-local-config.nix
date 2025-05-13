{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/waybar/hyprland_config.jsonc".text = ''
      {
          "layer": "top", // Waybar at top layer
          "position": "top", // Waybar position (top|bottom|left|right)
          "height": 30,
          "spacing": 2, // Gaps between modules (2px)
      // Choose the order of the modules
          "modules-left": [
              "hyprland/workspaces", 
              "hyprland/submap",
              "custom/mediaplayer"
          ],
          "modules-center": [
          ],
          "modules-right": [
              "tray",
              "idle_inhibitor",
              "cpu",
              "memory",
              "temperature",
              "clock",
              "custom/quit"
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
              "format": "{:%H:%M - %Y-%m-%d}",
              "timezone": "America/Kentucky/Monticello",
              "tooltip-format": "<tt>{calendar}</tt>"
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
              "thermal-zone": 3,
              "critical-threshold": 80,
              "format": "{temperatureC}°C <span font='icon'>{icon}</span>",
              "format-icons": ["", "", ""]
          },
          "backlight": {
              "tooltip": false,
              "format": "{percent}% <span font='icon'>{icon}</span>",
              "format-icons": ["", ""]
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
          "custom/pipewire": {
              "tooltip": false,
              "max-length": 15,
              "restart-interval": 10,
              "exec": "$HOME/.config/waybar/scripts/pw-volume-monitor"
          },
          "custom/mediaplayer": {
              "format": "{text}",
              "max-length": 128,
              "interval": 1,
              "exec": "$HOME/.config/waybar/scripts/mediaplayer.sh 2> /dev/null", 
              "return-type": "json"
          },
          "custom/quit": {
              "tooltip": false,
              "format": "<span font='icon'>⏻</span>",
              "on-click": "exit-prompt-hyprland"
          }
      }
    '';
    ".config/waybar/sway_config.jsonc".text = ''
      {
          "layer": "top", // Waybar at top layer
          "position": "top", // Waybar position (top|bottom|left|right)
          "height": 30,
          "spacing": 2, // Gaps between modules (2px)
      // Choose the order of the modules
          "modules-left": [
              "sway/workspaces", 
              "sway/mode",
              "custom/mediaplayer"
          ],
          "modules-center": [
          ],
          "modules-right": [
              "tray",
              "idle_inhibitor",
              "cpu",
              "memory",
              "temperature",
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
          "keyboard-state": {
              "numlock": true,
              "capslock": true,
              "format": "{name} <span font='icon'>{icon}</span>",
              "format-icons": {
                  "locked": "",
                  "unlocked": ""
              }
          },
          "idle_inhibitor": {
              "format": "<span font='icon'>{icon}</span>",
              "format-icons": {
                  "activated": "",
                  "deactivated": ""
              }
          },
          "tray": {
              "spacing": 10
          },
          "clock": {
              "format": "{:%H:%M - %Y-%m-%d}",
              "timezone": "America/Kentucky/Monticello",
              "tooltip-format": "<tt>{calendar}</tt>"
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
              "thermal-zone": 3,
              "critical-threshold": 80,
              "format": "{temperatureC}°C <span font='icon'>{icon}</span>",
              "format-icons": ["", "", ""]
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
          "custom/pipewire": {
              "tooltip": false,
              "max-length": 15,
              "restart-interval": 10,
              "exec": "$HOME/.config/waybar/scripts/pw-volume-monitor"
          },
          "custom/mediaplayer": {
              "format": "{text}",
              "max-length": 128,
              "interval": 1,
              "exec": "$HOME/.config/waybar/scripts/mediaplayer.sh 2> /dev/null", 
              "return-type": "json"
          },
          "custom/quit": {
              "tooltip": false,
              "format": "<span font='icon'>⏻</span>",
              "on-click": "exit-prompt-sway"
          }
      }
    '';
  };
}
