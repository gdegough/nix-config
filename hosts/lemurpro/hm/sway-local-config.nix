{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/sway/outputs.conf".text = ''
      # SwayWM outputs configuration. For detailed information type "man sway"
      # For a list of devices run: swaymsg -t get_outputs

      # Monitor definition
      output eDP-1 resolution 1920x1080 scale 1 position 0,0
    '';
    ".config/sway/config.d/laptop-brightnessctl.conf".text = ''
      # Backlight - you should install a display backlight app that allows the user to run without SUID
      bindsym XF86MonBrightnessDown exec --no-startup-id /bin/sh -c "brightnessctl -q set 2%- && ( echo $((`brightnessctl get` * 100 / `brightnessctl m`)) > $SWAYSOCK.wob )"
      bindsym XF86MonBrightnessUp exec --no-startup-id /bin/sh -c "brightnessctl -q set +2% && ( echo $((`brightnessctl get` * 100 / `brightnessctl m`)) > $SWAYSOCK.wob )"
    '';
    ".config/sway/config.d/laptop-inputs.conf".text = ''
      # SwayWM laptop input configuration. For detailed information type "man sway-input"
      # For a list of devices run: swaymsg -t get_inputs

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
    ".config/sway/config.d/laptop-outputs.conf".text = ''
      # SwayWM laptop outputs configuration. For detailed information type "man sway"
      # For a list of devices run: swaymsg -t get_outputs

      # Devices
      set $display_laptop eDP-1
      set $display_external DP-1

      # Disable main laptop screen
      bindsym $mod+F7 output $display_laptop disable
      bindsym $mod+F8 output $display_laptop enable
    '';
  };
}
