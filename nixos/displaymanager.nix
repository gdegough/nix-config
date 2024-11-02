{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      # displayManager = { ## for GDM
      #   gdm = {
      #     enable = true;
      #     wayland = true;
      #     # autoSuspend = false; 
      #   };
      };
    };
    displayManager = { # for SDDM
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    # displayManager = { # for COSMIC-greeter
    #   cosmic-greeter = {
    #     enable = true;
    #   };
    # };
    displayManager = { ## choose the default session ("gnome", "plasma", "sway", "cosmic")
      defaultSession = "plasma";
    };
  };
}
