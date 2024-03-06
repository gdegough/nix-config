{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/hypr/hyprland.conf".text = ''
      #
      # Please note not all available settings / options are set here.
      # For a full list, see the wiki
      #

      # Separate monitor definition (allows
      # keeping all other settings in one file)
      source = $HOME/.config/hypr/monitor.conf

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      exec-once = waybar --config $HOME/.config/waybar/hyprland_config --style $HOME/.config/waybar/solarized-dark.css
      exec-once = dunst
      exec-once = hyprpaper
      #exec-once = tidal-hifi
      exec-once = plexamp
      exec-once = easyeffects
      exec-once = qalculate-gtk
      exec-once = bitwarden

      $lockscreenbg = $HOME/.config/hypr/lockscreen

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = XCURSOR_SIZE,24

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model = pc104
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = no
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 5
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = dwindle

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10
          
          blur {
              enabled = true
              size = 3
              passes = 1
          }

          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = false
          orientation = left
          mfact = 0.5
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers
      }

      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      #device {
      #    name = kensington-expert-mouse
      #    sensitivity = -0.5
      #}

      input {
          touchpad {
              disable_while_typing = true
              tap-to-click = false
              clickfinger_behavior = true
          }
      }

      # Window rules
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

      # Bitwarden
      windowrulev2 = size 900 600, class:(Bitwarden)$
      windowrulev2 = workspace special:magic silent, class:(Bitwarden)$
      windowrulev2 = float, class:(Bitwarden)$
      windowrulev2 = move 10 40, class:(Bitwarden)$

      # tidal-hifi
      windowrulev2 = size 1200 750, class:(tidal-hifi)$
      windowrulev2 = workspace special:magic silent, class:(tidal-hifi)$
      windowrulev2 = float, class:(tidal-hifi)$
      windowrulev2 = move 10 100%-760, class:(tidal-hifi)$

      # Plexamp
      windowrulev2 = size 250 500, class:(Plexamp)$
      windowrulev2 = workspace special:magic silent, class:(Plexamp)$
      windowrulev2 = float, class:(Plexamp)$
      windowrulev2 = move 10 100%-510, class:(Plexamp)$

      # Easy Effects
      windowrulev2 = size 1280 800, class:(easyeffects)$
      windowrulev2 = workspace special:magic silent, class:(easyeffects)$
      windowrulev2 = float, class:(easyeffects)$
      windowrulev2 = move 100%-1290 40, class:(easyeffects)$

      # qalculate-gtk
      windowrulev2 = size 900 575, class:(qalculate-gtk)$
      windowrulev2 = workspace special:magic silent, class:(qalculate-gtk)$
      windowrulev2 = float, class:(qalculate-gtk)$
      windowrulev2 = move 100%-910 100%-585, class:(qalculate-gtk)$

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Slash, exec, rofi -show combi -modes "combi,window,ssh,drun,run" -combi-modes "window,ssh,drun,run"
      bind = $mainMod, Q, killactive, 
      bind = $mainMod SHIFT, E, exec, exit-prompt-hyprland
      bind = $mainMod, F, exec, nautilus
      bind = $mainMod, M, togglefloating, 
      #bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle

      # Binds for special apps
      bind = $mainMod, Return, exec, alacritty
      bind = $mainMod, B, exec, firefox
      bind = $mainMod, Z, exec, [size 900 600;workspace special:magic silent;float;move 10 40] bitwarden
      bind = $mainMod, P, exec, [size 250 500;workspace special:magic silent;float;move 10 100%-510] plexamp
      #bind = $mainMod, P, exec, [size 1200 750;workspace special:magic silent;float;move 10 100%-760] tidal-hifi 
      bind = $mainMod, Backslash, exec, [size 1280 800;workspace special:magic silent;float;move 100%-1290 40] easyeffects
      bind = $mainMod, C, exec, [size 900 600;workspace special:magic silent;float;move 100%-910 100%-610] qalculate-gtk

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      #
      # Switch to window resize submap
      #
      bind = $mainMod, R, submap, resize
      # submap called "resize"
      submap = resize
      # sets repeatable binds for resizing the active window
      binde = , right, resizeactive, 20 0
      binde = , left, resizeactive, -20 0
      binde = , up, resizeactive, 0 -20
      binde = , down, resizeactive, 0 20
      # use reset to go back to the global submap
      bind = $mainMod, R, submap, reset
      bind = , Escape, submap, reset
      bind = , Return, submap, reset 
      # reset the submap, meaning end the current one and return to the global one
      submap = reset

      #
      # Screen brightness 
      #
      $brightness_step = 5

      # using 'light'
      #$brightness_notification_cmd = command -v ${pkgs.libnotify}/bin/notify-send >/dev/null && VALUE="$(${pkgs.light}/bin/light)" && VALUE="''${VALUE%%.*}" && ${pkgs.libnotify}/bin/notify-send -e -h string:x-canonical-private-synchronous:brightness -h "int:value:$VALUE" -t 800 "Brightness: ''${VALUE}%"
      #bindl = , XF86MonBrightnessDown, exec, STEP="$brightness_step" && ${pkgs.light}/bin/light -U "''${STEP:-5}" && $brightness_notification_cmd
      #bindl = , XF86MonBrightnessUp, exec, STEP="$brightness_step" && ${pkgs.light}/bin/light -A "''${STEP:-5}" && $brightness_notification_cmd

      # using 'brightnessctl'
      $brightness_notification_cmd = command -v ${pkgs.libnotify}/bin/notify-send >/dev/null && VALUE=$(`which brightnessctl` -m | cut -d ',' -f 4) && VALUE=''${VALUE%?} && ${pkgs.libnotify}/bin/notify-send -e -h string:x-canonical-private-synchronous:brightness -h "int:value:$VALUE" -t 800 "Brightness: ''${VALUE}%"
      bindl = , XF86MonBrightnessDown, exec, STEP="$brightness_step" && `which brightnessctl` set ''${STEP:-5}%- && $brightness_notification_cmd
      bindl = , XF86MonBrightnessUp, exec, STEP="$brightness_step" && `which brightnessctl` set +''${STEP:-5}% && $brightness_notification_cmd

      #
      # Multimedia keys
      # Audio
      $volume_helper_cmd = volume-helper-hyprland
      bindle = , XF86AudioRaiseVolume, exec, $volume_helper_cmd --limit "$volume_limit" --increase "$volume_step"
      bindle = , XF86AudioLowerVolume, exec, $volume_helper_cmd --limit "$volume_limit" --decrease "$volume_step"
      bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

      # Media
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Move windows with keyboard
      bind = $mainMod SHIFT, left, movewindow, l
      bind = $mainMod SHIFT, right, movewindow, r
      bind = $mainMod SHIFT, up, movewindow, u
      bind = $mainMod SHIFT, down, movewindow, d

      # Cycle through active windows
      bind = ALT, Tab, cyclenext, next
      bind = ALT, Tab, alterzorder, 0

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Stores only text data
      exec-once = wl-paste --type text --watch cliphist store
      # Stores only image data
      exec-once = wl-paste --type image --watch cliphist store
      # Bind cliphist to hotkey and display under rofi
      bind = $mainMod SHIFT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy

      # Screen capture
      bind = , Print, exec, grim -g "$(slurp)" - | wl-copy

      # Authentication agent
      # If installed side-by-side with gnome
      exec-once = systemctl --user start polkit-gnome-authentication-agent-1.service
      # If installed side-by-side with plasma desktop
      # exec-once = systemctl --user start plasma-polkit-agent.service

      # bring in graphics settings
      exec-once = configure-gtk
      exec-once = systemctl --user start xsettingsd.service

      # Screen idle lock
      exec-once = swayidle -w timeout 900 "swaylock -f -i $lockscreenbg" timeout 1200 "hyprctl dispatch dpms off" resume "hyprctl dispatch dpms on" before-sleep "swaylock -f -i $lockscreenbg"
      # Lock the screen by keyboard
      bind = $mainMod, Delete, exec, swaylock -f -i $lockscreenbg

      exec = dbus-environment-hyprland
      exec = xdg-user-dirs-update
      # Start XDG autostart .desktop files using dex. See also
      # https://wiki.archlinux.org/index.php/XDG_Autostart
      exec-once = dex --autostart --environment hyprland
    '';
  };
}
