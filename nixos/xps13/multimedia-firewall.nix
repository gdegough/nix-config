{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # For spotify
  networking.firewall.allowedTCPPorts = [
    57621 # to sync local tracks from your filesystem with mobile devices in the same network
  ];
  networking.firewall.allowedUDPPorts = [
    5353 # to enable discovery of cast and possibly other connect devices in the same network
  ];
}
