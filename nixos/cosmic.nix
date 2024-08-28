{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./displaymanager.nix
    ./icon-themes.nix
  ];

  services = {
    desktopManager = {
      cosmic = {
        enable = true; # COSMIC
      };
    };
    # displayManager = {
    #   defaultSession = "COSMIC"; # Make COSMIC the default session
    # };
  };

  environment.systemPackages = [
    # Add any desired extra packages here
  ];
}
