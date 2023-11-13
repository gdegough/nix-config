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
  ];
  home.packages = with pkgs; [
    ardour
    audacity
    ccextractor
    dvdbackup
    fdk-aac-encoder
    lame
    makemkv
    mkvtoolnix
    obs-studio
    picard
    pitivi
  ];
}
