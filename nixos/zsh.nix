{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
{
  environment.systemPackages = [
    pkgs.zsh
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
    pkgs.zsh-powerlevel10k
  ];
  programs.zsh.enable = true; # the zsh shell
  environment.pathsToLink = [ "/share/zsh" ];
}
