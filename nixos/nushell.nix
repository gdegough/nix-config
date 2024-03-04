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
    pkgs.carapace
  ];
  programs.nushell = {
    enable = true; # the nu shell
  };
  environment.pathsToLink = [ "/share/nushell" ];
}
