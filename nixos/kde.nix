{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  services = {
    xserver = {
      enable = true;
    };
    desktopManager = {
      plasma6 = {
        enable = true; # KDE
      };
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "plasma"; # Make plasma-wayland the default session
    };
  };

  # Prefer seahorse's ssh-askpass. Resolves conflct with ksshaskpass if KDE is also installed 
  # programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.plasma6.ksshaskpass.out}/bin/ksshaskpass";
  # OR
  # Force git to use terminal to prompt for password
  programs.ssh.askPassword = "";

  programs.dconf.enable = true; # Enable gtk themes, etc., in Wayland apps

  environment.systemPackages = [
    pkgs.adwaita-qt
    pkgs.adwaita-qt6
    pkgs.adw-gtk3
    pkgs.kdePackages.kcolorchooser
    pkgs.kde-gruvbox
    pkgs.pinentry-qt
    pkgs.qgnomeplatform
    pkgs.qgnomeplatform-qt6
    pkgs.wev
  ];
  environment.plasma6.excludePackages = [
    pkgs.kdePackages.plasma-browser-integration
  ];
}
