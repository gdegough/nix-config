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
}
