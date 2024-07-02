{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    # pkgs.kdePackages.kdevelop # currently broken
    pkgs.kdePackages.kontrast
    pkgs.kdiff3
    pkgs.okteta
    # pkgs.kdePackages.umbrello # currently broken
  ];
}
