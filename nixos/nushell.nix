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
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  environment.pathsToLink = [ "/share/nushell" ];
}
