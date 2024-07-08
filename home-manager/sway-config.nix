{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/sway/config".text = ''
      #
      # Read `man 5 sway` for a complete reference.

      ### Variables
      #
      # Logo key. Use Mod1 for Alt.
      set $mod Mod4
      # Home row direction keys, like vim
      set $left j
      set $down k
      set $up l
      set $right semicolon
      # Preferred font
      font pango:IBM Plex Mono 11
      # Your preferred terminal emulator
      # Recommends: foot
      # exec ${pkgs.foot}/bin/foot --server
      # set $term ${pkgs.foot}/bin/footclient
      set $term ${pkgs.alacritty}/bin/alacritty
      # Your preferred notification daemon
      set $notification_daemon dunst
      # Your preferred application launcher
      set $launcher rofi -dmenu
      # Note: pass the final command to swaymsg so that the resulting window can be opened
      # on the original workspace that the command was run on.
      # Recommends: rofi-wayland
      set $rofi_cmd rofi -terminal '$term'
      # Shows a combined list of the applications with desktop files and
      # executables from PATH.
      # TODO: add window with the next release of rofi-wayland
      set $menu $rofi_cmd -show combi -modes combi#window#ssh#drun#run -combi-modes window#ssh#drun#run
      # Your preferred browser
      set $browser firefox

      ### Output configuration
      #
      # Default wallpaper (more resolutions are available in /usr/share/backgrounds/sway/)
      # Requires: desktop-backgrounds-compat, swaybg
      set $wallpaper $HOME/.config/sway/background
      output * bg $wallpaper fill
      #
      # Example configuration:
      #
      #   output HDMI-A-1 resolution 1920x1080 position 1920,0
      #
      # You can get the names of your outputs by running: swaymsg -t get_outputs
      include $HOME/.config/sway/monitor.conf

      ### Idle configuration
      #
      # Example configuration:
      #
      # exec swayidle -w \
      #          timeout 300 'swaylock -f -c 000000' \
      #          timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
      #          before-sleep 'swaylock -f -c 000000'
      #
      # This will lock your screen after 300 seconds of inactivity, then turn off
      # your displays after another 300 seconds, and turn your screens back on when
      # resumed. It will also lock your screen before your computer goes to sleep.
      set $lockscreenbg $HOME/.config/sway/lockscreen
      set $lock_timeout 600
      set $screen_timeout 900

      ### Input configuration
      #
      # Example configuration:
      #
      #   input "2:14:SynPS/2_Synaptics_TouchPad" {
      #       dwt enabled
      #       tap enabled
      #       natural_scroll enabled
      #       middle_emulation enabled
      #   }
      #
      # You can get the names of your inputs by running: swaymsg -t get_inputs
      # Read `man 5 sway-input` for more information about this section.

      ### Key bindings
      #
      # Basics:
      #
          # Start a terminal
          bindsym $mod+Return exec $term

          # Start a browser
          bindsym $mod+b exec $browser

          # Kill focused window
          bindsym $mod+Shift+q kill

          # Start your launcher
          bindsym $mod+Slash exec $menu

          # Drag floating windows by holding down $mod and left mouse button.
          # Resize them with right mouse button + $mod.
          # Despite the name, also works for non-floating windows.
          # Change normal to inverse to use left mouse button for resizing and right
          # mouse button for dragging.
          floating_modifier $mod normal

          # Reload the configuration file
          bindsym $mod+Shift+c reload

          # Show cliboard history
          bindsym $mod+Shift+v exec $clipboard_history

          # Exit sway (logs you out of your Wayland session)
          # bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'
          bindsym $mod+Shift+e exec exit-prompt-sway
      #
      # Moving around:
      #
          # Move your focus around
          bindsym $mod+$left focus left
          bindsym $mod+$down focus down
          bindsym $mod+$up focus up
          bindsym $mod+$right focus right
          # Or use $mod+[up|down|left|right]
          bindsym $mod+Left focus left
          bindsym $mod+Down focus down
          bindsym $mod+Up focus up
          bindsym $mod+Right focus right

          # Move the focused window with the same, but add Shift
          bindsym $mod+Shift+$left move left
          bindsym $mod+Shift+$down move down
          bindsym $mod+Shift+$up move up
          bindsym $mod+Shift+$right move right
          # Ditto, with arrow keys
          bindsym $mod+Shift+Left move left
          bindsym $mod+Shift+Down move down
          bindsym $mod+Shift+Up move up
          bindsym $mod+Shift+Right move right
      #
      # Workspaces:
      #
          # workspace variables
          set $ws1 "1"
          set $ws2 "2"
          set $ws3 "3"
          set $ws4 "4"
          set $ws5 "5"
          set $ws6 "6"
          set $ws7 "7"
          set $ws8 "8"
          set $ws9 "9"
          set $ws10 "10"
          # Switch to workspace
          bindsym $mod+1 workspace number $ws1
          bindsym $mod+2 workspace number $ws2
          bindsym $mod+3 workspace number $ws3
          bindsym $mod+4 workspace number $ws4
          bindsym $mod+5 workspace number $ws5
          bindsym $mod+6 workspace number $ws6
          bindsym $mod+7 workspace number $ws7
          bindsym $mod+8 workspace number $ws8
          bindsym $mod+9 workspace number $ws9
          bindsym $mod+0 workspace number $ws10
          # Move focused container to workspace
          bindsym $mod+Shift+1 move container to workspace number $ws1
          bindsym $mod+Shift+2 move container to workspace number $ws2
          bindsym $mod+Shift+3 move container to workspace number $ws3
          bindsym $mod+Shift+4 move container to workspace number $ws4
          bindsym $mod+Shift+5 move container to workspace number $ws5
          bindsym $mod+Shift+6 move container to workspace number $ws6
          bindsym $mod+Shift+7 move container to workspace number $ws7
          bindsym $mod+Shift+8 move container to workspace number $ws8
          bindsym $mod+Shift+9 move container to workspace number $ws9
          bindsym $mod+Shift+0 move container to workspace number $ws10
          # Note: workspaces can have any name you want, not just numbers.
          # We just use 1-10 as the default.

          bindsym $mod+Tab workspace next
          bindsym $mod+Shift+Tab workspace prev
      #
      # Layout stuff:
      #
          # You can "split" the current object of your focus with
          # $mod+b or $mod+v, for horizontal and vertical splits
          # respectively.
          bindsym $mod+h split h
          bindsym $mod+v split v

          # Switch the current container between different layout styles
          bindsym $mod+s layout stacking
          bindsym $mod+w layout tabbed
          bindsym $mod+e layout toggle split

          # Make the current focus fullscreen
          bindsym $mod+f fullscreen toggle

          # Toggle the current focus between tiling and floating mode
          bindsym $mod+Shift+space floating toggle

          # Swap focus between the tiling area and the floating area
          bindsym $mod+space focus mode_toggle

          # Move focus to the parent container
          bindsym $mod+a focus parent

          # Remove all borders from applications
          #default_border none
          #default_border normal
          default_border pixel 2
      #
      # Resizing containers:
      #
      mode "resize" {
          # left will shrink the containers width
          # right will grow the containers width
          # up will shrink the containers height
          # down will grow the containers height
          bindsym {
              $left resize shrink width 10px
              $down resize grow height 10px
              $up resize shrink height 10px
              $right resize grow width 10px

              # Ditto, with arrow keys
              Left resize shrink width 10px
              Down resize grow height 10px
              Up resize shrink height 10px
              Right resize grow width 10px

              # Return to default mode
              Return mode "default"
              Escape mode "default"
          }
      }
      bindsym $mod+r mode "resize"

      # Include configs from 3 locations:
      #  - /usr/share/sway/config.d
      #  - /etc/sway/config.d
      #  - $XDG_CONFIG_HOME/sway/config.d ($HOME/.config/sway/config.d)
      #
      # If multiple directories contain the files with the same name, the later
      # directory takes precedence; `$XDG_CONFIG_HOME/sway/config.d/20-swayidle.conf`
      # will always be loaded instead of `/usr/share/sway/config.d/20-swayidle.conf`
      # or `/etc/sway/config.d/20-swayidle.conf`
      #
      # This mechanism permits overriding our default configuration per-system
      # (/etc) or per-user ($XDG_CONFIG_HOME) basis. Just create the file you
      # want to modify/override in the higher-level directory.
      #
      # For example, to disable the default bar from Fedora configs, you'll need to
      #     $ echo -n > "$HOME/.config/sway/config.d/90-bar.conf"
      #
      # Note the quoting, the $() and the arguments quoting. All the parts are equally
      # important to make the magic work. And if you want to learn the secret behind
      # the trick, it's all in the `wordexp(3)`.
      #
      include '$(layered-include "/etc/sway/config.d/*.conf" "''${XDG_CONFIG_HOME:-$HOME/.config}/sway/config.d/*.conf")'
    '';
    ".config/sway/barschemes.d/gruvbox-dark_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"

      bar {
          position top
          font $font
          height 28

          colors {
              # gruvbox dark theme
              background #282828
              statusline #ebdbb2
              separator  #8ec07c
              # <colorclass>      <border>    <background>    <text>
              focused_workspace   #000000     #fabd2f         #ebdbb2
              active_workspace    #928374     #8ec07c         #8ec07c
              inactive_workspace  #282828     #928374         #fabd2f
              urgent_workspace    #000000     #363636         #FF0000
              binding_mode        #000000     #dc322f         #FFFFFF
          }
          status_command SCRIPT_DIR=$HOME/.local/libexec/i3blocks i3blocks -c $HOME/.config/i3blocks/config
          # status_command while $HOME/.local/bin/status_bar.sh; do sleep 1; done
      }
    '';
    ".config/sway/barschemes.d/kali-dark_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"

      bar {
          position top
          font $font
          height 28

          colors {
              # Kali Dark Theme
              background #171421
              statusline #E6E6E6
              separator  #696969
              # <colorclass>      <border>    <background>    <text>
              focused_workspace   #367bf0     #367bf0         #1f2229
              active_workspace    #5ebdab     #367bf0         #1f2229
              inactive_workspace  #171421     #171421         #8a8a8a
              urgent_workspace    #000000     #363636         #FF0000
              binding_mode        #000000     #dc322f         #FFFFFF
          }
          status_command SCRIPT_DIR=$HOME/.local/libexec/i3blocks i3blocks -c $HOME/.config/i3blocks/config
          # status_command while $HOME/.local/bin/status_bar.sh; do sleep 1; done
      }
    '';
    ".config/sway/barschemes.d/pop_OS-dark_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"

      bar {
          position top
          font $font
          height 28

          colors {
              # Pop!_OS Dark Theme
              background #363636
              statusline #cccccc
              separator  #666666
              # <colorclass>      <border>    <background>    <text>
              focused_workspace   #222222     #FFD7A1         #222222
              active_workspace    #FFD7A1     #222222         #FFD7A1
              inactive_workspace  #FFD7A1     #222222         #FFD7A1
              urgent_workspace    #000000     #363636         #FF0000
              binding_mode        #000000     #dc322f         #FFFFFF
          }
          status_command SCRIPT_DIR=$HOME/.local/libexec/i3blocks i3blocks -c $HOME/.config/i3blocks/config
          # status_command while $HOME/.local/bin/status_bar.sh; do sleep 1; done
      }
    '';
    ".config/sway/barschemes.d/solarized_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"

      bar {
          position top
          font $font
          height 28

          colors {
              # Solarized Dark Theme
              background #1f2229
              statusline #fdf6e3
              separator  #93a1a1
              # <colorclass>      <border>    <background>    <text>
              focused_workspace   #000000     #657b83         #fdf6e3
              active_workspace    #002b36     #93a1a1         #93a1a1
              inactive_workspace  #073642     #002b36         #657b83
              urgent_workspace    #000000     #363636         #FF0000
              binding_mode        #000000     #dc322f         #FFFFFF
          }
          status_command SCRIPT_DIR=$HOME/.local/libexec/i3blocks i3blocks -c $HOME/.config/i3blocks/config
          # status_command while $HOME/.local/bin/status_bar.sh; do sleep 1; done
      }
    '';
    ".config/sway/barschemes.d/standard_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"

      bar {
          position top
          font $font
          height 28

          colors {
              # Default Theme
              background #171421
              statusline #E6E6E6
              separator  #696969
              # <colorclass>      <border>    <background>    <text>
              focused_workspace   #83CAFA     #51A2DA         #FFFFFF
              active_workspace    #3C6EB4     #294172         #FFFFFF
              inactive_workspace  #8C8C8C     #4C4C4C         #888888
              urgent_workspace    #000000     #363636         #FF0000
              binding_mode        #000000     #dc322f         #FFFFFF
          }
          status_command SCRIPT_DIR=$HOME/.local/libexec/i3blocks i3blocks -c $HOME/.config/i3blocks/config
          # status_command while $HOME/.local/bin/status_bar.sh; do sleep 1; done
      }
    '';
    ".config/sway/barschemes.d/waybar_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"

      exec waybar -c $HOME/.config/waybar/sway_config
    '';
    ".config/sway/colorschemes.d/client_window_colorscheme-gruvbox-dark.conf".text = ''
      # gruvbox-dark colors
      # class                 border  bground text    indicator child_border
      client.focused          #fabd2f #fabd2f #ebdbb2 #fb4934   #d79921
      client.focused_inactive #b8bb26 #b8bb26 #282828 #fb4934   #b8bb26 
      client.unfocused        #fabd2f #928374 #b8bb26 #fb4934   #222222
    '';
    ".config/sway/colorschemes.d/client_window_colorscheme-kali-dark.conf".text = ''
      # Kali Dark colors
      # class                 border  bground text    indicator child_border
      client.focused          #9755b3 #171421 #E6E6E6 #5ebdab   #9755b3
      client.focused_inactive #545454 #232121 #9C8361 #5ebdab   #545454
      client.unfocused        #1f2229 #232121 #9C8361 #5ebdab   #1f2229 
    '';
    ".config/sway/colorschemes.d/client_window_colorscheme-pop_os-dark.conf".text = ''
      # Pop!_OS Dark colors
      # class                 border  bground text    indicator child_border
      client.focused          #736148 #736148 #ffffff #cb4b16   #736148
      client.focused_inactive #736148 #232121 #9C8361 #cb4b16   #737373
      client.unfocused        #232121 #232121 #4d4d4d #cb4b16   #222222
    '';
    ".config/sway/colorschemes.d/client_window_colorscheme-solarized-dark.conf".text = ''
      # solarized-dark colors
      # class                 border  bground text    indicator child_border
      client.focused          #657B83 #657B83 #fdf6e3 #cb4b16   #b58900
      client.focused_inactive #586e75 #586e75 #073642 #cb4b16   #586e75 
      client.unfocused        #657B83 #002B36 #586e75 #cb4b16   #222222
    '';
    ".config/sway/colorschemes.d/client_window_colorscheme-standard.conf".text = ''
      # Standard colors
      # class                 border  bground text    indicator child_border
      client.focused          #83CAFA #51A2DA #FFFFFF #83CAFA   #51A2DA
      client.focused_inactive #8C8C8C #4C4C4C #FFFFFF #4C4C4C   #8C8C8C
      client.unfocused        #4C4C4C #222222 #888888 #292D2E   #222222
    '';
    ".config/sway/config.d/05-notification.conf".text = ''
      # Launch notification daemon

      exec $notification_daemon
    '';
    ".config/sway/config.d/05-saveclipboard.conf".text = ''
      # Launch cliphist

      # Stores only text data
      exec wl-paste --type text --watch cliphist store
      # Stores only image data
      exec wl-paste --type image --watch cliphist store

      set $clipboard_history cliphist list | $launcher -p "Clipboard: " | cliphist decode | wl-copy
    '';
    ".config/sway/config.d/05-systemd-user.conf".text = ''
      # Adapted from xorg's 50-systemd-user.sh, which achieves a similar goal.

      exec dbus-environment-sway
    '';
    ".config/sway/config.d/10-client-window-colors.conf".text = ''
      # Client window highlight colors
      include $HOME/.config/sway/colorscheme.conf

      client.urgent           #dc322f #DB3279 #FFFFFF #DB3279   #DB3279
      client.placeholder      #000000 #0C0C0C #FFFFFF #000000   #0C0C0C

      client.background       #000000
    '';
    ".config/sway/config.d/10-gtk-settings.conf".text = ''
      # import gtk settings
    
      exec configure-gtk
    '';
    ".config/sway/config.d/20-inputs.conf".text = ''
      # SwayWM input configuration. For detailed information type "man sway-input"
      # For a list of devices run: swaymsg -t get_inputs

      # Provide all keyboards connected the following configuration
      input type:keyboard {
          xkb_layout us
      }

      # Provide all touchpads and mice the same configuration
      input type:pointer {
          natural_scroll disabled
          middle_emulation disabled
      }

      input type:touchpad {
          tap disabled
          dwt enabled
          accel_profile adaptive
          click_method clickfinger
          tap_button_map lrm
          scroll_method two_finger
          natural_scroll disabled
          middle_emulation disabled
      }
    '';
    ".config/sway/config.d/20-outputs.conf".text = ''
      # SwayWM outputs configuration. For detailed information type "man sway"
      # For a list of devices run: swaymsg -t get_outputs

      # Devices
      set $display_laptop eDP-1
      set $display_external DP-1

      # Disable main laptop screen
      bindsym $mod+F7 output $display_laptop disable
      bindsym $mod+F8 output $display_laptop enable
    '';
    ".config/sway/config.d/25-scratchpad.conf".text = ''
      # SwayWM scratchpad configuration. For detailed information type "man sway"
      #
      # Scratchpad:
      #
      # Sway has a "scratchpad", which is a bag of holding for windows.
      # You can send windows there and get them back later.

      # Move the currently focused window to the scratchpad
      bindsym $mod+Shift+minus move scratchpad

      # Show the next scratchpad window or hide the focused scratchpad window.
      # If there are multiple scratchpad windows, this command cycles through them.
      bindsym $mod+minus scratchpad show

      # Audio effects
      for_window [app_id="com.github.wwmm.easyeffects"] move window to scratchpad
      bindsym $mod+backslash [app_id="com.github.wwmm.easyeffects"] scratchpad show, move position center, resize set 1280 800
      #exec "flatpak run --branch=stable --arch=x86_64 --command=easyeffects com.github.wwmm.easyeffects"
      exec easyeffects

      # Calculator
      for_window [app_id="qalculate-gtk"] move window to scratchpad
      bindsym $mod+c [app_id="qalculate-gtk"] scratchpad show, move position center, resize set 900 600
      exec qalculate-gtk
    '';
    ".config/sway/config.d/50-rules-browser.conf".text = ''
      # apply mark for Xwayland and wayland native browser windows
      for_window [class="Chromium-browser"] mark Browser
      for_window [class="Brave-browser"] mark Browser
      for_window [class="firefox"]  mark Browser
      for_window [app_id="Chromium-browser"] mark Browser
      for_window [app_id="brave-browser"] mark Browser
      for_window [app_id="firefox"] mark Browser

      # inhibit scrensaver for fullscreen browser windows
      for_window [con_mark="Browser"] {
          inhibit_idle fullscreen
      }

      # firefox wayland screensharing indicator
      for_window [app_id="firefox" title="Firefox — Sharing Indicator"] {
          floating enable
      }
    '';
    ".config/sway/config.d/50-rules-pavucontrol.conf".text = ''
      # Display PulseAudio volume control application (both GTK and Qt varieties)
      # as a floating window.

      for_window [app_id="pavucontrol"] {
          floating enable
          move position center
      }

      for_window [app_id="pavucontrol-qt"] {
          floating enable
          move position center
      }
    '';
    ".config/sway/config.d/50-rules-policykit-agent.conf".text = ''
      for_window [app_id="lxqt-policykit-agent"] {
          floating enable
          move position center
      }
    '';
    ".config/sway/config.d/60-bindings-brightness.conf".text = ''
      # Key bindings for brightness control using `light` or `brightnessctl`.
      # Displays a notification with the current value if notify-send is available
      #
      # Brightness increase/decrease step can be customized by setting the `$brightness_step`
      # variable to a numeric value before including the file.
      #
      # Requires:     brightnessctl or light
      # Recommends:   libnotify

      set $brightness_step 5

      # The following steps use `light`
      #set $brightness_notification_cmd command -v ${pkgs.libnotify}/bin/notify-send >/dev/null && \
      #        VALUE=$(`which light`) && VALUE=''${VALUE%%.*} && \
      #        ${pkgs.libnotify}/bin/notify-send -e -h string:x-canonical-private-synchronous:brightness \
      #            -h "int:value:$VALUE" -t 800 "Brightness: ''${VALUE}%"
      #
      #bindsym XF86MonBrightnessDown exec \
      #        'STEP="$brightness_step" && `which light` -U ''${STEP:-5} && $brightness_notification_cmd'
      #bindsym XF86MonBrightnessUp exec \
      #        'STEP="$brightness_step" && `which light` -A ''${STEP:-5} && $brightness_notification_cmd'

      # The following steps use `brightnessctl`
      set $brightness_notification_cmd command -v ${pkgs.libnotify}/bin/notify-send >/dev/null && \
              VALUE=$(`which brightnessctl` -m | cut -d ',' -f 4) && VALUE=''${VALUE%?} && \
              ${pkgs.libnotify}/bin/notify-send -e -h string:x-canonical-private-synchronous:brightness \
                  -h "int:value:$VALUE" -t 800 "Brightness: ''${VALUE}%"

      bindsym XF86MonBrightnessDown exec \
              STEP="$brightness_step" && `which brightnessctl` set ''${STEP:-5}%- && $brightness_notification_cmd
      bindsym XF86MonBrightnessUp exec \
              STEP="$brightness_step" && `which brightnessctl` set +''${STEP:-5}% && $brightness_notification_cmd
    '';
    ".config/sway/config.d/60-bindings-media.conf".text = ''
      # Key bindings for media player control via MPRIS D-Bus interface
      #
      # Requires:     playerctl

      # Allow Play and Stop bindings even if the screen is locked
      bindsym --locked {
          XF86AudioPlay       exec playerctl play-pause
          XF86AudioStop       exec playerctl stop
      }

      bindsym {
          XF86AudioForward    exec playerctl position +10
          XF86AudioNext       exec playerctl next
          XF86AudioPause      exec playerctl pause
          XF86AudioPrev       exec playerctl previous
          XF86AudioRewind     exec playerctl position -10
      }
    '';
    ".config/sway/config.d/60-bindings-screenshot.conf".text = ''
      # Key bindings for taking screenshots
      #
      # The image files will be written to XDG_SCREENSHOTS_DIR if this is set
      # or defined in user-dirs.dir, or to a fallback location XDG_PICTURES_DIR.
      #
      # Copy the file to ~/.config/sway/config.d/60-bindings-screenshot.conf (or to
      # your $XDG_CONFIG_HOME location if set differently) to be able to overwrite
      # existing shortcuts.
      # Check 'man grim' for additional commands that you may find useful.
      #
      # Requires:     grim and slurp

      #
      # Screen capture
      #
      set $screenshot 1 select, 2 window, 3 all, 4 pixel color, 5 select (clipboard), 6 window (clipboard), 7 all (clipboard), 8 pixel color (clipboard)
      mode "$screenshot" {
          bindsym {
              1 exec 'grim -g "$(slurp)" $(xdg-user-dir PICTURES)/ps_$(date +"%Y%m%d%H%M%S").png', mode "default"
              2 exec 'grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" $(xdg-user-dir PICTURES)/ps_$(date +"%Y%m%d%H%M%S").png', mode "default"
              3 exec 'grim $(xdg-user-dir PICTURES)/ps_$(date +"%Y%m%d%H%M%S").png', mode "default"
              4 exec 'grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:-', mode "default"
              5 exec 'grim -g "$(slurp)" - | wl-copy', mode "default"
              6 exec 'grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" - | wl-copy', mode "default"
              7 exec 'grim - | wl-copy', mode "default"
              8 exec 'grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | wl-copy', mode "default"
          }
      # back to normal: Enter or Escape
          bindsym {
              Return mode "default"
              Escape mode "default"
              $mod+Print mode "default"
          }
      }
      bindsym Print mode "$screenshot"
    '';
    ".config/sway/config.d/60-bindings-volume.conf".text = ''
      # Key bindings to control pipewire or pulseaudio volume with pactl.
      # Displays a notification with the current state if notify-send is available
      #
      # Volume increase/decrease step can be customized by setting the `$volume_step`
      # variable to a numeric value before including the file.
      # Maximum volume boost level can be set with the `$volume_limit` variable.
      #
      # Requires:     pulseaudio-utils
      # Recommends:   libnotify

      set $volume_helper_cmd volume-helper-sway
      # Allow volume controls even if the screen is locked
      bindsym --locked {
          XF86AudioRaiseVolume exec \
              $volume_helper_cmd --limit "$volume_limit" --increase "$volume_step"
          XF86AudioLowerVolume exec \
              $volume_helper_cmd --limit "$volume_limit" --decrease "$volume_step"
          XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          #XF86AudioMute    exec pactl set-sink-mute @DEFAULT_SINK@ toggle && $volume_helper_cmd
          #XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle
      }
    '';
    ".config/sway/config.d/65-mode-passthrough.conf".text = ''
      # A special mode for passing any keybindings to the focused application

      mode "passthrough" {
          bindsym $mod+Pause mode default
      }
      bindsym $mod+Pause mode "passthrough"
    '';
    ".config/sway/config.d/90-bar.conf".text = ''
      # load user-selected barscheme

      include $HOME/.config/sway/barscheme.conf
    '';
    ".config/sway/config.d/90-swayidle.conf".text = ''
      # Idle and lock configuration
      #
      # This will lock your screen after 300 seconds of inactivity, then turn off
      # your displays after another 60 seconds, and turn your screens back on when
      # resumed. It will also lock your screen before your computer goes to sleep.
      # The timeouts can be customized via `$lock_timeout` and `$screen_timeout`
      # variables. For a predictable behavior, keep the `$screen_timeout` value
      # lesser than the `$lock_timeout`.
      #
      # You can also lock the screen manually by running `loginctl lock-session` or
      # add a binding for the command. Example:
      #     bindsym $mod+Shift+Escape  exec loginctl lock-session
      #
      # Note that all swaylock customizations are handled via /etc/swaylock/config and
      # can be overridden via $XDG_CONFIG_HOME/swaylock/config (~/.config/swaylock/config).
      #
      # Requires: swayidle
      # Requires: swaylock
      # Requires: /usr/bin/pkill, /usr/bin/pgrep

      exec LT="$lock_timeout" ST="$screen_timeout" LT=''${LT:-300} ST=''${ST:-60} && \
          swayidle -w \
              timeout $LT 'swaylock -f -i $lockscreenbg' \
              timeout $((LT + ST)) 'swaymsg "output * power off"' \
                            resume 'swaymsg "output * power on"'  \
              timeout $ST 'pgrep -xu "$USER" swaylock >/dev/null && swaymsg "output * power off"' \
                   resume 'pgrep -xu "$USER" swaylock >/dev/null && swaymsg "output * power on"'  \
              before-sleep 'swaylock -f -i $lockscreenbg' \
              lock 'swaylock -f -i $lockscreenbg' \
              unlock 'pkill -xu "$USER" -SIGUSR1 swaylock'

      # Lock the screen
      bindsym $mod+Delete exec "swaylock -f -i $lockscreenbg"
    '';
    ".config/sway/config.d/95-policykit-agent-autostart.conf".text = ''
      # Start graphical authentication agent for PolicyKit.
      #
      # Certain applications may require this to request elevated privileges:
      #   GParted, virt-manager, anything that uses pkexec
      #
      # Requires: plasma6 or polkit_gnome

      # If installed side-by-side with gnome
      exec systemctl --user start polkit-gnome-authentication-agent-1.service
      # If installed side-by-side with plasma desktop
      exec systemctl --user start plasma-polkit-agent.service
    '';
    ".config/sway/config.d/95-xdg-desktop-autostart.conf".text = ''
      # setup desktop agnostic xdg-desktop-portal to use wlroots and GTK GUIs
      exec ${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk -r
      exec ${pkgs.xdg-desktop-portal-wlr}/libexec/xdg-desktop-portal-wlr -r
      exec "sh -c 'sleep 5;exec ${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal -r'"

      # Start XDG autostart .desktop files using dex. See also
      # https://wiki.archlinux.org/index.php/XDG_Autostart
      exec dex --autostart --environment sway
    '';
    ".config/sway/config.d/95-xdg-user-dirs.conf".text = ''
      # Create or update XDG user dir configuration
      #
      # See also:
      #  - /etc/xdg/autostart/xdg-user-dirs.desktop
      #  - https://github.com/systemd/systemd/issues/18791
      #
      # Recommends: xdg-user-dirs

      exec xdg-user-dirs-update
    '';
     ".config/sway/config.d/95-xsettingsd-tiling.conf".text = ''

        # import xsettings
        exec systemctl --user start xsettingsd-tiling.service
    '';
  };
}
