{
  inputs
  , lib
  , config
  , pkgs
  , ...
}:
#with lib.hm.gvariant;
{
  imports = [
    ./beets-package-and-config.nix
    ./easyeffects-package-and-config.nix
  ];
  home.packages = with pkgs; [
    audacious
    celluloid
    easytag
    fluidsynth
    helvum
    libdvdcss
    mpv
    plexamp
    qsynth
    quodlibet-full
    rhythmbox
    soundfont-fluid
    vlc
    vmpk
  ];
};
