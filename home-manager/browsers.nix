{
  config,
  pkgs,
  ...
}:
{
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = [
    pkgs.firefox
    pkgs.google-chrome
    # pkgs.vivaldi
    # pkgs.vivaldi-ffmpeg-codecs
  ];
  # Make Firefox use the default portal file picker.
  # Preferences source: https://wiki.archlinux.org/title/firefox#KDE_integration
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "widget.use-xdg-desktop-portal.file-picker" = 1;
        };
      };
    };
  };
}
