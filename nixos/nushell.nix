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
    pkgs.nushell
  ];
  programs.nushell.enable = true; # the nu shell
  environment.pathsToLink = [ "/share/nushell" ];
}
