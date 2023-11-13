{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
#with lib.hm.gvariant;
{
  imports = [
    ./vim-config.nix
  ];
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [
    emacs-gtk
    texlive.combined.scheme-full
    vscode-with-extensions
  ];
}
