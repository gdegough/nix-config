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
  programs.nushell.enable = true; # the nu shell
  programs.carapace.enable = true; # completion
  programs.carapace.enableNushellIntegration = true;
  programs.carapace.enableBashIntegration = true;
  programs.carapace.enableZshIntegration = true;
  environment.pathsToLink = [ "/share/nushell" ];
}
