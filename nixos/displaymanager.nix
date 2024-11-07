{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  ## for SDDM
  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font  = "Noto Sans";
      fontSize = "9";
      # background = "${./gruvbox_neighborhood.jpg}";
      loginBackground = true;
    })
  ];
  services = {
    xserver = {
      enable = true;
      # displayManager = { ## for GDM
      #   gdm = {
      #     enable = true;
      #     wayland = true;
      #     # autoSuspend = false; 
      #   };
      # };
    };
    displayManager = { # for SDDM
      sddm = {
        enable = true;
        theme = "catppuccin-mocha";
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
