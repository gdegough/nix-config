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
      displayManager = { ## for GDM
        gdm = {
          enable = true;
          wayland = true;
          # autoSuspend = false; 
        };
      };
    };
    # displayManager = { # for SDDM
    #   sddm = {
    #     enable = true;
    #     wayland.enable = true;
    #   };
    # };
  };
}
