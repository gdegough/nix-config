{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./abcde-package-and-config.nix
    ./beets-package-and-config.nix
    ./makemkv-package-and-config.nix
  ];
  home.packages = [
    pkgs.ardour
    pkgs.audacity
    pkgs.ccextractor
    pkgs.dvdbackup
    pkgs.fdk-aac-encoder
    pkgs.lame
    pkgs.mkvtoolnix
    pkgs.obs-studio
    pkgs.picard
    pkgs.pitivi
  ];
}
