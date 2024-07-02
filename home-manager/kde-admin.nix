{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.kdePackages.isoimagewriter
    pkgs.kdePackages.kclock
    pkgs.kdePackages.kget
    pkgs.kdePackages.kgpg
    pkgs.kdePackages.kleopatra
    pkgs.kdePackages.kompare
    pkgs.kdePackages.ktimer
    pkgs.kdePackages.ktorrent
    pkgs.kdePackages.partitionmanager
  ];
}
