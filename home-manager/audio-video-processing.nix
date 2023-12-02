{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
#with lib.hm.gvariant;
{
  imports = [
    ./abcde-package-and-config.nix
    ./makemkv-package-and-config.nix
  ];
  home.packages = with pkgs; [
    ardour
    audacity
    ccextractor
    dvdbackup
    fdk-aac-encoder
    lame
    mkvtoolnix
    obs-studio
    picard
    pitivi
  ];
}
