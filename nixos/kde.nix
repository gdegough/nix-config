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
      plasma6 = {
        enable = true; # KDE
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "kde"; # use QT settings from Plasma
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
    pkgs.kde-gruvbox
    pkgs.pinentry-qt
    pkgs.qgnomeplatform
    pkgs.qgnomeplatform-qt6
    pkgs.wev
    pkgs.sddm-chili-theme
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font  = "Noto Sans";
      fontSize = "9";
      background = "${./gruvbox_neighborhood.jpg}";
      loginBackground = true;
    })
  ];
  environment.plasma6.excludePackages = [
    pkgs.kdePackages.plasma-browser-integration
  ];
}
