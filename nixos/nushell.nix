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
  programs = {
    nushell.enable = true; # the nu shell
    carapace.enable = true; # completion
    carapace.enableNushellIntegration = true;
  };
  environment.pathsToLink = [ "/share/nushell" ];
}
