{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.kdePackages.kblocks
    pkgs.kdePackages.kigo
    pkgs.kdePackages.kmahjongg
    pkgs.kdePackages.kmines
    pkgs.kdePackages.knavalbattle
    pkgs.kdePackages.kolf
    pkgs.kdePackages.kpat
    pkgs.kdePackages.ksudoku
  ];
}
