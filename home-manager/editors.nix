{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./vim-config.nix
  ];
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = [
    pkgs.emacs-gtk
    pkgs.texlive.combined.scheme-full
    pkgs.vscode-with-extensions
  ];
}
