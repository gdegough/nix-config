{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./vim-config.nix
    ./helix-config.nix
  ];
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = [
    pkgs.emacs-nox
  ];
}
