{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: 
{
  # enable sway window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
