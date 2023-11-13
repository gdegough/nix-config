{
  inputs,
  lib,
  config,
  pkgs,
  ...,
}:
#with lib.hm.gvariant;
{
  home.file = {
    ".config/sway/config".text = ''
      # SwayWM global configuration. For detailed information type "man sway"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      ###############################################################################
      # TODO:
      #   + Sway:
      #      - Autoassign workspaces to certain applications
      #
      ###############################################################################

      #########################
      # Run services
      #########################
      #exec mako
      #exec waybar

      #########################
      # Main definitions
      #########################
      output HDMI-A-1 resolution 3840x2160@59.997Hz scale 1.5 position 0,0

      # Logo key. Use Mod1 for Alt.
      set $mod Mod4

      # Preferred font for universal usage
      set $font "pango:IBM Plex Mono Text 10"

      # Preferred font
      font $font

      # Your preferred terminal emulator
      set $term foot --config=$HOME/.config/foot/foot.ini
      #set $term alacritty --config-file $HOME/.config/alacritty/alacritty.yml

      # Your preferred application launcher
      # Note: pass the final command to swaymsg so that the resulting window can be opened
      # on the original workspace that the command was run on.
      # Recommends: rofi-wayland
      set $rofi_cmd rofi -terminal '$term'
      # Shows a combined list of the applications with desktop files and
      # executables from PATH.
      # TODO: add window with the next release of rofi-wayland
      set $menu $rofi_cmd -show combi -combi-modes drun#run -modes combi
      #set $menu wofi --show run -Iib -l 5 -W 500 -x -10 -y -51
      #set $menu rofi -terminal foot -theme ~/.config/sway/rofi/flat-orange.rasi -show run
      #set $menu wofi --show drun,run

      # Your preferred browser (firefox, vivaldi-stable, qutebrowser)
      set $browser firefox

      # Default wallpaper
      set $wallpaper $HOME/.config/sway/wallpaper

      # Default lockscreen background
      set $lockscreenbg $HOME/.config/sway/lockscreen

      # Remove all borders from applications
      #default_border none
      #default_border normal
      default_border pixel 2

      # Stablish gaps between windows and from the screen edge
      #gaps inner 5
      #gaps outer 1


      #########################
      # Main keybindings
      #########################
      # Start a terminal
      bindsym $mod+Return exec --no-startup-id $term

      # Start a browser
      bindsym $mod+b exec --no-startup-id $browser

      # Kill focused window
      bindsym $mod+Shift+q kill

      # Start your launcher
      bindsym $mod+slash exec --no-startup-id $menu

      # Drag floating windows by holding down $mod and left mouse button.
      # Resize them with right mouse button + $mod.
      # Despite the name, also works for non-floating windows.
      # Change normal to inverse to use left mouse button for resizing and right
      # mouse button for dragging.
      floating_modifier $mod normal

      # Reload the configuration file. Be aware that some changes might need
      # a session logout (gaps, for example)
      bindsym $mod+Shift+c reload

      # Exit sway (logs you out of your Wayland session)
      bindsym $mod+Shift+e exec swaynag -t warning -m 'Do you really want to exit sway?' -b 'Yes, exit sway' 'swaymsg exit'

      include /etc/sway/config.d/*.conf
      include $HOME/.config/sway/config.d/*.conf
      #include $HOME/.config/sway/custom.d/*.conf
    '';
    ".config/sway/README.md".text = ''
      # Sway WM configurations

      To install this configurations in your system copy the **content** of the folder
      *"sway_wm"* into your home's *.config/sway* folder, then reload your sway
      configuration (usually **Mod+Shift+C**)

      **REMEMBER**
      If you have previous configurations this will overwrite them or collide with
      some of your shortcut definitions, make sure to backup your configurations first!

      ![Screenshot](https://i.postimg.cc/zDpD7mcf/2019-02-05-17-13-14-screenshot.png)

      # Requirements

      These configurations use the following software/fonts/things:

      * [Kitty](https://sw.kovidgoyal.net/kitty/)
      * [Terminus (TTF) font](https://aur.archlinux.org/packages/terminus-font-ttf/)
      * [mako](https://github.com/emersion/mako) [Arch package](https://www.archlinux.org/packages/community/x86_64/mako/)
      * pavucontrol / pactl
      * swaylock
      * swayidle
      * swaybg
      * [wofi](https://hg.sr.ht/~scoopta/wofi) [Arch package](https://www.archlinux.org/packages/community/x86_64/wofi/)
      * [playerctl](https://github.com/acrisci/playerctl) [Arch package](https://www.archlinux.org/packages/community/x86_64/playerctl/)
      * [light](https://github.com/haikarainen/light) [AUR package](https://aur.archlinux.org/packages/light-git)
      * [grimshot](https://github.com/swaywm/sway/tree/master/contrib) [AUR package](https://aur.archlinux.org/packages/grimshot/)
      * [waybar](https://github.com/Alexays/Waybar) [Arch package](https://www.archlinux.org/packages/community/x86_64/waybar/)

      # Keybindings (case insensitive)

      You will find that most of this keybindings are the same as the default ones
      with some additions made by me.

      *Mod* key is mapped to Windows/Logo/Command key

      ## Actions
      * **Mod + Enter** New terminal
      * **Mod + L** Lock screen
      * **Mod + X** Run dialog
      * **Mod + F** Make current window fullscreen
      * **Mod + S** Take screenshot of entire screen (saved in Pictures folder)
      * **Mod + Shift + S** Take screenshot of an area (saved in Pictures folder)
      * **Mod + Shift + Q** Quit program
      * **Mod + Shift + E** Exit Sway
      * **Mod + Shift + C** Reload Sway configuration
      * **Mod + Shift + -** Move window to scratchpad
      * **Mod + -** Show scratchpad

      ## Workspaces keys

      * **Mod + 0..9** Change current workspace
      * **Mod + Shift + 0..9** Move current window to designated workspace
      * **Mod + B** Horizontal layout
      * **Mod + V** Vertical layout
      * **Mod + T** Stacking layout
      * **Mod + E** Toggle split layout
      * **Mod + W** Tabbed layout
      * **Mod + A** Focus on parent container
      * **Mod + Space** Swap focus between tiling and floating
      * **Mod + Shift + Space** Toggle floating mode
      * **Mod + Tab** Next workspace
      * **Mod + Shift + Tab** Previous workspace
      * **Mod + Left/Right/Up/Down** Move focus of the window
      * **Mod + Shift + Left/Right/Up/Down** Move the focused window in the workspace

      ## Multimedia/system keys

      **NOTE**: The sound bindings expect to have at least one analog output, which
                they will use for sound. If your configuration differs, you have
                to change the *pactl* command that detects the output number
                in *config.d/multimedia*

      * **Mod + F1** Mute/Unmute sound
      * **Mod + F2** Decrease volume 2%
      * **Mod + F3** Increase volume 2%
      * **Mod + F4** Jump to previous song (MPRIS players only)
      * **Mod + F5** Play/Pause song
      * **Mod + F6** Jump to next song
      * **Mod + F7** Disable eDP-1 display (usually laptop screen)
      * **Mod + F8** Enable eDP-1 display (usually laptop screen)
      * **Mod + F9** Decrease screen brightness 5%
      * **Mod + F10** Increase screen brightness 5%
      * **Alt + Shift** Change keyboard language

      # Resize mode

      To resize windows, you must enter resize mode, with the **Mod + R** keybinding. After
      you enter resize mode you can resize windows with *Left/Right/Up/Down* keys, and
      press *enter* or *escape* to return to default mode.

      # Custom bindings

      If you have custom bindings for your hardware put them into the `config.d/custom`
      directory. In my case I have custom bindings for:

      * Logitech MX Master 3 (side buttons for changing workspace)
      * DasKeyboard 4 Ultimate (Multimedia keys)
    '';
    ".config/sway/config.d/10-systemd-user.conf".text = ''
      # sway does not set DISPLAY/WAYLAND_DISPLAY in the systemd user environment
      # See FS#63021
      # Adapted from xorg's 50-systemd-user.sh, which achieves a similar goal.

      exec --no-startup-id systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK QT_QPA_PLATFORMTHEME 
      exec --no-startup-id hash dbus-update-activation-environment 2>/dev/null && \
        dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK QT_QPA_PLATFORMTHEME
    '';
    ".config/sway/config.d/client-window-colors.conf".text = ''
      # Client window highlight colors
      include $HOME/.config/sway/colorscheme.conf

      client.urgent           #dc322f #DB3279 #FFFFFF #DB3279   #DB3279
      client.placeholder      #000000 #0C0C0C #FFFFFF #000000   #0C0C0C

      client.background       #000000
    '';
    ".config/sway/config.d/gnome-settings.conf".text = ''
      # import gnome settings and gnome authentication
      exec_always --no-startup-id {
      #    systemctl --user import-environment
          systemctl --user start xsettingsd
      #    gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
      #    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
      #    gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
      #    gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
      #    test -e $SWAYSOCK.wob || mkfifo $SWAYSOCK.wob
      #    tail -f $SWAYSOCK.wob | wob --background-color '#FF002B36' --border-color '#FF92A2A2' --bar-color '#FF92A2A2'
      #    tail -f $SWAYSOCK.wob | wob --background-color '#FF232121' --border-color '#FF93EAEA' --bar-color '#FF93EAEA'
      }
    '';
    ".config/sway/config.d/inputs.conf".text = ''
      # SwayWM input configuration. For detailed information type "man sway-input"
      # For a list of devices run: swaymsg -t get_inputs
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

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
    ".config/sway/config.d/multimedia.conf".text = ''
      # SwayWM multimedia keys configuration. For detailed information type "man sway"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # Audio
      bindsym --locked XF86AudioRaiseVolume exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%+
      bindsym --locked XF86AudioLowerVolume exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%-
      bindsym --locked XF86AudioMute exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

      # Media
      bindsym XF86AudioPlay exec --no-startup-id playerctl play-pause
      bindsym XF86AudioNext exec --no-startup-id playerctl next
      bindsym XF86AudioPrev exec --no-startup-id playerctl previous

      # Backlight
      # PLEASE NOTE: Light has a small issue with SUID, you should install the version
      # that allows the user to run it without SUID
      bindsym XF86MonBrightnessDown exec --no-startup-id /bin/sh -c "sudo brightnessctl -q set 2%- && ( echo $((`brightnessctl get` * 100 / `brightnessctl m`)) > $SWAYSOCK.wob )"
      bindsym XF86MonBrightnessUp exec --no-startup-id /bin/sh -c "sudo brightnessctl -q set +2% && ( echo $((`brightnessctl get` * 100 / `brightnessctl m`)) > $SWAYSOCK.wob )"

      # Screenshot
      #bindsym $mod+S exec --no-startup-id grimshot save screen $HOME/Pictures/$(date '+%Y-%m-%d-%T')-screenshot.png
      #bindsym $mod+Shift+S exec --no-startup-id grimshot save area $HOME/Pictures/$(date '+%Y-%m-%d-%T')-screenshot.png
    '';
    ".config/sway/config.d/outputs.conf".text = ''
      # SwayWM outputs configuration. For detailed information type "man sway"
      # For a list of devices run: swaymsg -t get_outputs
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # Default wallpaper
      output * bg $wallpaper fill

      # Devices
      #set $display_laptop eDP-1
      #set $display_external DP-1

      # Disable main laptop screen
      #bindsym $mod+F7 output $display_laptop disable
      #bindsym $mod+F8 output $display_laptop enable
    '';
    ".config/sway/config.d/scratchpad.conf".text = ''
      # SwayWM scratchpad configuration. For detailed information type "man sway"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # Scratchpad:

      # Sway has a "scratchpad", which is a bag of holding for windows.
      # You can send windows there and get them back later.

      # Move the currently focused window to the scratchpad
      bindsym $mod+Shift+minus move scratchpad

      # Show the next scratchpad window or hide the focused scratchpad window.
      # If there are multiple scratchpad windows, this command cycles through them.
      bindsym $mod+minus scratchpad show

      # Password manager
      for_window [class="Bitwarden"] move window to scratchpad
      bindsym $mod+z [class="Bitwarden"] scratchpad show, move position center, resize set 900 600
      #exec --no-startup-id "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=bitwarden --file-forwarding com.bitwarden.desktop"
      exec --no-startup-id bitwarden

      # Sonic effects
      for_window [app_id="com.github.wwmm.easyeffects"] move window to scratchpad
      bindsym $mod+backslash [app_id="com.github.wwmm.easyeffects"] scratchpad show, move position center, resize set 1280 800
      #exec --no-startup-id "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=easyeffects com.github.wwmm.easyeffects"
      exec --no-startup-id easyeffects

      # Calculator
      for_window [app_id="qalculate-gtk"] move window to scratchpad
      bindsym $mod+c [app_id="qalculate-gtk"] scratchpad show, move position center, resize set 900 600
      exec --no-startup-id qalculate-gtk

      # tidal-hifi
      #for_window [class="tidal-hifi"] move window to scratchpad
      #bindsym $mod+p [class="tidal-hifi"] scratchpad show, move position center, resize set 1280 800
      #exec --no-startup-id "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=com.mastermindzh.tidal-hifi com.mastermindzh.tidal-hifi"

      # Plexamp
      for_window [class="Plexamp"] move window to scratchpad
      bindsym $mod+p [class="Plexamp"] scratchpad show, move position center, resize set 250 500
      #exec --no-startup-id "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=startplexamp com.plexamp.Plexamp"
      exec --no-startup-id plexamp

      # MIDI Synthesizer
      for_window [class="Qsynth"] move window to scratchpad
      bindsym $mod+m [class="Qsynth"] scratchpad show, move position center, resize set 825 210

      # JACK Control
      for_window [class="QjackCtl"] move window to scratchpad
      bindsym $mod+i [class="QjackCtl"] scratchpad show, move position center, resize set 480 110
    '';
    ".config/sway/config.d/screenlock_powersave.conf".text = ''
      # SwayWM idle/lock configuration. For detailed information type "man sway-idle"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # Example configuration:
      #
      exec --no-startup-id swayidle -w \
          timeout 900 'swaylock -f -i $lockscreenbg' \
          timeout 1200 'swaymsg "output * dpms off"' \
          resume 'swaymsg "output * dpms on"' \
          before-sleep 'swaylock -f -i $lockscreenbg'

      # Lock the screen
      bindsym $mod+Delete exec --no-startup-id "swaylock -f -i $lockscreenbg"
    '';
    ".config/sway/config.d/statusbar.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # The old sway bar configuration is kept for archiving purposes, it works
      # fine, so if you want, you can activate it and comment the 'waybar' line on
      # the main configuration.
      include $HOME/.config/sway/barscheme.conf
    '';
    ".config/sway/config.d/workspaces.conf".text = ''
      # SwayWM workspaces configuration. For detailed information type "man sway"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      ### Moving containers
      #
      # Home row direction keys, like vim
      set $left j
      set $down k
      set $up l
      set $right semicolon

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

      ### Workspaces
      # Define names for default workspaces for which we configure key bindings later on.
      # We use variables to avoid repeating the names in multiple places.
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

      # switch to workspace
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

      # move focused container to workspace
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

      bindsym $mod+Tab workspace next
      bindsym $mod+Shift+Tab workspace prev

      ### Resizing containers
      # resize window (you can also use the mouse for that)
      mode "resize" {
          # These bindings trigger as soon as you enter the resize mode

          # Pressing left will shrink the window’s width.
          # Pressing right will grow the window’s width.
          # Pressing up will shrink the window’s height.
          # Pressing down will grow the window’s height.
          bindsym $left resize shrink width 5 px or 5 ppt
          bindsym $down resize grow height 5 px or 5 ppt
          bindsym $up resize shrink height 5 px or 5 ppt
          bindsym $right resize grow width 5 px or 5 ppt

          # same bindings, but for the arrow keys
          bindsym Left resize shrink width 5 px or 5 ppt
          bindsym Down resize grow height 5 px or 5 ppt
          bindsym Up resize shrink height 5 px or 5 ppt
          bindsym Right resize grow width 5 px or 5 ppt

          # back to normal: Enter or Escape or $mod+r
          bindsym Return mode "default"
          bindsym Escape mode "default"
          bindsym $mod+r mode "default"
      }
      bindsym $mod+r mode "resize"

      ## manipulate gaps (for i3)
      #set $mode_gaps Gaps: (o)uter, (i)nner, (h)orizontal, (v)ertical, (t)op, (r)ight, (b)ottom, (l)eft
      #set $mode_gaps_outer Outer Gaps: +|-|0 (local), Shift + +|-|0 (global)
      #set $mode_gaps_inner Inner Gaps: +|-|0 (local), Shift + +|-|0 (global)
      #set $mode_gaps_horiz Horizontal Gaps: +|-|0 (local), Shift + +|-|0 (global)
      #set $mode_gaps_verti Vertical Gaps: +|-|0 (local), Shift + +|-|0 (global)
      #set $mode_gaps_top Top Gaps: +|-|0 (local), Shift + +|-|0 (global)
      #set $mode_gaps_right Right Gaps: +|-|0 (local), Shift + +|-|0 (global)
      #set $mode_gaps_bottom Bottom Gaps: +|-|0 (local), Shift + +|-|0 (global)
      #set $mode_gaps_left Left Gaps: +|-|0 (local), Shift + +|-|0 (global)
      #bindsym $mod+Shift+g mode "$mode_gaps"
      #
      #mode "$mode_gaps" {
      #    bindsym o      mode "$mode_gaps_outer"
      #    bindsym i      mode "$mode_gaps_inner"
      #    bindsym h      mode "$mode_gaps_horiz"
      #    bindsym v      mode "$mode_gaps_verti"
      #    bindsym t      mode "$mode_gaps_top"
      #    bindsym r      mode "$mode_gaps_right"
      #    bindsym b      mode "$mode_gaps_bottom"
      #    bindsym l      mode "$mode_gaps_left"
      #    bindsym Return mode "$mode_gaps"
      #    bindsym Escape mode "default"
      #}
      #
      #mode "$mode_gaps_outer" {
      #    bindsym plus  gaps outer current plus 5
      #    bindsym minus gaps outer current minus 5
      #    bindsym 0     gaps outer current set 0
      #
      #    bindsym Shift+plus  gaps outer all plus 5
      #    bindsym Shift+minus gaps outer all minus 5
      #    bindsym Shift+0     gaps outer all set 0
      #
      #    bindsym Return mode "$mode_gaps"
      #    bindsym Escape mode "default"
      #}
      #mode "$mode_gaps_inner" {
      #    bindsym plus  gaps inner current plus 5
      #    bindsym minus gaps inner current minus 5
      #    bindsym 0     gaps inner current set 0
      #
      #    bindsym Shift+plus  gaps inner all plus 5
      #    bindsym Shift+minus gaps inner all minus 5
      #    bindsym Shift+0     gaps inner all set 0
      #
      #    bindsym Return mode "$mode_gaps"
      #    bindsym Escape mode "default"
      #}
      #mode "$mode_gaps_horiz" {
      #    bindsym plus  gaps horizontal current plus 5
      #    bindsym minus gaps horizontal current minus 5
      #    bindsym 0     gaps horizontal current set 0
      #
      #    bindsym Shift+plus  gaps horizontal all plus 5
      #    bindsym Shift+minus gaps horizontal all minus 5
      #    bindsym Shift+0     gaps horizontal all set 0
      #
      #    bindsym Return mode "$mode_gaps"
      #    bindsym Escape mode "default"
      #}
      #mode "$mode_gaps_verti" {
      #    bindsym plus  gaps vertical current plus 5
      #    bindsym minus gaps vertical current minus 5
      #    bindsym 0     gaps vertical current set 0
      #
      #    bindsym Shift+plus  gaps vertical all plus 5
      #    bindsym Shift+minus gaps vertical all minus 5
      #    bindsym Shift+0     gaps vertical all set 0
      #
      #    bindsym Return mode "$mode_gaps"
      #    bindsym Escape mode "default"
      #}
      #mode "$mode_gaps_top" {
      #    bindsym plus  gaps top current plus 5
      #    bindsym minus gaps top current minus 5
      #    bindsym 0     gaps top current set 0
      #
      #    bindsym Shift+plus  gaps top all plus 5
      #    bindsym Shift+minus gaps top all minus 5
      #    bindsym Shift+0     gaps top all set 0
      #
      #    bindsym Return mode "$mode_gaps"
      #    bindsym Escape mode "default"
      #}
      #mode "$mode_gaps_right" {
      #    bindsym plus  gaps right current plus 5
      #    bindsym minus gaps right current minus 5
      #    bindsym 0     gaps right current set 0
      #
      #    bindsym Shift+plus  gaps right all plus 5
      #    bindsym Shift+minus gaps right all minus 5
      #    bindsym Shift+0     gaps right all set 0
      #
      #    bindsym Return mode "$mode_gaps"
      #    bindsym Escape mode "default"
      #}
      #mode "$mode_gaps_bottom" {
      #    bindsym plus  gaps bottom current plus 5
      #    bindsym minus gaps bottom current minus 5
      #    bindsym 0     gaps bottom current set 0
      #
      #    bindsym Shift+plus  gaps bottom all plus 5
      #    bindsym Shift+minus gaps bottom all minus 5
      #    bindsym Shift+0     gaps bottom all set 0
      #
      #    bindsym Return mode "$mode_gaps"
      #    bindsym Escape mode "default"
      #}
      #mode "$mode_gaps_left" {
      #    bindsym plus  gaps left current plus 5
      #    bindsym minus gaps left current minus 5
      #    bindsym 0     gaps left current set 0
      #
      #    bindsym Shift+plus  gaps left all plus 5
      #    bindsym Shift+minus gaps left all minus 5
      #    bindsym Shift+0     gaps left all set 0
      #
      #    bindsym Return mode "$mode_gaps"
      #    bindsym Escape mode "default"
      #}

      ### Layout
      # split in horizontal orientation
      bindsym $mod+h split h

      # split in vertical orientation
      bindsym $mod+v split v

      # enter fullscreen mode for the focused container
      bindsym $mod+f fullscreen toggle

      # Switch the current container between different layout styles
      bindsym $mod+s layout stacking
      bindsym $mod+w layout tabbed
      bindsym $mod+e layout toggle split

      # Toggle the current focus between tiling and floating mode
      bindsym $mod+Shift+space floating toggle

      # Swap focus between the tiling area and the floating area
      bindsym $mod+space focus mode_toggle

      # move focus to the parent container
      bindsym $mod+a focus parent

      # focus the child container
      #bindsym $mod+d focus child
    '';
    ".config/sway/config.d/xdg-portal.conf".text = ''
      # setup desktop agnostic xdg-desktop-portal to use wlroots and GTK GUIs
      exec --no-startup-id /usr/libexec/xdg-desktop-portal-gtk -r
      exec --no-startup-id /usr/libexec/xdg-desktop-portal-wlr -r
      exec --no-startup-id "sh -c 'sleep 5;exec --no-startup-id /usr/libexec/xdg-desktop-portal -r'"

      exec --no-startup-id xdg-user-dirs-update

      # Start XDG autostart .desktop files using dex. See also
      # https://wiki.archlinux.org/index.php/XDG_Autostart
      exec --no-startup-id dex --autostart --environment sway
    '';
    ".config/sway/custom.d/daskeyboard4.conf".text = ''
      # SwayWM input configuration for the DasKeyboard 4 Ultimate.
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # Play-Pause, Next and Previous buttons
      bindcode 171 exec playerctl next
      bindcode 172 exec playerctl play-pause
      bindcode 173 exec playerctl previous

      # Mute, Decrease Volume, Increase Volume
      bindcode 121 exec pactl set-sink-mute `pactl list sinks short | grep RUNNING | awk '{print $1}' | head -n 1` toggle
      bindcode 122 exec pactl set-sink-volume `pactl list sinks short | grep RUNNING | awk '{print $1}'| head -n 1` -2%
      bindcode 123 exec pactl set-sink-volume `pactl list sinks short | grep RUNNING | awk '{print $1}'| head -n 1` +2%

      # The suspend key should work correctly with no need to bind it.
    '';
    ".config/sway/custom.d/mxmaster3.conf".text = ''
      # SwayWM input configuration for the Logitech MX Master 3.
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # Remember, --whole-window is required to work
      bindcode --whole-window 275 workspace prev_on_output
      bindcode --whole-window 276 workspace next_on_output
    '';
    ".config/sway/custom.d/sony_wh700.conf".text = ''
      # SwayWM input configuration for the Sony WH700 Headset.
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # Please note that these are standard XF86Audio controls
      # they should work by default but for some reason I had to
      # rebind them.
      bindcode 208 exec playerctl play
      bindcode 209 exec playerctl pause
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
    ".config/sway/barschemes.d/kali-dark_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # The old sway bar configuration is kept for archiving purposes, it works
      # fine, so if you want, you can activate it and comment the 'waybar' line on
      # the main configuration.

      bar {
          position top
          font $font
          height 28

          colors {
      # Kali Dark Theme
              background #171421
              statusline #E6E6E6
              separator  #696969
      #       <colorclass>        <border>    <background>    <text>
              focused_workspace   #367bf0     #367bf0         #1f2229
              active_workspace    #5ebdab     #367bf0         #1f2229
              inactive_workspace  #171421     #171421         #8a8a8a
              urgent_workspace    #000000     #363636         #FF0000
              binding_mode        #000000     #dc322f         #FFFFFF
          }
          status_command SCRIPT_DIR=$HOME/.local/libexec/i3blocks i3blocks -c $HOME/.config/i3blocks/config
      #    status_command while $HOME/.local/bin/status_bar.sh; do sleep 1; done
      }
    '';
    ".config/sway/barschemes.d/pop_OS-dark_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # The old sway bar configuration is kept for archiving purposes, it works
      # fine, so if you want, you can activate it and comment the 'waybar' line on
      # the main configuration.

      bar {
          position top
          font $font
          height 28

          colors {
      # Pop!_OS Dark Theme
              background #363636
              statusline #cccccc
              separator  #666666
      #       <colorclass>        <border>    <background>    <text>
              focused_workspace   #222222     #FFD7A1         #222222
              active_workspace    #FFD7A1     #222222         #FFD7A1
              inactive_workspace  #FFD7A1     #222222         #FFD7A1
              urgent_workspace    #000000     #363636         #FF0000
              binding_mode        #000000     #dc322f         #FFFFFF
          }
          status_command SCRIPT_DIR=$HOME/.local/libexec/i3blocks i3blocks -c $HOME/.config/i3blocks/config
      #    status_command while $HOME/.local/bin/status_bar.sh; do sleep 1; done
      }
    '';
    ".config/sway/barschemes.d/solarized_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # The old sway bar configuration is kept for archiving purposes, it works
      # fine, so if you want, you can activate it and comment the 'waybar' line on
      # the main configuration.

      bar {
          position top
          font $font
          height 28

          colors {
      # Solarized Dark Theme
              background #1f2229
              statusline #fdf6e3
              separator  #93a1a1
      #       <colorclass>        <border>    <background>    <text>
              focused_workspace   #000000     #657b83         #fdf6e3
              active_workspace    #002b36     #93a1a1         #93a1a1
              inactive_workspace  #073642     #002b36         #657b83
              urgent_workspace    #000000     #363636         #FF0000
              binding_mode        #000000     #dc322f         #FFFFFF
          }
          status_command SCRIPT_DIR=$HOME/.local/libexec/i3blocks i3blocks -c $HOME/.config/i3blocks/config
      #    status_command while $HOME/.local/bin/status_bar.sh; do sleep 1; done
      }
    '';
    ".config/sway/barschemes.d/standard_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # The old sway bar configuration is kept for archiving purposes, it works
      # fine, so if you want, you can activate it and comment the 'waybar' line on
      # the main configuration.

      bar {
          position top
          font $font
          height 28

          colors {
      # Default Theme
              background #171421
              statusline #E6E6E6
              separator  #696969
      #       <colorclass>        <border>    <background>    <text>
              focused_workspace   #83CAFA     #51A2DA         #FFFFFF
              active_workspace    #3C6EB4     #294172         #FFFFFF
              inactive_workspace  #8C8C8C     #4C4C4C         #888888
              urgent_workspace    #000000     #363636         #FF0000
              binding_mode        #000000     #dc322f         #FFFFFF
          }
          status_command SCRIPT_DIR=$HOME/.local/libexec/i3blocks i3blocks -c $HOME/.config/i3blocks/config
      #    status_command while $HOME/.local/bin/status_bar.sh; do sleep 1; done
      }
    '';
    ".config/sway/barschemes.d/waybar_barscheme.conf".text = ''
      # SwayWM status bar configuration. For detailed information type "man sway-bar"
      # Author: Oscar Carballal Prego <oscar.carballal@protonmail.com>

      # The old sway bar configuration is kept for archiving purposes, it works
      # fine, so if you want, you can activate it and comment the 'waybar' line on
      # the main configuration.

      bar {
          position top
          font $font
          height 28

          swaybar_command waybar
      }
    '';
  };
}
