{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.kdePackages.kcalc
    pkgs.kdePackages.knotes
    pkgs.kdePackages.kongress
    pkgs.kdePackages.kontact
    pkgs.kdePackages.skanpage
    pkgs.kdePackages.zanshin
  ];
}
