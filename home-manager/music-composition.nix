{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./timidity-config.nix
  ];
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = [
    pkgs.stable.python311Packages.pygame
    pkgs.frescobaldi
    pkgs.lilypond
  ];
}
