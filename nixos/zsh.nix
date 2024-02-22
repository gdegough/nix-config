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
    pkgs.zsh
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
    pkgs.zsh-powerlevel10k
  ];
  programs.zsh.enable = true; # the zsh shell
  environment.pathsToLink = [ "/share/zsh" ];
}
