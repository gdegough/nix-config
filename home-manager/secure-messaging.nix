{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
#with lib.hm.gvariant;
{
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [
    signal-desktop
  ];
}
