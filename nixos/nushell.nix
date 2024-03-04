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
  environment.pathsToLink = [ "/share/nushell" ];
}
