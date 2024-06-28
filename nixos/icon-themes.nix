{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.candy-icons
    pkgs.gruvbox-plus-icons
    pkgs.tela-icon-theme
    pkgs.tela-circle-icon-theme
    pkgs.weather-icons
  ];
}
