{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./easyeffects-package-and-config.nix
  ];
  home.packages = [
    # pkgs.audacious
    pkgs.easytag
    pkgs.fluidsynth
    pkgs.helvum
    pkgs.libdvdcss
    pkgs.mpv
    pkgs.plexamp
    pkgs.qsynth
    # pkgs.quodlibet-full
    pkgs.soundfont-fluid
    pkgs.spotify
    pkgs.vlc
    # pkgs.vmpk
  ];
  # For spotify
  networking.firewall.allowedTCPPorts = [
    57621 # to sync local tracks from your filesystem with mobile devices in the same network
  ];
  networking.firewall.allowedUDPPorts = [
    5353 # to enable discovery of cast and possibly other connect devices in the same network
  ];
}
